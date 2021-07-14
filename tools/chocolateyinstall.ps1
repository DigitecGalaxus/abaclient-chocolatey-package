$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = "2.3.730"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://storage.googleapis.com/images.abasky.net/119676df089a90ab3c3004398806433938052586dcd9a6bcacfb0e3e4024f339/$version/abaclient-$version-$language.msi"

$checksums = @{
  en = 'B144FF0AC7E12A665B997AC83A3F547C5855EE0591887895B966631A794532D8'
  de = '2A227EA838990B40724AFA3C9A7AEA767C960FF954045B1551C09555AAA3FCA6'
  fr = '68C3682B1FC617ECD885B81CB2864F93DAB935B8C2674100D404A443F5520D52'
  it = '6F290DAD9E23377F330E2A1AF705E7316FA26BB03ED3142787A84F39888E2684'
}

$packageArgs = @{
  fullZipPath   = "$toolsDir\abaclient.msi"
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  file          = "$toolsDir\abaclient-$version-$language.msi"

  softwareName  = "ABACUS AbaClient version $version"

  checksum      = $checksums[$language]
  checksumType  = 'sha256'

  silentArgs    = "/quiet /passive /norestart /l `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Get-ChocolateyWebFile `
  -PackageName $packageArgs.packageName `
  -FileFullPath $packageArgs.file `
  -Url $packageArgs.url

Get-ChecksumValid `
-File $packageArgs.file `
-Checksum $packageArgs.checksum `
-ChecksumType $packageArgs.checksumType `
-OriginalUrl $packageArgs.url

Install-ChocolateyInstallPackage `
  -PackageName $packageArgs.packageName `
  -FileType $packageArgs.fileType `
  -File $packageArgs.file `
  -SilentArgs $packageArgs.silentArgs `
  -ValidExitCodes $packageArgs.validExitCodes
