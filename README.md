## How to run docker for apache_django_postgres_pgadmin

### 1. create pgdata directory. /pgdata is used for data storage of postgreSQL(this directory should be empty)
- $ mkdir pgdata
```
.
+-- /from
|  +-- ...
+-- /pgdata  <- created directory(should be empty)
+-- docker-compose.yml
+-- Dockerfile
```
### 2. change DB HOST address in setting.py
- 192.168.0.112 is set as DB HOST address, change this address to your server address.
### 3. run docker-compose up -d & check if 3 containers(onsale, postgres11_2, pgadmin4) are running.
- $ docker-compose up -d
### 4. create DB for Django
- $ docker exec -it onsale python /home/myaccount/python/onsale/manage.py makemigrations
- $ docker exec -it onsale python /home/myaccount/python/onsale/manage.py migrate
### 5. create superuser
- $ docker exec -it onsale python /home/myaccount/python/onsale/manage.py createsuperuser
### 6. create static directory for Django admin page
- $ docker exec -it onsale python /home/myaccount/python/onsale/manage.py collectstatic 
### 7. Test your connection
- change 192.168.0.112 to your server address
-- http://192.168.0.112:9080/ - apache default page(using http)
-- https://192.168.0.112:9443/ - apache default page(using https)
-- http://192.168.0.112:9880/flashsale/ - django test site(using http)
-- https://192.168.0.112:9843/flashsale/ - django test site(using https)
-- http://192.168.0.112:9880/admin/ - django admin site(using http)
-- https://192.168.0.112:9843/admin/ - django admin site(using https)
### 8.if you want to change ssl certification and key used in django ssl connection.
- change file name in /from/apache2/default-ssl.conf
```
   <VirtualHost _default_:9843>
     ....
     SSLCertificateFile      /etc/apache2/ssl/ssl-cert-snakeoil.pem
     SSLCertificateKeyFile /etc/apache2/ssl/ssl-cert-snakeoil.key
   </VirtualHost>
```
- put certification file and key file in /from/apache2/ssl/

