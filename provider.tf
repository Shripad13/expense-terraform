
provider "aws" {}

terraform {
  backend "s3" {}
}

provider "vault" {
  address         = "https://vault.devsecopswithshri.site:8200"
  token           = var.vault_token
  skip_tls_verify = true
}