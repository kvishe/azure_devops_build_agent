variable "azuredevops_url" {
  type        = string
  description = "Azure devops url for your organisation"
  default     = "https://dev.azure.com/organisation"
}

variable "azuredevops_token" {
  type        = string
  description = "Azure devops personal access token for agent registration"
  default     = "put_your_azure_devops_personal_access_token"
}

variable "azuredevops_pool" {
  type        = string
  description = "Azure devops pool name for the agents"
  default     = "pool_name"
}

variable "vpc_id" {
  description = "VPC id for the instances"
  type        = string
  default     = "vpc-id"
}

variable "ssh_cidr_blocks" {
  description = "List of cidr blocks for SSH access to the build agents"
  type        = list
  default     = ["0.0.0.0/0"]
}

variable "rdp_cidr_blocks" {
  description = "List of cidr blocks for RDP access to the build agents"
  type        = list
  default     = ["0.0.0.0/0"]
}

variable "subnet_ids" {
  description = "List of cidr blocks for SSH access to the build agents"
  type        = list
  default     = ["subnet-id1" , "subnet-id2"]
}

variable "key_name" {
  type        = string
  description = "Key-Pair name for access into the agent instances"
  default     = "key_pair"
}

variable "asg_max_size" {
  type        = number
  description = "Maximum size for ASG"
  default     = 2
}

variable "asg_min_size" {
  type        = number
  description = "Minimum size for ASG"
  default     = 1
}

variable "asg_desired_size" {
  type        = number
  description = "Desired size for ASG"
  default     = 1
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "linux_ami_id" {
  type        = string
  description = "ami id for the linux build agents"
  default     = "ami-04505e74c0741db8d"
}

variable "win_ami_id" {
  type        = string
  description = "ami id for the windows build agents"
  default     = "ami-0d80714a054d3360c"
}

variable "linux_ebs_size" {
  type        = number
  description = "EBS size in GB for agent instances"
  default     = 8
}

variable "win_ebs_size" {
  type        = number
  description = "EBS size in GB for agent instances"
  default     = 30
}