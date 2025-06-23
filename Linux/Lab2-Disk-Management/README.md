
# 📦  Lab 2 : Disk Management & LVM Setup 

  
## 🎯 Objective
  

This lab simulates a common task involving LVM and disk management:
- Add a new 6 GB disk  
- Split it into two partitions (2 GB and 3 GB)  
- Set up LVM using the 2 GB partition  
- Format it with the **XFS** filesystem and mount it  
- Extend the Logical Volume using the second partition while mounted  
- Ensure the mount is persistent via `/etc/fstab`  

---

  

## 🛠️ Environment

  

-  **OS:** RHEL / CentOS / Amazon Linux

-  **Privileges:** Root or sudo access

-  **Filesystem:** XFS

-  **Disk:** Additional disk (e.g., `/dev/xvdb`, size 6 GB)

  

---

  

## 🧭 Steps Overview

  

### 1️⃣ List Disks

  

Use `lsblk` to confirm the presence of the new 6 GB disk (e.g., `/dev/xvdb`).

  

---

  

### 2️⃣ Partition the Disk

  

Use `fdisk /dev/xvdb`:

  

- Create first partition → primary → +2G

- Create second partition → primary → +3G

- Write changes and exit.

- Run `partprobe` to reload the partition table.

  

---

  

### 3️⃣ Verify Partitions

  

Use `lsblk` again to confirm:

  

-  `/dev/xvdb1` → 2 GB

-  `/dev/xvdb2` → 3 GB

![Image](https://github.com/user-attachments/assets/45bf6c22-15aa-4a74-8eee-22b30c70db51)  

---

  

### 4️⃣ Create Physical Volumes

  

Initialize both partitions:

  

-  `pvcreate /dev/xvdb1`

-  `pvcreate /dev/xvdb2`

  

---

  

### 5️⃣ Create and Extend Volume Group

  

- Create volume group: `vgcreate vgdata /dev/xvdb1`

- Extend VG: `vgextend vgdata /dev/xvdb2`

  

---

  

### 6️⃣ Create Logical Volume

  

- Create LV: `lvcreate -L 1.9G -n lvdata vgdata`

  

---

  

### 7️⃣ Format with XFS

  

- Format the LV: `mkfs.xfs /dev/vgdata/lvdata`

  

---

  

### 8️⃣ Mount the Volume

  

- Create mount point: `/mnt/data`

- Mount: `mount /dev/vgdata/lvdata /mnt/data`

  

---

  

### 9️⃣ Extend LV and Filesystem

  

- Extend LV: `lvextend -L +2.9G /dev/vgdata/lvdata`

- Grow XFS: `xfs_growfs /mnt/data`

  

---

  

### 🔟 Verify Mount

  

- Run `df -h /mnt/data` to confirm the size is ~4.8G

![Image](https://github.com/user-attachments/assets/4af9e01f-c07e-45b4-aaf8-595bda3c439f)  

---

  

## ♻️ Persistent Mount Configuration

  

1. Get UUID:

-  `blkid /dev/vgdata/lvdata`

  

2. Edit `/etc/fstab`:

`UUID=<your-uuid-here> /mnt/data xfs defaults 0 0`

![Image](https://github.com/user-attachments/assets/34746c08-004a-4569-b71e-e1b52f39bbf2)
  
3. test

`umount /mnt/data`
`mount -a`
Confirm with `df -h /mnt/data`

![Image](https://github.com/user-attachments/assets/4af9e01f-c07e-45b4-aaf8-595bda3c439f) 