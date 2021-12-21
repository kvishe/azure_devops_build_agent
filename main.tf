resource "aws_security_group" "linux_agent_sg" {
  name        = "azure_devops_linux_agent_sg"
  description = "Allow traffic for ssh"
  vpc_id      = var.vpc_id

  ingress {
    description = "TCP 22 (SSH)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "azure_devops_linux_agent_sg"
  }
}

resource "aws_launch_template" "linux_agent_lt" {
  name_prefix = "azure_devops_linux_agent_lt"
  image_id      = var.linux_ami_id
  instance_type = var.instance_type

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.linux_ebs_size
    }
  }
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.linux_agent_sg.id}"]

  user_data = base64encode(templatefile("${path.module}/bootstrap.sh", { url = "${var.azuredevops_url}", token = "${var.azuredevops_token}", pool = "${var.azuredevops_pool}" }))
}

resource "aws_autoscaling_group" "linux_agent_asg" {
  name                      = "azure_devops_linux_agent_asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.asg_desired_size
  force_delete              = false
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.linux_agent_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Azure Devops Linux Build Agent"
    propagate_at_launch = true
  }
}


resource "aws_security_group" "win_agent_sg" {
  name        = "azure_devops_win_agent_sg"
  description = "Allow traffic for rdp"
  vpc_id      = var.vpc_id

  ingress {
    description = "TCP 3389 (RDP)"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.rdp_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "azure_devops_win_agent_sg"
  }
}

resource "aws_launch_template" "win_agent_lt" {
  name_prefix = "azure_devops_win_agent_lt"
  image_id      = var.win_ami_id
  instance_type = var.instance_type

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.win_ebs_size
    }
  }
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.win_agent_sg.id}"]

  user_data = base64encode(templatefile("${path.module}/windows_bs.ps1", { VSTS_AGENT_INPUT_URL = "${var.azuredevops_url}", VSTS_AGENT_INPUT_TOKEN = "${var.azuredevops_token}", VSTS_AGENT_INPUT_POOL = "${var.azuredevops_pool}" }))
}

resource "aws_autoscaling_group" "win_agent_asg" {
  name                      = "azure_devops_win_agent_asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.asg_desired_size
  force_delete              = false
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.win_agent_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Azure Devops Windows Build Agent"
    propagate_at_launch = true
  }
}
