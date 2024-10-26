eksctl create cluster  --name zeal-cluster  --version 1.31  --region us-east-1 --nodegroup-name linux-nodes  --node-type t2.xlarge  --nodes 3
aws sts get-caller-identity
aws eks update-kubeconfig --region us-east-1 --name zeal-cluster