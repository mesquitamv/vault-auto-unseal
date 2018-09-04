# Vault Auto Unseal Image

## How it works:
This image uses the Vault official image (https://hub.docker.com/_/vault/) as base. Use the configuration guide of Vault official image to deploy it.

This image contains script that are executed on entrypoint called unseal_vault.sh. This script is responsible to:

- Verify if Vault is initialized:
  - If it's not initialized, Vault will be initialized and all unseal tokens and root token will be stored on /vault/file/tokens.txt
- Unseal Vault using tokens stored on /vault/file/tokens.txt

By default, this image uses this configuration:

```
{
	"ui": true,
	"disable_mlock": true,
	"listener": [{
		"tcp": {
			"address": "0.0.0.0:8200",
			"tls_disable": 1
		}
	}],
	"storage": {
		"file": {
			"path": "/vault/file"
		}
	}
}
```

This configuration enables you run Vault image in a simple way, with this line:

```
docker run -it -p 8200:8200 -e 'VAULT_ADDR=http://0.0.0.0:8200' marcusvmesquita/vault-auto-unseal

```

The Vault API will be available on port 8200, such as Vault UI too.

## Persist Data
To persist data, you must bind this volumes:
- /vault/vault-server/file
- /vault/vault-server/log

__Atention: Do not use this image in Production Environment. It just for you practice and to speed up the development. The propurse of Vault is gives you more security, and this image removes one layer of Vault security.__