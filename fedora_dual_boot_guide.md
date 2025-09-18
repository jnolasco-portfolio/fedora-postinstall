# Fedora 42 Dual Boot Installation Guide

## 1. Preparation

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

## 2. BIOS/UEFI Settings

- Ensure UEFI Mode is enabled (not Legacy/CSM) since your disk is GPT partitioned.
- Disable Secure Boot temporarily if needed.
- Disable Fast Boot & Intel RST if enabled.

## 3. Booting the Installer

- Insert the bootable USB and reboot your system.
- Access the boot menu and select the USB drive.
- Choose "Start Fedora Live" from the boot menu.

## 4. Start Installation

- In Fedora Live, select 'Install to Hard Drive'.
- Choose language and keyboard layout.
- Select the NVMe drive (/dev/nvme0n1) as the installation destination.

## 5. Partitioning

- Select Custom Partitioning.
- Keep Existing Partitions: /dev/nvme0n1p1 (EFI), /dev/nvme0n1p2 (Microsoft reserved), /dev/nvme0n1p3 (Windows), /dev/nvme0n1p4 (Recovery).
- Use /dev/nvme0n1p5 for Fedora with Btrfs and set the mount point to '/'.
- Mount EFI System Partition (/dev/nvme0n1p1) as /boot/efi without formatting.
- Create Btrfs Subvolumes for @ (root), @home, and @var.

### Recommended Partition Scheme for a Large Drive

For users dedicating a large amount of space to Fedora (e.g., 1.5TB), here is a recommended layout that is simple, flexible, and leverages the power of the Btrfs filesystem:

*   **/boot/efi**: `1 GB` (FAT32) - Essential for UEFI booting.
*   **/boot**: `2 GB` (ext4) - For kernels and boot files.
*   **Btrfs Volume**: The rest of the space (e.g., ~1.497 TB) mounted at `/`.

The Fedora installer will automatically create `root` and `home` subvolumes within the Btrfs volume. This setup is highly flexible, as your system and personal data share the same large pool of space, and it allows for powerful features like filesystem snapshots for easy backups and rollbacks.

## 6. Bootloader Configuration

- Install the bootloader on /dev/nvme0n1p1 (EFI partition).
- Fedora’s GRUB will auto-detect Windows Boot Manager.

## 7. Finalizing Installation

- Complete the installation and restart, removing the USB.
- GRUB menu will allow booting into Fedora or Windows.

## 8. Post-Installation Steps

- Update GRUB if Windows is not listed:
```sh
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```
- Verify boot entries using:
```sh
efibootmgr
```

## 9. Optional: Create Swap File

- To create a swap file on Btrfs:
```sh
sudo btrfs filesystem mkswapfile --size 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
- Add to /etc/fstab:
```
/swapfile none swap sw 0 0
```

## 10. Final Checks

- Verify Windows boots from GRUB without issues.
- Update Fedora using:
```sh
sudo dnf update
```

---

**Congratulations!** You now have Fedora 42 installed with Btrfs in dual boot with Windows 11.
