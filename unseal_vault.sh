#!/bin/sh -x

vault server -config /vault/config/local.json &
vault_pid=$!

while ! nc -z localhost 8200; do echo ""; done

if [[ ! -f /vault/file/tokens.txt ]]; then
  echo "Criando o arquivo de tokens"
  vault operator init | grep ':' | cut -d ':' -f 2  > /vault/file/tokens.txt
fi

for token in `head -n 5 /vault/file/tokens.txt`; do
  vault operator unseal $token
done

wait $vault_pid
