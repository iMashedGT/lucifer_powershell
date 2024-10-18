# Powershell Lucifer Lazy People

This PowerShell script automates the downloading, installation, and configuration of several applications and Windows settings. It is ideal for initial setup needs, including configuring essential applications, disabling certain Windows features, and downloading and extracting files from MEGA.nz.

## Features

- **Automatic Installation**:
  - **VC Redist 2015-2022**: Checks if it is already installed; if not, it downloads and installs it.
  - **Google Chrome**: Checks if it is already installed; if not, it downloads and installs it.
  - **MEGAcmd**: Checks if it is already installed; if not, it downloads and installs it.
  
- **Downloading and Extracting from MEGA**:
  - Downloads files from MEGA.nz using `MEGAcmd`.
  - Provides a list of files to be downloaded in the `$DownloadMegaList` variable.
  - Includes an option to download additional files like `gmailog` (simply remove the `#` to enable the download).
  - Extracts ZIP file contents directly into a folder without additional subfolders.

- **Windows Settings**:
  - Disables **Windows Defender** and **Firewall**.
  - Configures power settings to disable monitor timeouts and hibernate.
  - Restarts the system after completing the configuration.

## List of Files Downloaded from MEGA

1. **Lucifer**: The main file.
2. **steamlog**: Additional logs from Steam.
3. **gmailog** (optional): Additional logs from Gmail; remove the `#` in the list section if needed.

## Prerequisites

- **Windows PowerShell** running as **Administrator**.
- An active internet connection to download the required applications and files.
- MEGAcmd will be installed if not already present on the system.

## Usage

1. **Clone or download this script** and save it as a `.ps1` file (e.g., `setup.ps1`).
2. **Open PowerShell as Administrator**.
3. **Run the script** using the following command:

   ```powershell
   .\setup.ps1
   ```

4. The script will automatically check and install required applications, download files from MEGA.nz, and configure Windows settings.
5. After completing, the script will restart the computer to apply changes.

## Important Notes

- **Be cautious with Windows Defender and Firewall settings**: This script disables Windows Defender's real-time protection and turns off the firewall, which may reduce system security. Ensure you understand the risks before running the script.
- **Script Customization**: To download `gmailog`, remove the `#` in the `$DownloadMegaList` section.
- **Extraction Location**: All files downloaded from MEGA.nz will be extracted into the `Luciferimas` folder on the Desktop without additional subfolders.

## Troubleshooting

- If applications are not installed correctly or there are issues downloading files from MEGA.nz, check your internet connection and ensure the script is run with **Administrator** privileges.
- If the script closes automatically after running, add `Read-Host` at the end of the script to pause execution for debugging.
