#/bin/bash
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
esac

if [ "${machine}" = "Mac" ]; then
	wget https://github.com/do-community/do-ansible-inventory/releases/download/v2.0.0/do-ansible-inventory_2.0.0_macos_x86_64.tar.gz;
	tar -C /usr/local/bin -zxvf do-ansible-inventory_2.0.0_macos_x86_64.tar.gz;
	rm do-ansible-inventory_2.0.0_macos_x86_64.tar.gz;
elif [ "${machine}" = "Linux" ]; then
	wget https://github.com/do-community/do-ansible-inventory/releases/download/v2.0.0/do-ansible-inventory_2.0.0_linux_x86_64.tar.gz;
	tar -C /usr/local/bin -zxvf do-ansible-inventory_2.0.0_macos_x86_64.tar.gz;
	rm do-ansible-inventory_2.0.0_macos_x86_64.tar.gz;    
fi