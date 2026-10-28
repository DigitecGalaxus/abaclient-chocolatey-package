$ErrorActionPreference = 'Stop';

$version = "4.4.1221"

$checksums = @{
  en = '1ebef08e962802d56bd28aea60725e03f3d65a284f4806bf153c182823b5fd8f'
  de = 'f789bbefd848c68f4dae372449c503ba9f450979bb87e8f338f6e483fe5855ad'
  fr = '7dd2a1a7ea3435ba8e64d4c7c4e5b90ab7f051395567c7fbc0c78689d89b68e2'
  it = 'f99229212ffa0473dd11eeda77d05377ac8c70f3a02f60023face165ff418da0'
}

# Accepted values for /Language (hashtable keys are case-insensitive)
$languageAliases = @{
  en = 'en'; english = 'en'
  de = 'de'; german  = 'de'
  fr = 'fr'; french  = 'fr'
  it = 'it'; italian = 'it'
}

$pp = Get-PackageParameters
$language = $null

if ($pp['Language'] -is [string] -and $pp['Language'].Trim()) {
  $requested = $pp['Language'].Trim().ToLower()
  $language = $languageAliases[$requested]
  if (!$language) {
    throw "Unsupported value '$requested' for /Language. Accepted values: $(($languageAliases.Keys | Sort-Object) -join ', ')."
  }
} else {
  if ($pp.ContainsKey('Language')) {
    Write-Warning "/Language was passed without a value, detecting language from the system locale instead."
  }
  $language = (Get-WinSystemLocale).Name.Substring(0, 2).ToLower()
  if (!$checksums.ContainsKey($language)) {
    Write-Warning "No AbaClient installer is available for system locale language '$language', using 'en'. Use --params `"'/Language:<en|de|fr|it>'`" to choose a language."
    $language = 'en'
  }
}

Write-Host "Installing AbaClient language '$language'"

$url = "https://downloads.abacus.ch/fileadmin/ablage/dokumente/05_abaclient/abaclient-$version-$language.msi"
$checksum = $checksums[$language]

Install-ChocolateyPackage -packageName $env:ChocolateyPackageName `
  -fileType 'MSI' `
  -url $url `
  -softwareName "ABACUS AbaClient version $version" `
  -checksum $checksum `
  -checksumType 'sha256' `
  -silentArgs "/quiet /passive /norestart /l `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" `
  -validExitCodes @(0, 3010, 1641)
