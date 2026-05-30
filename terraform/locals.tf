# =============================================================================
# LOCAL VALUES AND DATA SOURCES
# =============================================================================

# Data sources
# give us the list of available AZs in the region, and current caller identity for tagging
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

# Random suffix for unique resource names
# cluster unique name to avoid conflicts when running multiple times
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# Local computed values
locals {
  # Cluster configuration with unique suffix to avoid conflicts
  cluster_name = "${var.cluster_name}-${random_string.suffix.result}"

  # Network configuration
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 10)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]

  # Common tags applied to all resources
  common_tags = {
    Environment = var.environment
    Project     = "retail-store"
    ManagedBy   = "terraform"
    CreatedBy   = "TrainWithShubhamCommunity"
    Owner       = data.aws_caller_identity.current.user_id
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  }

  # Kubernetes subnet tags
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
