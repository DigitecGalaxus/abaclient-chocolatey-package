$ErrorActionPreference = 'Stop';

$version = "3.2.996"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"

$checksums = @{
  en = 'E36736F9AE00A81D04D2C2DDD9933AF7AE3782CC4F2A57972EB588F45BACEDDA'
  de = 'D00631318DD077B4088543C5A5A05CD59D2E58D578657797C6A1BE2DE018427E'
  fr = 'E7E3BF6946C77C92FD1BA7C986A94711DD45708D58A3AF070F477C955A3CE472'
  it = 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855'
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