#!/bin/bash

php /var/www/html/manage/export_article.php 2>/dev/null |
while read file; do
	echo $file
	curl http://solr:8983/solr/lbbs/update -X POST -H 'Content-type:text/xml' \
		--data-binary @/var/www/html/export_xml/$file.xml 2>/dev/null
	if [ $? -ne 0 ]; then
		echo "Solr update failed!"
		exit 2
	fi
done

if [ $? -ne 0 ]; then
	echo "Export XML data failed!"
	exit 1
fi
