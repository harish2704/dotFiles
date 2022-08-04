## Install RootCA certificates for browsers.

Web browsers like Firefox & Chromium will not consider the system CA certificates. These are the instructions to install RootCA for these browsers.

## Firefox
```
certutil -d ~/.mozilla/firefox/<Profile id>.default/ -A -i ./rootCA.pem -n 'Localhost Root CA' -t C,,
```
Where `<Profile id>` will change for each user. This has to be run for each Firefox profile.

##### Chrome / Chromium
```
certutil -d  "sql:$HOME/.pki/nssdb" -A -i ./rootCA.pem -n 'Locahost RootCA via certutil' -t C,,
```


