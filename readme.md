# AbaClient Chocolatey Package
![Chocolatey Version](https://img.shields.io/chocolatey/v/abaclient?label=chocolatey)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/DigitecGalaxus/abaclient-chocolatey-package/main.yml)

This repository contains the source code for a Chocolatey package that installs and updates the AbaClient from Abacus Business Software. Feel free to make adjustments and improvements to the code in this repository.

## Installation
You can install the AbaClient package using Chocolatey. Make sure you have Chocolatey installed on your system. If you don't have it, you can get it from [chocolatey.org](https://chocolatey.org/).
Once Chocolatey is installed, run the following command in your command prompt or PowerShell:

```bash
choco install abaclient
```

## Updating the Package
To release a new version of the AbaClient package, follow these steps:

1. Update the version number in the chocolateyinstall.ps1 file. Modify the $version variable to match the new version. For example:
```bash
$version = '3.0.940'
```

2. Update the checksums of the new installation files in the chocolateyinstall.ps1 file. Modify the $checksums variable accordingly.
```bash
$checksums = @{
  en = 'a5abc89b5084a5d1bf96e3cf9d401748f062564a2421d883ca80792de761822a'
  de = '497da4cc77207f9e349fb10f60f9d549b93657a596ee343a127e39d41ba1ad0e'
  fr = 'abeb6369c691bb8fc014ad10815cc95a396a2f9c6c96bb154e08bb57aed4c25d'
  it = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
}
```

3. Create a new GitHub tag that matches the new version number. You can use the following Git command to create the tag:
```bash
git tag 3.0.940
```

4. Commit your changes to the repository. Make sure you have staged all the changes you made in chocolateyinstall.ps1 and adapt the path in the git add command to the actual location of your chocolateyinstall.ps1 file:
```bash
git add tools/chocolateyinstall.ps1
git commit -m "Update version to 3.0.940"
```

5. Push the new tag and the committed changes to the remote repository:
```bash
git push origin 3.0.940
git push origin main
```

GitHub Actions will automatically build and publish the updated package to Chocolatey based on the newly created tag.

## Contributing
Contributions to this repository are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.