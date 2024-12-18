
variable "tags" {
  type = object({
    Environment = string
    Project     = string
  })

  default = {
    Environment = "production"
    Project     = "devops-na-nuvem"
  }
}

variable "vpc" {
  type = object({
    name                       = string
    cidr_block                 = string
    internet_gateway_name      = string
    nat_gateway_name           = string
    public_route_table_name    = string
    private_route_table_name   = string
    nat_gateway_public_ip_name = string
    public_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
    private_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
  })


  default = {
    name                       = "devops-na-nuvem-vpc"
    cidr_block                 = "10.0.0.0/24"
    internet_gateway_name      = "devops-na-nuvem-vpc-internet-gateway"
    nat_gateway_name           = "devops-na-nuvem-vpc-nat-gateway"
    public_route_table_name    = "devops-na-nuvem-vpc-public-route-table"
    private_route_table_name   = "devops-na-nuvem-vpc-private-route-table"
    nat_gateway_public_ip_name = "devops-na-nuvem-vpc-nat-gateway-public-ip"
    public_subnets = [{
      name                    = "devops-na-nuvem-vpc-public-subnet-us-east-1a"
      availability_zone       = "us-east-1a"
      cidr_block              = "10.0.0.0/26"
      map_public_ip_on_launch = true
      },
      {
        name                    = "devops-na-nuvem-vpc-public-subnet-us-east-1b"
        availability_zone       = "us-east-1b"
        cidr_block              = "10.0.0.64/26"
        map_public_ip_on_launch = true
    }]
    private_subnets = [{
      name                    = "devops-na-nuvem-vpc-private-subnet-us-east-1a"
      availability_zone       = "us-east-1a"
      cidr_block              = "10.0.0.128/26"
      map_public_ip_on_launch = false
      },
      {
        name                    = "devops-na-nuvem-vpc-private-subnet-us-east-1b"
        availability_zone       = "us-east-1b"
        cidr_block              = "10.0.0.192/26"
        map_public_ip_on_launch = false
    }]
  }
}

variable "eks_cluster" {
  type = object({
    name                                                      = string
    node_group_name                                           = string
    role_name                                                 = string
    node_group_role_name                                      = string
    enabled_cluster_log_types                                 = list(string)
    access_config_authentication_mode                         = string
    access_config_bootstrap_cluster_creator_admin_permissions = bool
    node_group_capacity_type                                  = string
    node_group_instance_types                                 = list(string)
    node_group_scaling_config_desired_size                    = number
    node_group_scaling_config_max_size                        = number
    node_group_scaling_config_min_size                        = number
  })

  default = {
    name                                                      = "devops-na-nuvem-eks-cluster"
    node_group_name                                           = "devops-na-nuvem-eks-node-group"
    role_name                                                 = "devops-na-nuvem-eks-cluster-role"
    node_group_role_name                                      = "devops-na-nuvem-eks-node-group-role"
    enabled_cluster_log_types                                 = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    access_config_authentication_mode                         = "API_AND_CONFIG_MAP"
    access_config_bootstrap_cluster_creator_admin_permissions = true
    node_group_capacity_type                                  = "ON_DEMAND"
    node_group_instance_types                                 = ["t3.medium"]
    node_group_scaling_config_desired_size                    = 2
    node_group_scaling_config_max_size                        = 2
    node_group_scaling_config_min_size                        = 2
  }
}


variable "ecr_repositories" {
  type = list(object({
    name                 = string
    image_tag_mutability = string
  }))

  default = [{
    name                 = "devops-na-nuvem/production/frontend"
    image_tag_mutability = "MUTABLE"
    },
    {
      name                 = "devops-na-nuvem/production/backend"
      image_tag_mutability = "MUTABLE"
  }]
}
