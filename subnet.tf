resource "aws_subnet" "publicsubnets" {
    count = 3
    vpc_id = aws_vpc.dev.id
    cidr_block = element(var.cidr_block_subnets,count.index)
    availability_zone = element(var.azs,count.index)
    tags = {
        Name = "${var.vpc_name}-public${count.index+1}"
    }
  
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.dev.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "${var.vpc_name}-rt"
    }
  
}

resource "aws_route_table_association" "subnetassociate" {
    count =3
    route_table_id = aws_route_table.rt.id
    subnet_id = element(aws_subnet.publicsubnets.*.id,count.index)
  
}