#!/bin/sh

cd /usr/local/lbbs/conf

if [ ! -f ssh_host_rsa_key ]; then
    ssh-keygen -t rsa -C "MyBBS Server" -N "" -f ssh_host_rsa_key
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi
if [ ! -f ssh_host_ed25519_key ]; then
    ssh-keygen -t ed25519 -C "MyBBS Server" -N "" -f ssh_host_ed25519_key
    if [ $? -ne 0 ]; then
        exit 2
    fi
fi
if [ ! -f ssh_host_ecdsa_key ]; then
    ssh-keygen -t ecdsa -C "MyBBS Server" -N "" -f ssh_host_ecdsa_key
    if [ $? -ne 0 ]; then
        exit 3
    fi
fi

cd /usr/local/lbbs/utils/bin

php gen_section_menu.php
if [ $? -ne 0 ]; then
    sleep 5
    exit 4
fi

php gen_ex_list.php
if [ $? -ne 0 ]; then
    sleep 5
    exit 5
fi
php gen_top.php
if [ $? -ne 0 ]; then
    sleep 5
    exit 6
fi
