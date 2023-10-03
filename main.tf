terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "apache_file_upload_size_limit_exceeded_incident" {
  source    = "./modules/apache_file_upload_size_limit_exceeded_incident"

  providers = {
    shoreline = shoreline
  }
}