variable "network" {
    description = "The network configuration for the EC2 instances"
    type = any
}

variable "iam_role" {
    description = "The IAM role and instance profile for the EC2 instances"
    type = any
}
