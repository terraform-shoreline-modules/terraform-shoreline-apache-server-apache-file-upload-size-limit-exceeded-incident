

#!/bin/bash



# Set the new file size limit

NEW_SIZE_LIMIT=${NEW_FILE_SIZE_LIMIT}



# Set the path to the php.ini file

PHP_INI_PATH=${PATH_TO_PHP_INI_FILE}



# Update the "upload_max_filesize" field in the php.ini file

sed -i "s/upload_max_filesize = .*/upload_max_filesize = ${NEW_SIZE_LIMIT}/" ${PHP_INI_PATH}



# Update the "post_max_size" field in the php.ini file

sed -i "s/post_max_size = .*/post_max_size = ${NEW_SIZE_LIMIT}/" ${PHP_INI_PATH}



# Restart Apache to apply the changes

service apache2 restart



echo "Upload file size limit updated to ${NEW_SIZE_LIMIT}"