#CentOS 基础环境自动化配置脚本

一个用于新建 CentOS 7.9 测试环境时，一键完成基础配置的 Shell 脚本。
解决每次装完系统后，手动配置网络、主机名、防火墙、YUM 源等重复劳动的问题。


#脚本功能

运行脚本后，它会自动完成以下操作：


1. 配置主机名：设置指定的主机名

2. 配置静态 IP：包括 IP 地址、子网掩码、网关、DNS

3. 配置主机映射：把 IP 和主机名写入 `/etc/hosts`

4. 关闭防火墙：停止 `firewalld` 并禁止开机自启

5. 关闭 SELinux：修改配置文件并临时关闭

6. 配置 YUM 源：备份原有源，替换为阿里云 CentOS 7 源

7. 验证配置：检查 IP、ping 主机名、刷新 YUM 缓存



#  使用前准备



在运行脚本之前，请确认：



- 系统是 CentOS 7.9（其他版本可能需要调整）

- 你有 root 权限（脚本需要修改系统配置）

- 网络配置信息已经确认好（IP、网关、网卡名）


# 配置项说明



脚本开头的变量区，你可以按需修改：

```bash

VERSION="Centos"                        # Linux 版本

HOST_NAME="Renzo"                       # 主机名

USER_IP="192.168.11.140"                # 静态 IP 地址

IP_GW="192.168.11.2"                    # 网关

HOST_ENS="ens33"                        # 网卡名

HOST_YUM="https://mirrors.aliyun.com/repo/Centos-7.repo"   # YUM 源地址




#Rocky Linux 适配计划：

当前脚本基于 CentOS 7.9 编写。由于 CentOS 7 已停止维护，后续计划将脚本适配到 Rocky Linux 9，作为长期使用的版本


#使用方法

```bash

bash centos-init.sh
