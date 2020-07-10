# apache-guacamole-scripts

## To Use

### Setup Guacamole Server

`git clone https://github.com/larson-carter/apache-guacamole-scripts`

`cd apache-guacamole-scripts`

`chmod a+x install.sh`

`sudo ./install.sh`

Go with the install answering all the questions

Now it is time to configure Nginx:

`chmod a+x nginx-setup.sh`

`sudo ./nginx-setup.sh`

Now go with the install answering all of the questions

### Setup HAProxy Server

`git clone https://github.com/larson-carter/apache-guacamole-scripts`

`cd apache-guacamole-scripts`

`chmod a+x haproxy.sh`

`sudo ./haproxy.sh`

## To Upgrade

`chmod a+x update.sh`

Let it update

## Guacamole RDP Config

Now go to the web url of guacamole http://ip-address/

Login with username: guacadmin and password: guacadmin

Go add the ip address of your proxy server as rdp with port 3389

Now you need to add your LDAP config in guacamole.properties

Now you need to add groups. Add as many groups that you need and assign them the proxy server

Test as 1 person from each group!

## Restart Services

`sudo service tomcat9 restart`

`sudo /etc/init.d/guacd restart`

`sudo service nginx restart`

