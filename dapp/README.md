# Instrucciones para implementar y ejecutar el chaincode "chaincode-go" para usar con la DAPP
Para usar la dapp debemos instalar el chaincode en el peer, en vez de ejecutarlo como lo hacemos en el Tema II

```
source peeradmin.sh
```

Empaquete e instale el chaincode en el peer:

```
peer lifecycle chaincode package mycc.tar.gz --path ./chaincodes/chaincode-go --lang golang --label mycc

peer lifecycle chaincode install mycc.tar.gz
```

La instalación del chaincode puede demorar un minuto.

Copie el ID del paquete de chaincode devuelto en la variable de entorno para usar luego (el ID puede ser diferente):

```
export CHAINCODE_ID=mycc:faaa38f2fc913c8344986a7d1617d21f6c97bc8d85ee0a489c90020cd57af4a5
```

## Activar el chaincode

Con el script `cc_approve_commit.sh` se aprueba y confirma el chaincode (solo es necesaria una única aprobación según la política de validación definida):

```
peer lifecycle chaincode approveformyorg -o 127.0.0.1:7050 --channelID mychannel --name mycc --version 1 --package-id $CHAINCODE_ID --sequence 1

peer lifecycle chaincode commit -o 127.0.0.1:7050 --channelID mychannel --name mycc --version 1 --sequence 1
```