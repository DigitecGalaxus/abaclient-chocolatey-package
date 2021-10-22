$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = "2.4.779"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://storage.googleapis.com/images.abasky.net/119676df089a90ab3c3004398806433938052586dcd9a6bcacfb0e3e4024f339/$version/abaclient-$version-$language.msi"

$checksums = @{
  en = '3650518F64561FA8209B929B47471C5C7867EB035D8091B24629760B8A668A5A'
  de = '5F4251D7E768B44E88603B78A6A868BAAAFBA80FC41FF28873D2495BB8ECA786'
  fr = '2B4DAA8A1D2FDEBBDD4C87D83C8F81B5548A7E64F4067BE3B338AE1C3C1DA926'
  it = 'DA34A84AC3C262B25AD22D5EB4236C935F152B05A94C500A8B932CC58370DFFB'
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
