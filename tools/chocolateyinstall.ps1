$ErrorActionPreference = 'Stop';

$version = "4.0.1124"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"

$checksums = @{
  en = 'EBB66C295D83527D7BD5BD54FC072804BEDC6BEEE2A0100009DA77DBE4431B20'
  de = 'E90072D22DD31E3A23202C2DD07A5D494E37A7F85935B66FCD9DDE087515E063'
  fr = 'BC364FE4715B81188A9C765328D85616AFE6C96F44A249183915FF4154679086'
  it = '6771E2EB790C788B81F8553F80A3236E80F1EBDF24BD92C7D8336B1C9D6AB062'
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