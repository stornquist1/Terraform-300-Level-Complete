output "sample_var_output" {
  value = var.sample_var
}

variable "sample_var" {
  description = "This is a sample variable"
  type        = string
  default     = "I am the default value of sample_var"
}

# "I am the value of sample_var given in -var 'sample_var=...'"

# Variable precedence is as follows:
# 1. Any -var and -var-file options on the command line, in the order they are provided.
# 2. Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
# 3. The terraform.tfvars.json file, if present.
# 4. The terraform.tfvars file, if present.
# 5. Environment variables
# 6. Default values from the variable configuration

# export TF_VAR_sample_var="I am the environment variable: TF_VAR_sample_var"
