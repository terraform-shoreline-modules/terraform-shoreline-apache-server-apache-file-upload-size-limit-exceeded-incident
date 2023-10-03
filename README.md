
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache File Upload Size Limit Exceeded Incident
---

This incident type pertains to a situation where the Apache file that is being uploaded exceeds the size limit that is set for the upload. Such a scenario occurs when the file's size is larger than what the server is configured to handle. This incident can result in the file upload process being halted, which can cause delays in the system's functioning.

### Parameters
```shell
export APACHE_CONFIG_FILE="PLACEHOLDER"

export APACHE_ERROR_LOG="PLACEHOLDER"

export FILE_PATH="PLACEHOLDER"

export NEW_FILE_SIZE_LIMIT="PLACEHOLDER"

export PATH_TO_PHP_INI_FILE="PLACEHOLDER"
```

## Debug

### Check the Apache version
```shell
httpd -v
```

### Check the Apache configuration file for the max file upload size limit set
```shell
grep -i "LimitRequestBody" ${APACHE_CONFIG_FILE}
```

### Check the Apache error log for any error messages related to file upload
```shell
tail -f ${APACHE_ERROR_LOG}
```

### Check the file size of the file being uploaded
```shell
ls -lh ${FILE_PATH}
```

### Check the available space on the server where Apache is running
```shell
df -h
```

### Restart the Apache service to apply any changes made to the configuration file
```shell
systemctl restart httpd
```

### Check the status of the Apache service
```shell
systemctl status httpd
```

## Repair

### Increase the upload file size limit in the Apache server configuration file. This can be achieved by modifying the "upload_max_filesize" and "post_max_size" fields in the "php.ini" file.
```shell


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


```