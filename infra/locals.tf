

locals {



  vpc_name = "ecs-app-vpc"

  vpc_cidr = "10.0.0.0/16"

  public_subnets_config = {
    az1 = {
      cidr_block        = "10.0.0.0/24"
      availability_zone = "eu-north-1a"
    }

    az2 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "eu-north-1b"
    }

  }

  private_subnets_config = {
    az1 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "eu-north-1a"

    }

    az2 = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "eu-north-1b"
    }


  }


}



