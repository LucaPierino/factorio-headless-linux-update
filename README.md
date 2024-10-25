# Factorio Headless Linux Update

This Bash script is designed to update the headless installation of Factorio on Linux. The script downloads the selected version of Factorio from the official website, extracts the archive contents, and updates the Factorio installation directory. Additionally, the script updates the `current_version` file with the selected version number.

## Prerequisites

- Bash
- `curl`
- `wget`
- `tar`

## Usage

1. Download the `factorio-headless-linux-update.sh` script to the Factorio installation directory. It is recommended to use an absolute path for the installation directory or create a subdirectory named `factorio` and place the script inside it.
   
2. Ensure the script has execute permissions. If not, set the execute permissions using the command:
   ```bash
   chmod +x factorio-headless-linux-update.sh
   ```

3. Run the script using the command:
   ```bash
   ./factorio-headless-linux-update.sh
   ```
   The script will display the currently installed version of Factorio and prompt for the version to install.

4. Type the version number you want to install or type `"list"` to display the available versions.

5. The script will download the selected version of Factorio, extract the archive contents, and update the Factorio installation directory.

6. The script will update the `current_version` file with the selected version number.

7. A completion message will be displayed when the update is finished.

## Note on Using the Current Directory

To use the current directory as the Factorio installation directory, simply navigate to the Factorio installation directory and run the script. The script will install the contents of Factorio in the `factorio` subdirectory of the current directory.
