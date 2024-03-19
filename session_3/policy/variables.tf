############### Policy Variables ###############

variable "policy_set_name" {
  type        = string
  description = "The name of the policy set and assignment."
  default     = "IL5-Initiative"
}

variable "policy_type" {
  type        = string
  description = "The type of the policy deployment."
  default     = "Custom"
}

variable "policy_mode" {
  type        = string
  description = "The mode of the policy deployment."
  default     = "All"
}

variable "policy_description" {
  type        = string
  description = "The description to provide for the policy assignment."
  default     = "This initiative includes policies that address a subset of DoD Impact Level 5 (IL5) controls. Additional policies will be added in upcoming releases. For more information, visit https://aka.ms/dodil5-initiative."
}

variable "policy_set_assignment_name" {
  type        = string
  description = "The name of the policy set and assignment."
  default     = "IL5-Assignment"
}

variable "environment" {
  description = "dev or prod environment."
  type        = string
  default     = "prod"
}

variable "subscription_id" {
  description = "The subscription ID to assign the policy set to."
  type        = string
  #add your own subscription ID here
  default = "/subscriptions/c4e9d5be-bc64-4958-b3ae-3666010d6116"
}