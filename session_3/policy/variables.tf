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

variable "de_environment" {
  description = "The Digital Ecosystem environment (dev or prod)"
  type        = string
  default     = "dev"
}

variable "subscription_id" {
  description = "The subscription ID to assign the policy set to."
  type        = string
  default = "/subscriptions/c63c958d-d7ac-46a6-a4ed-aabf5adbd706"
}

variable "management_group_id" {
  description = "The management group ID to assign the policy set to."
  type        = string
  default     = "/managmentgroups/242da254-1fea-0364-2584-c930f11f89c2"
}