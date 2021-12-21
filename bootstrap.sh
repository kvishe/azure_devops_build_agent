#!/bin/bash

export VSTS_AGENT_INPUT_URL=${url}
export VSTS_AGENT_INPUT_AUTH=pat
export VSTS_AGENT_INPUT_TOKEN=${token}
export VSTS_AGENT_INPUT_POOL=${pool}

cd /home/ubuntu
 
wget https://vstsagentpackage.azureedge.net/agent/2.195.2/vsts-agent-linux-x64-2.195.2.tar.gz
mkdir myagent && cd myagent
tar zxvf ../vsts-agent-linux-x64-2.195.2.tar.gz
./bin/installdependencies.sh
chown -R ubuntu:ubuntu .
su ubuntu -c './config.sh --unattended'
echo "HOME=/home/ubuntu" >> .env
./svc.sh install
./svc.sh start