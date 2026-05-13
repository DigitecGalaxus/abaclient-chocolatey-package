$ErrorActionPreference = 'Stop';

$version = "4.2.1165"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"

$checksums = @{
  en = 'A6D6860A2183B01FB90C0201D540148AD4EFD82959B4DE809975AA3811968619'
  de = '89EE8B62A0939DBA76979A0CEE77FC43397525A8A0DB2CD9D185B078FEAB26D9'
  fr = 'F32BF49FDD52DE05C80DFC8BBDC86A1E0E58C2970F284DE7B11AAF129BFB98DA'
  it = 'CA955711FE91FE6FE8AC6FDB1B646465FE207516FA2FA9BAA2888066AC449592'
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