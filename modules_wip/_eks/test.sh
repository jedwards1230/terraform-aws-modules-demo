#!/bin/bash

aws eks update-kubeconfig --name dev-eks-cluster-demo-eks-cluster --region us-east-1
kubectl get nodes