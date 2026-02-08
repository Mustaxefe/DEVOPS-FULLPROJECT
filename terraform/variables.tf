variable "region" {
  type	  = string
  default = "sa-east-1"
}

variable "allowed_ssh_cidrs" {
  type    = list(string)
  default = ["201.75.208.176/32"]
}

variable "allowed_http_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
