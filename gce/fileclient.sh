# Dependencies
sudo apt-get update -q
sudo apt-get install -qy \
	nano htop less locate xauth \
	ca-certificates curl wget bzip2 curl


# Mount shared disk
sudo apt-get install -qy sshfs nfs-common autofs
sudo mkdir /mnt/shared
sudo chmod a+rwx /mnt/shared
echo fileserver:/mnt/shared /mnt/shared nfs rw 0 0 | sudo tee -a /etc/fstab
echo /- /etc/auto.mount | sudo tee -a /etc/auto.master
echo "/mnt/shared -fstype=nfs,rw fileserver:/mnt/shared" | sudo tee -a /etc/auto.mount
systemctl restart autofs


# Misc
sudo updatedb
