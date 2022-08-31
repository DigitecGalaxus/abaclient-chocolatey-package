$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = "2.5.850"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://storage.googleapis.com/images.abasky.net/119676df089a90ab3c3004398806433938052586dcd9a6bcacfb0e3e4024f339/$version/abaclient-$version-$language.msi"

$checksums = @{
  en = '965B85D0CF36809BDAFE842FEE2CFA982B827551FF0134E64A9D5194354C2C6B'
  de = '11D13884EC72E0A6FEE6523DF7C73D5EB56489B2BF2CA0F566C4D5B0CFD6A6F4'
  fr = '9CDB78D62371893ABB3B1A19FB11809617C1ABABD48C19AD27A64537F278B2EC'
  it = '38DAE4B38DC8E3CEB76A507C24E36D9C3300F567100B49E8EE87AE94D5B6556B'
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
