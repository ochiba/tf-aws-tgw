variable "system" {
  default = {
    id   = "hdr"
    name = "Heimdallr"
  }
}
variable "env" {
  default = {
    id   = "dev"
    name = "develop"
  }
}
variable "region" {
  default = {
    id   = "apne1"
    name = "ap-northeast-1"
  }
}

variable "system_cidrs" {
  default = [
    "172.16.0.0/16",
    "172.17.0.0/16",
    "172.18.0.0/16"
  ]
}

variable "heimdallr" {
  default = {
    system = {
      id   = "hdr"
      name = "heimdallr"
    }
    vpc = {
      id   = "vpc-095688e3e6cf3646b"
      cidr = "172.16.0.0/16"
    }
    subnets = {
      public = [
        { az = "a", cidr = "172.16.0.0/24" },
        { az = "c", cidr = "172.16.8.0/24" }
      ]
      private = [
        { az = "a", cidr = "172.16.16.0/24" },
        { az = "c", cidr = "172.16.32.0/24" }
      ]
      edge = [
        { az = "a", cidr = "172.16.255.0/25" },
        { az = "c", cidr = "172.16.255.128/25" }
      ]
    }
  }
}
