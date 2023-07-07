subnet_cidr_block = "10.0.40.0/24"
vpc_cidr_block = "10.0.0.0/16"
cidr_blocks = ["10.0.20.0/24", "10.0.30.0/24"]
cidr_blocks_objs = [
    {cidr_block = "10.0.20.0/24", name = "dev-vpc"}, 
    {cidr_block = "10.0.30.0/24", name = "dev-subnet"}
]