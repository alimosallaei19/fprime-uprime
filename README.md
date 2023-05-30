# U Prime

A set of command line utilities for F Prime to help with faster deployment and development. Many of these are meant to help with out-of-the-box deployments, and don't offer much customization. Feel free to edit the scripts as you please to customize to your specific deployment.

## Installation

```
sudo chmod +x INSTALL.sh
./INSTALL.sh
```

Make sure that /usr/bin is in your path!

## Usage

All commands start with "uprime". These are the possible flags.

| Flag | Example Usage | Description |
| ---- | ------------- | ----------- |
| --gds | uprime --gds   | Opens a GDS server given a *linux* cross compiled deployment. To be ran in the deployment folder.            |
| --toolchains | uprime --toolchains | Installs cross-compilers for the arm64 architecture. To be ran in the root folder of the project. |
| --ports | uprime --ports [--remove] [port1] [port2] ... | Opens the ports for usage by GDS and other F' utilities on the machine. To be ran anywhere. |

## Development

```
git clone https://gitlab.eecs.umich.edu/mxl-fprime/uprime.git
git checkout -b [uniqname/username]-[nameOfUtility]
```

Make sure to update `README.md` and the else case of `uprime.sh` with information about the utility added. Once done, create a merge request.
