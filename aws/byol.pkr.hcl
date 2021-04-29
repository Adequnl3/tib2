# Generated by: tyk-ci/wf-gen
# Generated on: Thu 29 Apr 03:10:24 UTC 2021

# Generation commands:
# ./pr.zsh -title drop vmaj.min manifests -branch releng/arm64 -base releng/arm64 -p
# m4 -E -DxREPO=tyk-identity-broker

variable "aws_access_key" {
  type      = string
  default   = "${env("AWS_ACCESS_KEY_ID")}"
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  default   = "${env("AWS_SECRET_ACCESS_KEY")}"
  sensitive = true
}

variable "flavour" {
  description = "OS Flavour"
  type    = string
}

variable "source_ami_owner" {
  type    = string
}

variable "ami_search_string" {
  type    = string
}



variable "region" {
  type    = string
  default = "us-east-1"
}

variable "version" {
  type    = string
  default = "${env("VERSION")}"
}

# "timestamp" template function replacement
locals {
       timestamp = regex_replace(timestamp(), "[- TZ:]", "")
       extn_map = {
         AWSLinux = "deb"
         Redhat   = "rpm"
       }
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/from-1.5/blocks/source
source "amazon-ebs" "byol" {
  access_key            = "${var.aws_access_key}"
  ami_name              = "BYOL tyk-identity-broker ${var.version} (${var.flavour})"
  ami_regions           = "${var.destination_regions}"
  ena_support           = true
  force_delete_snapshot = true
  force_deregister      = true
  instance_type         = "t3.micro"
  region                = "${var.region}"
  secret_key            = "${var.aws_secret_key}"
  source_ami            = "${var.source_ami}"
  source_ami_filter {
    filters = {
      architecture                       = "x86_64"
      "block-device-mapping.volume-type" = "gp2"
      name                               = "${var.ami_search_string}"
      root-device-type                   = "ebs"
      sriov-net-support                  = "simple"
      virtualization-type                = "hvm"
    }
    most_recent = true
    owners      = ["${var.source_ami_owner}"]
  }
  sriov_support = true
  ssh_username  = "ec2-user"
  subnet_filter {
    filters = {
      "tag:Class" = "build"
    }
    most_free = true
    random    = false
  }
  tags = {
    Component = "tyk-identity-broker"
    Flavour   = "${var.flavour}"
    Product   = "byol"
    Version   = "${var.version}"
  }
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/from-1.5/blocks/build
build {
  sources = ["source.amazon-ebs.byol"]


  provisioner "file" {
    destination = "/tmp/semver.sh"
    source      = "utils/semver.sh"
  }
  provisioner "file" {
    destination = "/tyk-identity-broker.${lookup(local.extn_map, var.flavour)}"
    source      = "deb/*amd64.deb"
  }
  provisioner "file" {
    destination = "/tmp/10-run-tyk.conf"
    source      = "utils/10-run-tyk.conf"
  }
  provisioner "shell" {
    environment_vars = ["VERSION=${var.version}" ]
    script           = "byol/install-tyk-identity-broker.sh"
  }
}
