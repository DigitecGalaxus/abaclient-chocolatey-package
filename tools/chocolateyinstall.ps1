$ErrorActionPreference = 'Stop';

$version = "4.3.1194"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"

$checksums = @{
  en = 'D42AB865C40F8BFA7BA3432EBE09D0ED8421932003E0DC9DE4A625C8A02D2AF7'
  de = '4485D101907A2DF83A36DF39F329CEFBD86DE0EDB62579290615A7FD55E56D60'
  fr = '1F431A98E75DA0665EC1283D95C119E815387B231A3E4A552AF90CDCF4B59BD9'
  it = 'FF64DFF74C517288C750602198D832076726920422C29D47708EA348ED7B271D'
}

$checksum = $checksums[$language]

Install-ChocolateyPackage -packageName $env:ChocolateyPackageName `
  -fileType 'MSI' `
  -url $url `
  -softwareName "ABACUS AbaClient version $version" `
  -checksum $checksum `
  -checksumType 'sha256' `
  -silentArgs "/quiet /passive /norestart /l `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" `
  -validExitCodes= @(0, 3010, 1641)