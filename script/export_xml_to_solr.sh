#!/bin/bash
set -euo pipefail

export_mgr="/var/www/html/manage/export_article.php"
export_dir="/var/www/html/export_xml"
solr_update_url="http://solr:8983/solr/lbbs/update"

# export_article.php prints the ID of every article it writes to stdout, one per line
if ! export_list="$(php "$export_mgr")"; then
	echo "Export XML data failed!" >&2
	exit 1
fi

if [ -z "$export_list" ]; then
	echo "Nothing to export."
	exit 0
fi

while IFS= read -r file; do
	[ -n "$file" ] || continue

	echo "$file"
	if ! curl --fail --silent --show-error "$solr_update_url" \
			-X POST -H 'Content-type:text/xml' \
			--data-binary "@${export_dir}/${file}.xml"; then
		echo "Solr update failed for article ${file}!" >&2
		exit 2
	fi
done <<< "$export_list"

echo "Export XML data to Solr completed."
