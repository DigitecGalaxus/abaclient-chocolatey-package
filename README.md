# AbaClient Chocolatey Package
![Chocolatey Version](https://img.shields.io/chocolatey/v/abaclient?label=chocolatey)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/DigitecGalaxus/abaclient-chocolatey-package/main.yml)

This repository contains the source code for a Chocolatey package that installs and updates the AbaClient from Abacus Business Software. Feel free to make adjustments and improvements to the code in this repository.

## Installation
You can install the AbaClient package using Chocolatey. Make sure you have Chocolatey installed on your system. If you don't have it, you can get it from [chocolatey.org](https://chocolatey.org/).
Once Chocolatey is installed, run the following command in your command prompt or PowerShell:

```bash
choco upgrade abaclient
```

## Updating the Package
A scheduled GitHub Actions workflow checks the [Abacus downloads page](https://downloads.abacus.ch/en/downloads/abaclient/) weekly. If that version isn't already published on [Chocolatey](https://community.chocolatey.org/packages/abaclient), the same workflow run packs and publishes it directly — no git tag is created.

`tools/chocolateyinstall.ps1` has no hardcoded version or checksums — its `#{VERSION}#` placeholder is filled in at pack time, the same way the version in `abaclient.nuspec` is.

To manually release a specific version instead of waiting for the schedule, trigger the "Publish Chocolatey Package" workflow via `workflow_dispatch` with the desired tag as input, or push a git tag matching the version directly:
```bash
git tag 3.0.940
git push origin 3.0.940
```

## Contributing
Contributions to this repository are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.