terraform {
  backend "remote" {
    organization = "projeto-fiap-64"

    workspaces {
      name = "hackaton-fiap-64"
    }
  }
}

provider "aws" {
  region = var.region
}

