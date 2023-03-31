terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

provider "azurerm" {
  features {}
}


# Creating azure resource group

resource "azurerm_resource_group" "vijay" {
  name     = var.resource-group-name
  location = var.location
  tags = {
    environement = "dev"
  }
}

resource "azurerm_storage_account" "storage-1" {
  name                     = "${var.storage-account-name}"
  resource_group_name      = "${azurerm_resource_group.vijay.name}"
  location                 = "${azurerm_resource_group.vijay.location}"
  account_kind             = "${var.storage-account-kind}"
  account_tier             = "${var.storage-account-tier}"
  account_replication_type = "${var.storage-account-replication-type}"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_blob" "blob" {
  name                   = "${var.storage-blob-name}"
  storage_account_name   = "${azurerm_storage_account.storage-1.name}"
  storage_container_name = "${var.storage-container-name}"
  type                   = "${var.storage-blob-type}"
  source                 = "index.html"
  content_type           = "${var.storage-blob-content-type}"

}


