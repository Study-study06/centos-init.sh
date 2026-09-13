#!/bin/bash

  #----------------Centos自动化配置基础环境--------------------
   # 脚本编写目的：解决上课、新建Linux测试环境时繁琐的基础环境配置过程
   # 脚本测试的环境：New Centos7.9
   # 编写作者：Renzo
   #使用时请认真查看README.dm中的内容

set -e

VERSION="Centos"    #定义使用的Linux版本
HOST_NAME="Renzo"   #定义需要的用户名
USER_IP="192.168.11.140"    #定义需要的主机IP地址
IP_GW="192.168.11.2"      #定义需要的网关IP
HOST_ENS="ens33"         #定义需要配置的网卡名
HOST_YUM="https://mirrors.aliyun.com/repo/Centos-7.repo"   #定义需要的版本yum源
          #https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo    centos8源
HOSTS_IP="$USER_IP $HOST_NAME "   #配置主机映射调用的变量


echo "[---------Start configuring the network environment----------]"
hostnamectl set-hostname $HOST_NAME
cat >> /etc/sysconfig/network-scripts/ifcfg-$HOST_ENS << EOF
IPADDR=$USER_IP
NETMASK=255.255.255.0
GATEWAY=$IP_GW
DNS1=8.8.8.8
DNS2=114.114.114.114
EOF
sed -i 's/BOOTPROTO=.*/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-$HOST_ENS
systemctl restart network
sleep 5
cat >> /etc/hosts << EOF
$HOSTS_IP
EOF
systemctl stop firewalld
systemctl disable firewalld
sed -i 's/SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
ip a | grep $USER_IP
ping -c 3 $HOST_NAME
setenforce 0
echo "[ The network environment has been set up.! ]"
read -p "Press Enter to continue..."


echo "[---------Start configuring the yum repository----------]"
mkdir -p /media/yum.repo.backup
mv /etc/yum.repos.d/* /media/yum.repo.backup/
curl -o /etc/yum.repos.d/$VERSION-Base.repo $HOST_YUM
yum clean all && yum makecache
sleep 5
yum repolist
echo "[ All yum repositories are backed up in the /media/ directory ]"
echo "[ The yum repository has been configured! ]"
echo "[ Basic environment configuration completed ]"
