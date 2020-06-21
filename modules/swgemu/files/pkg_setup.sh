#!/bin/bash
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# preliminary mysql community rpm install
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm -y

# clean yum / update
yum clean all && yum upgrade -y && yum update -y

# install important stuff
yum install automake make cmake git gcc gcc-c++ java-1.8.0-openjdk-headless libatomic libdb-devel lua-devel make mariadb mariadb-devel openssl-devel wget -y

# Install cmake3, mirrors aren't finding cmake above 3.1
wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Linux-x86_64.sh

bash cmake-3.18.0-rc2-Linux-x86_64.sh --skip-license

# Install latest devtoolset
sudo yum install centos-release-scl -y
sudo yum install devtoolset-7-gcc* -y
scl enable devtoolset-7 bash
