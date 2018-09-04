FROM vault

ADD unseal_vault.sh /usr/local/bin/unseal_vault.sh
ADD local.json /vault/config/local.json
RUN chmod 0777 /usr/local/bin/unseal_vault.sh

ENTRYPOINT [ "unseal_vault.sh" ]
