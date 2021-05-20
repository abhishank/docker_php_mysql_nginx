
## Setting Up Docker Containers

1. Navigate to _~/Documents/www/BrandalleyFE/_

2. Extract content of archive in it. The folder structure should be like this (if some folder is missing create it.):-
    <pre>
    ├── BrandalleyFE
    │   ├── app
    │   │   ├── public
    │   │   └── public_erp
    │   ├── build
    │   │   ├── ELASTIC.Dockerfile
    │   │   ├── keys
    │   │   └── PHP.Dockerfile
    │   ├── docker-compose.yml
    │   ├── nginx.conf
    │   └── Readme.txt
    </pre>

3. From **_~/.ssh/_**  folder copy **config** file and **private key** to the **_keys_** folder. 
    * keys folder should be in build directory as shown above.
    * content of config file should be something like this
    <pre>
        Host git-codecommit.*.amazonaws.com
        User [USER IDENTIFICATION]
        IdentityFile ~/.ssh/aws-code-commit-ssh
    </pre>

4. Run following command from **_BrandalleyFE_** folder

        * docker-compose up --build

    > Please note in case of port conflict update the nginx ports in docker-compose.yml and nginx.conf files.

5. When above command is done open another terminal window and run **docker ps -a** . Following images should be downloaded and should be in running state.

    * brandalleyfe_elasticsearch
    * nginx:1.19.10             
    * brandalleyfe_php          
    * adminer                   
    * mysql:5.7

6. From browser go to 

        1. http://127.0.0.1:8080/ 

            * this is adminer . Default host: mysql user: root password: root
        
        2. http://127.0.0.1:9200/

            * This will show you elasticsearch details.

7. If every thing is fine we can stop all containers by `ctrl+c` from the terminal where we ran build command.

8. Add following to your **_/etc/hosts_** file (optional). 
    ```
    # Brandalley Docker 
    127.0.0.1       erp.brandalley.local
    127.0.0.1       fe.brandalley.local
    ```

---
---

## Installing FE

1. Navigate to **_~/Documents/www/BrandalleyFE/_**  and run following command.

    * `docker-compose up -d`
    * This will silently start our containers.

2. run this to login to php container as www-data user.
    * `docker exec -it --user www-data brandalleyfe_php_1 /bin/bash`

3. Inside php container navigate to 
    * cd /home/projects/public/

4. Here run the following commands:
    <pre>
    * git init   [ initializing git]
    * git remote add ssh://git-codecommit.eu-west-1.amazonaws.com/v1/repos/magento2-brandalley-frontend-project  [ adding remote]
    * git pull
    * git checkout --track origin magento242  [checkout the branch which supports 7.4]
    * git pull
    * composer install [ pull all the files]
    </pre>

5. Create or Import a database in the mysql.

6. Magento2.4 onwards GUI install is not supported. So we nee to install via CLI. This is a sample setup command. Modify according to your setup:- 
<pre>
php -dmemory_limit=2G bin/magento setup:install --base-url=http://fe.brandalley.local/ --db-host=brandalleyfe_mysql_1 --db-name=fe_db --db-user=root --db-password=root --admin-firstname=admin --admin-lastname=admin --admin-email=adminaa@admin.com --admin-user=adminaa --admin-password=admin123 --language=en_GB --currency=GBP --timezone=Europe/London --use-rewrites=1 --backend-frontname="admin" --session-save="db" --search-engine=elasticsearch7 --elasticsearch-host=elasticsearch --elasticsearch-index-prefix=magento2 --es-hosts="elasticsearch:9200"
</pre>

---
---

## Installing ERP

1. Navigate to **_~/Documents/www/BrandalleyFE/_**  and run following command.

    * `docker-compose up -d`
    >This will silently start our containers.

2. run this to login to php container as www-data user.
    * `docker exec -it --user www-data brandalleyfe_php_1 /bin/bash`

3. Inside php container navigate to 
    * cd /home/projects/public_erp/

4. Here run the following commands:
    <pre>
    * git init   [ initializing git]
    * git remote add ssh://git-codecommit.eu-west-1.amazonaws.com/v1/repos/magento2-brandalley-erp-project  [ adding remote]
    * git pull
    * git checkout --track origin development  [checkout the branch which supports 7.4]
    * git pull
    * composer install [ pull all the files]
    </pre>

5. Create or Import a database in the mysql.

6. Magento2.4 onwards GUI install is not supported. So we nee to install via CLI. This is a sample setup command. Modify according to your setup:- 
<pre>
php -dmemory_limit=2G bin/magento setup:install --base-url=http://erp.brandalley.local:81/ --db-host=barndalleyfe_mysql_1 --db-name=erp_db --db-user=root --db-password=root --admin-firstname=admin --admin-lastname=admin --admin-email=adminaa@admin.com --admin-user=adminaa --admin-password=admin123 --language=en_GB --currency=GBP --timezone=Europe/London --use-rewrites=1 --backend-frontname="admin" --session-save="db" --search-engine=elasticsearch7 --elasticsearch-host=elasticsearch --elasticsearch-index-prefix=magento_erp
</pre>