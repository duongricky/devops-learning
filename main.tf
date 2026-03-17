module "vpc" {
    source = "./modules/vpc"
}

module "ec2" {
    source = "./modules/ec2"
    network = module.vpc.network
    iam_role = module.iam.iam_role
}

module "rds" {
    source = "./modules/rds"
    network = module.vpc.network
    ec2_resources = module.ec2.ec2_resources
}

module "ecs" {
    source = "./modules/ecs"
    network = module.vpc.network
    ec2_resources = module.ec2.ec2_resources
    iam_role = module.iam.iam_role
}

module "iam" {
    source = "./modules/iam"
    s3_bucket = module.s3.s3_bucket
    ecs_resources = module.ecs.ecs_resources
}

module "s3" {
    source = "./modules/s3"
}
