$ErrorActionPreference = 'Stop';

$version = "3.3.1039"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"

$checksums = @{
  en = '7AA153786A04321B503F708FBC0D3ABB7AE580217CE095259B9714922FEC38FD'
  de = 'D188BFC6DDAA471B26022AD87E66FF763802ED255AF61E56AD2DC1980D53E557'
  fr = '98D04FA91BDFEC53B63032F0D911EC0F584871E6A3E294BD89103DCE26F02DE8'
  it = 'DAD8D003A9829388F6390F3C939346DA6557CF99E9A474AE4E653ABFB6511953'
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