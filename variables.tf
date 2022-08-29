variable "AWS_REGION" {
default = "us-east-1"
}

variable "AMIS" {
  default = "ami-0b0ea68c435eb488d"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}