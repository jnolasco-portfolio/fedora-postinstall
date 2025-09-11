# Fedora Post-Installation Setup

This repository contains Ansible playbooks to automate the post-installation setup of a Fedora workstation. It includes tasks for installing basic software, development tools, GNOME extensions, and other utilities.

## 1. Fedora Installation

This guide provides instructions for installing Fedora, including a dual-boot setup with Windows.

### 1.1. Preparation

- **Backup Data**: Ensure all important files are backed up to avoid any data loss.
- **Handle BitLocker (If Enabled)**: If your Windows installation uses BitLocker encryption, you must suspend it before installation.
  - In Windows, open a Command Prompt as Administrator.
  - First, check if BitLocker is enabled on your drives:
    ```sh
    manage-bde -status
    ```
  - If it is enabled, suspend BitLocker on your Windows drive (e.g., `C:`):
    ```sh
    manage-bde -protectors -disable C:
    ```
  - After Fedora is installed and you can boot into both systems, re-enable BitLocker from Windows:
    ```sh
    manage-bde -protectors -enable C:
    ```
- **Resize Windows Partition**: To make space for Fedora, you need to shrink your existing Windows partition. This should be done from within Windows before you start the Fedora installation.
  1.  **Open Disk Management**: Press `Win + X` and select "Disk Management".
  2.  **Shrink the Partition**: Right-click on your main Windows partition (usually the `C:` drive) and select "Shrink Volume".
  3.  **Determine Shrink Size**: For a 2TB drive, you could leave about 500GB for Windows (200GB for OS and 300GB for Data) and allocate the rest to Fedora. Enter the amount to shrink in MB.
  4.  **Unallocated Space**: After shrinking, you will have unallocated space on your disk. You will install Fedora in this space.
- **Create a Fedora 42 Bootable USB**:
  - Download the Fedora 42 ISO from the official website.
  - Use tools like Rufus (for Windows) or the `dd` command (on Linux) to create a bootable USB.

### 1.2. BIOS/UEFI Settings (for Dual-Boot)

- Ensure **UEFI Mode** is enabled (not Legacy/CSM).
- Disable **Secure Boot** temporarily if needed.
- Disable **Fast Boot** & **Intel RST** if enabled.

### 1.3. Booting the Installer

- Insert the bootable USB and reboot your system.
- Access the boot menu and select the USB drive.
- Choose "Start Fedora Live" from the boot menu.

### 1.4. Installation

- In Fedora Live, select 'Install to Hard Drive'.
- Choose your language and keyboard layout.
- Select the installation destination. For a dual-boot setup, you can use custom partitioning to install Fedora alongside Windows.

### 1.5. Partitioning (for Dual-Boot with Windows)

- Select **Custom Partitioning**.
- Keep existing partitions: EFI, Microsoft reserved, Windows, and Recovery partitions.
- Use the free space for Fedora with Btrfs and set the mount point to `/`.
- Mount the existing EFI System Partition as `/boot/efi` without formatting it.
- The installer can create Btrfs subvolumes for `@` (root), `@home`, and `@var`.

#### Recommended Partition Scheme for a Large Drive

For users dedicating a large amount of space to Fedora (e.g., 1.5TB), here is a recommended layout that is simple, flexible, and leverages the power of the Btrfs filesystem:

*   **/boot/efi**: `1 GB` (FAT32) - Essential for UEFI booting.
*   **/boot**: `2 GB` (ext4) - For kernels and boot files.
*   **Btrfs Volume**: The rest of the space (e.g., ~1.497 TB) mounted at `/`.

The Fedora installer will automatically create `root` and `home` subvolumes within the Btrfs volume. This setup is highly flexible, as your system and personal data share the same large pool of space, and it allows for powerful features like filesystem snapshots for easy backups and rollbacks.

### 1.6. Bootloader Configuration

- The bootloader (GRUB) should be installed on the EFI partition.
- Fedora’s GRUB will automatically detect the Windows Boot Manager.

### 1.7. Finalizing Installation

- Complete the installation and restart, removing the USB.
- The GRUB menu will allow you to boot into Fedora or Windows.

### 1.8. Post-Installation Steps

- If Windows is not listed in the GRUB menu, run:
  ```sh
  sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
  ```
- Verify boot entries using:
  ```sh
  efibootmgr
  ```
- Update your new Fedora system:
  ```sh
  sudo dnf update
  ```

## 2. Automated Post-Installation Setup

This repository uses Ansible to automate the setup process.

### 2.1. Install Ansible

First, you need to install Ansible on your new Fedora system:

```sh
sudo dnf install ansible
```

### 2.2. Run the Playbooks

The `tasks` directory contains several Ansible playbooks for different purposes. You can run them using the `ansible-playbook` command. For example, to run the `fedora-basic.yaml` playbook:

```sh
ansible-playbook tasks/fedora-basic.yaml
```

### 2.3. Available Tasks

- **`fedora-basic.yaml`**: Installs essential packages and utilities.
- **`fedora-developer.yaml`**: Installs common development tools.
- **`fedora-extras.yaml`**: Installs extra packages and themes.
- **`fedora-gnome.yaml`**: Configures GNOME desktop environment.
- **`flatpaks.yml`**: Installs applications from Flatpak.
- **`gnome-extensions.yaml`**: Installs and enables a set of GNOME extensions.
- **`ollama.yaml`**: Installs and configures Ollama.

## 3. Oh My Zsh Plugins

The setup includes the installation of the following Oh My Zsh plugins:
- `git`
- `zsh-autosuggestions`
- `docker`
- `docker-compose`
- `kubectl`
- `kube-ps1`
- `mvn`
- `gradle`
- `ufw`
- `zsh-syntax-highlighting`
- `helm`
- `dnf`
- `gh`
- `httpie`
- `ng`
- `npm`
- `node`
- `nvm`
- `gitignore`

The following commands are used to install `zsh-autosuggestions` and `zsh-syntax-highlighting`:
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## 4. Ollama Installation

The `ollama.yaml` task installs Ollama and sets up a systemd service for it. The service unit is created from the `templates/ollama.service.j2` template.

## 5. GNOME Extensions

The `gnome-extensions.yaml` task installs the following GNOME extensions:
- `user-theme@gnome-shell-extensions.gcampax.github.com`
- `blur-my-shell@aunetx`
- `clipboard-history@alexsaveau.dev`
- `dash-to-dock@micxgx.gmail.com`
- `appindicatorsupport@rgcjonas.gmail.com`
- `gnome-ui-tune@itstime.tech`
- `compiz-alike-magic-lamp-effect@hermes83.github.com`
- `caffeine@patapon.info`
- `drive-menu@gnome-shell-extensions.gcampax.github.com`
- `system-monitor@gnome-shell-extensions.gcampax.github.com`
- `gnome-shell-go-to-last-workspace@github.com`
- `tilingshell@ferrarodomenico.com`
- `panel-workspace-scroll@polymeilex.github.io`
- `places-menu@gnome-shell-extensions.gcampax.github.com`
- `apps-menu@gnome-shell-extensions.gcampax.github.com`
- `background-logo@fedorahosted.org`
- `launch-new-instance@gnome-shell-extensions.gcampax.github.com`
- `window-list@gnome-shell-extensions.gcampax.github.com`

---

**Congratulations!** You now have a fully configured Fedora 42 workstation.