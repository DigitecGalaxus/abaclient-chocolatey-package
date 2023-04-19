$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = "3.0.940"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"

$checksums = @{
  en = 'a5abc89b5084a5d1bf96e3cf9d401748f062564a2421d883ca80792de761822a'
  de = '497da4cc77207f9e349fb10f60f9d549b93657a596ee343a127e39d41ba1ad0e'
  fr = 'abeb6369c691bb8fc014ad10815cc95a396a2f9c6c96bb154e08bb57aed4c25d'
  it = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
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
