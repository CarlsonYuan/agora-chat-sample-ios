#  Push Notification

## Features for Push Notification
- [x] Enable/disable 
- [x] Increment app icon badge count   
* [fix: Notification Service Extension will not work after tuist regenerate](https://github.com/CarlsonYuan/agora-chat-sample-ios/commit/3a6eda9e48f1ebfefb290ef2b48d06869f6d9290)  
* [feat: increment app icon badge count](https://github.com/CarlsonYuan/agora-chat-sample-ios/commit/fc0f52a2730d1451efe658121d0dcc8d8d1eff6d)
- [x] Media attachments
* [feat: push notifications with media attachment](https://github.com/CarlsonYuan/agora-chat-sample-ios/commit/ef38a712a37e36145a887188424923e5f2bfd049)
- [ ] Sound
- [ ] Translation
- [ ] Content templates

## Sending push notifications using command-line tools

Send a Push Notification Using a Certificate
* With a DER-encoded certificate and the PEM-encoded private key
1. Set these shell variables:
```
CERTIFICATE_FILE_NAME=path to the certificate file
CERTIFICATE_KEY_FILE_NAME=path to the private key file
TOPIC=App ID
DEVICE_TOKEN=device token for your app
APNS_HOST_NAME=api.sandbox.push.apple.com
```
2. Then send a push notification using this command:
```
curl -v --header "apns-topic: ${TOPIC}" --header "apns-push-type: alert" --cert "${CERTIFICATE_FILE_NAME}" --cert-type DER --key "${CERTIFICATE_KEY_FILE_NAME}" --key-type PEM --data '{"aps":{"alert":"test"}}' --http2  https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}
```
* With P12 certificate
1. Set these shell variables:
```
CERTIFICATE_FILE_NAME=path to the certificate file
CERTIFICATE_FILE_PASSWORD=password for the certificate file
TOPIC=App ID
DEVICE_TOKEN=device token for your app
APNS_HOST_NAME=api.sandbox.push.apple.com
```
2. Then send a push notification using this command:
```
curl -v --header "apns-topic: ${TOPIC}" --header "apns-push-type: alert" --cert "${CERTIFICATE_FILE_NAME}:${CERTIFICATE_FILE_PASSWORD}" --cert-type P12 --data '{"aps":{"alert":"test"}}' --http2  https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}
```

Convert a P12 (PKCS#12) file to DER-encoded certificate and PEM-encoded private key
```
# Convert P12 to PEM (private key + certificate)
openssl pkcs12 -in yourfile.p12 -out keycert.pem 
openssl pkcs12 -in yourfile.p12 -legacy -nodes -out keycert.pem (OpenSSL 3.2.1 using this command)

# Extract private key from PEM
openssl rsa -in keycert.pem -out key.pem

# Extract certificate from PEM
openssl x509 -in keycert.pem -out cert.der -outform DER
```
For more information see [here](https://developer.apple.com/documentation/usernotifications/sending-push-notifications-using-command-line-tools)

## Device token operations by the RESTful API 
* list the registered tokens 
```
curl -X GET \
-H 'Authorization: Bearer { AppToken }' \
'https://${REST_API}/${OrgName}/${AppName}/users/${username}/push/binding'
```

* Unregister device token using this command: 
```
curl -X PUT \
-H 'Authorization: Bearer ${AppToken}' \
'https://${REST_API}/${OrgName}/${AppName}/users/${username}/push/binding' \
-d '{
    "device_id": "${deviceId}",
    "device_token": "",
    "notifier_name": "${apnsCertName}"
}'
```
