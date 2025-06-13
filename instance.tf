resource "aws_instance" "servers" {
    count=3
  ami = var.ami
  key_name = var.key_name
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = element(aws_subnet.publicsubnets.*.id,count.index)
  private_ip = element(var.private_ip,count.index)
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-chandraservers${cont.index+1}"
  }
}