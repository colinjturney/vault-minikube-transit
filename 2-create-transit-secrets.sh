#!/bin/sh

export VAULT_ADDR=http://127.0.0.1:8200

vault login root

vault secrets enable transit

vault write -f transit/keys/orders

