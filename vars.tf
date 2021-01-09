variable "cidr" {
	type = string
	default = "10.0.0.0/16" 
}

variable "cidr_block" {
	type = list
	default = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
}

variable "azs" {
	type = list
	default = ["ap-south-1a","ap-south-1b","ap-south-1"]
}