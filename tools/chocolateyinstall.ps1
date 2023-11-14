$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = "3.1.987"
$language = (Get-WinSystemLocale | select -ExpandProperty Name | % { $_.substring(0,2) }).ToLower()
$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"

$checksums = @{
  en = '48252255CEACF853F7C61BEAC726F3E4B931B6383995B92313E8504AF559D56F'
  de = 'A1DB971D3B3F72F9C345DDBBAF340CEF0C8010AC0047580602A28E2CE9CD8791'
  fr = '08305305DE8B6ACE398FAE4F7AD9F5D351DC93DD1B2AF6295DD25F50066311E2'
  it = '19B9CB03C0AF6AEE9CBEDA87001DFBFC50B866BC8B7E3176B5207796CE2FA932'
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
