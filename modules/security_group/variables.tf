variable "name" {type=string}
variable "description" {type=string}
variable "vpc_id" {type=string}
variable "allowed_cidrs" {type=list(string)}
variable "environment" {type=string}
