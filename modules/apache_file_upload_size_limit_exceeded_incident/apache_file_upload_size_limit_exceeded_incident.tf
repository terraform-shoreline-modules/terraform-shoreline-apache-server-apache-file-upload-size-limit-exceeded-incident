resource "shoreline_notebook" "apache_file_upload_size_limit_exceeded_incident" {
  name       = "apache_file_upload_size_limit_exceeded_incident"
  data       = file("${path.module}/data/apache_file_upload_size_limit_exceeded_incident.json")
  depends_on = [shoreline_action.invoke_update_php_ini]
}

resource "shoreline_file" "update_php_ini" {
  name             = "update_php_ini"
  input_file       = "${path.module}/data/update_php_ini.sh"
  md5              = filemd5("${path.module}/data/update_php_ini.sh")
  description      = "Increase the upload file size limit in the Apache server configuration file. This can be achieved by modifying the "upload_max_filesize" and "post_max_size" fields in the "php.ini" file."
  destination_path = "/agent/scripts/update_php_ini.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_php_ini" {
  name        = "invoke_update_php_ini"
  description = "Increase the upload file size limit in the Apache server configuration file. This can be achieved by modifying the "upload_max_filesize" and "post_max_size" fields in the "php.ini" file."
  command     = "`chmod +x /agent/scripts/update_php_ini.sh && /agent/scripts/update_php_ini.sh`"
  params      = ["NEW_FILE_SIZE_LIMIT","PATH_TO_PHP_INI_FILE"]
  file_deps   = ["update_php_ini"]
  enabled     = true
  depends_on  = [shoreline_file.update_php_ini]
}

