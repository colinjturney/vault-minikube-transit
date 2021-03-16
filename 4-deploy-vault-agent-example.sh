#!/bin/sh

# Apply vault-agent demo configurations

kubectl apply -f configs/www-vault-agent-colin-testing.yaml

echo ""
echo "Open http://$(minikube ip):32080 in your browser"