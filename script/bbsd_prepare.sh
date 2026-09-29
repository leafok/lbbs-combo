#!/bin/sh
set -eu

CONF_DIR="/usr/local/lbbs/conf"
BIN_DIR="/usr/local/lbbs/utils/bin"

gen_host_key() {
	key_file="$1"
	key_type="$2"

	if [ -f "$key_file" ]; then
		return 0
	fi

	if ! ssh-keygen -t "$key_type" -C "MyBBS Server" -N "" -f "$key_file"; then
		echo "Unable to generate SSH host key $key_file" >&2
		return 1
	fi
}

cd "$CONF_DIR"

if ! gen_host_key ssh_host_rsa_key rsa; then
	exit 1
fi
if ! gen_host_key ssh_host_ed25519_key ed25519; then
	exit 2
fi
if ! gen_host_key ssh_host_ecdsa_key ecdsa; then
	exit 3
fi

cd "$BIN_DIR"

# The generated menus are shared with bbsd through the bbsd-var volume.
# On failure exit non-zero so that "restart: on-failure" retries once the
# database is reachable.
if ! php gen_section_menu.php; then
	sleep 5
	exit 4
fi
if ! php gen_ex_list.php; then
	sleep 5
	exit 5
fi
if ! php gen_top.php; then
	sleep 5
	exit 6
fi
