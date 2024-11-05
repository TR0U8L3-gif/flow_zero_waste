1. Generate a private key and a public key in PEM. You should safeguard the private key and never share it:

```openssl genrsa -out test_key.pem 2048```

2. Extract the public key in PEM format using the following command. This command extracts the public key details so it can be safely shared without revealing the details of the private key:

```openssl rsa -in test_key.pem -outform PEM -pubout -out test_key.pem.pub```

The example below shows the contents of the test_key.pem.pub PEM file:

>>>
----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA53VzmIVVZZWyNm266l82 mnoDc9g/snXklax5kChEhqK/WnTUvuXP4Gd4THj8rchxgUGKXd4PF3SUcKyn/qPm Tet0idVHk2PwP//FOVgYo5Lb04js0pgZkbyB/WjuMp1w+yMuSn0NYAP7Q9U7DfTb jmox8OQt4tCB4m7UrJghGqT8jkPyZO/Ka6/XsyjTYPOUL3t3PD7JShVAgo1mAY6g 
Sr4SORywIiuHsg+59ad7MXGy78LirhtqAcDECKF7VZpxMuEjMLg3o2yzNUeWI2Mg IF+t0HbO1E387fvLcuSyai1yWbSr1PXyiB2aXyDpbD4u7d3ux4ahU2opH11lBqvx +wIDAQAB -----END PUBLIC KEY-----
>>>