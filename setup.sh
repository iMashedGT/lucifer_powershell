ufw disable

username="imas"
password="imas"

if ! id -u $username &>/dev/null; then
    useradd -m -s /bin/bash $username
    echo "$username:$password" | chpasswd
    usermod -aG sudo $username
fi

timedatectl set-ntp true
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
apt update && apt install -y ./chrome.deb

echo "Proses selesai: firewall dinonaktifkan, ID/Password VPS sudah diset, dan Google Chrome sudah diinstal."
