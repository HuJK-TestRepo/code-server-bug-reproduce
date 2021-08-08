#!/bin/bash
apt-get update 
apt-get upgrade -y
apt install -y wget curl
wget -qO- https://deb.nodesource.com/setup_current.x | bash ; apt-get -y install nodejs

function get_cpu_architecture()
{
    local cpuarch=$(uname -m)
    case $cpuarch in
         x86_64)
              echo "amd64";
              ;;
         aarch64)
              echo "arm64";
              ;;
         *)
              echo "Not supported cpu architecture: ${cpuarch}"  >&2
              exit 1
              ;;
    esac
}
cpu_arch=$(get_cpu_architecture)

mkdir -p /etc/code-server-hub/.cshub
cd /etc/code-server-hub
echo "###doenload latest code-server###"
curl -s https://api.github.com/repos/cdr/code-server/releases/latest \
| grep "browser_download_url.*linux-${cpu_arch}.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -i - -O code-server.tar.gz

echo "###unzip code-server.tar.gz###"
tar xzvf code-server.tar.gz -C .cshub
mv .cshub/*/* .cshub/
rm -rf /root/.cache
rm -rf /root/.npm/_cacache