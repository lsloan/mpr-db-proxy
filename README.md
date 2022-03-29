# mpr-proxy-db

An experiment for setting up a MySQL proxy for the mwrite-peer-review project so Google services can access its DB hosted in AWS.

## Step by step

1. ```docker pull proxysql/proxysql```
2. ```cp database-example.json database.json```
3. Edit `database.json` to fill in real values for the various `db_` placeholders.
4. ```./start.sh```
5. Configure DB client to connect to `127.0.0.1:6033` and access the named DB there using the username and password specified in the JSON file.

## Conclusion

Although this works in a local environment, when colleagues were about how to set this proxy up in a Docker container running in the mwrite-peer-review project, the recommendation is to not do it.  It's difficult to ensure proxies are set up securely in the OpenShift environment and ProxySQL doesn't appear to have integrated support for TLS.

The recommendation has been to instead do one of the following:

1. Move the MPR DB to a new AWS RDS host on its own and permit Google to access it.
2. Determine whether specific IP addresses are available for the Google services that need to access the DB and permit those to access the 
