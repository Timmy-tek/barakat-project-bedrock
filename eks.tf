module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" #This tells AWS which version of Kubernetes to install

  cluster_name    = "project-bedrock-cluster"
  cluster_version = "1.34"

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      min_size       = 2
      desired_size   = 2
      max_size       = 3
    }
  }

  tags = {
    Project = "barakat-2025-capstone"
  }

  access_entries = {

    terraform-user = {
      principal_arn = "arn:aws:iam::514190629503:user/terraform-user"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }

    developer-user = {
      principal_arn = aws_iam_user.bedrock_dev_view.arn

      policy_associations = {
        readonly = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }


}
