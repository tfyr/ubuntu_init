sudo apt install -y mysql-server nginx redis python3-dev gcc pkg-config libmysqlclient-dev unixodbc 

sudo mkdir /var/www/kirsa-front
sudo chown pos:pos /var/www/kirsa-front
sudo usermod -a -G pos www-data

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
ssh-keygen

cat ~/.ssh/id_rsa.pub
# rsync -rav -e ssh --exclude='categories_tree.json' /home/nash/PycharmProjects/kirsa-front/dist/ sunrise:/var/www/kirsa-front

sudo cp ~/ubuntu_init/localback/kirsa_nginx /etc/nginx/sites-available/kirsa
sudo nano /etc/nginx/sites-available/kirsa
sudo ln -s /etc/nginx/sites-available/kirsa /etc/nginx/sites-enabled/kirsa
sudo nginx -s reload

sudo mysql -e "CREATE DATABASE demands27 CHARACTER SET utf8 COLLATE utf8_general_ci;CREATE USER 'demands27'@'localhost' IDENTIFIED BY 'sXdfsdf33458Wwe1';GRANT ALL PRIVILEGES ON demands27.* TO 'demands27'@'localhost' WITH GRANT OPTION;create user 'nash'@'10.252.1.%';grant select on demands27.* to 'nash'@'10.252.1.%';create user 'pos'@'localhost';GRANT REPLICATION CLIENT ON *.* TO `pos`@`localhost`;flush privileges;"

sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

###
skip-log-bin
server-id               = 49
max_binlog_size   = 100M
relay-log = /var/lib/mysql/mysql-relay-bin
relay-log-index = /var/lib/mysql/mysql-relay-bin.index
replicate-do-db = demands27
replicate-ignore-table  = demands27.loutgo
replicate-ignore-table  = demands27.loutgopos
replicate-ignore-table  = demands27.lincome
replicate-ignore-table  = demands27.lincomepos
replicate-ignore-table  = demands27.lbalance
replicate-ignore-table  = demands27.kirsa_outgopos
replicate-ignore-table  = demands27.kirsa_outgo
replicate-ignore-table  = demands27.nashcart_cart
replicate-ignore-table  = demands27.nashcart_item
replicate-ignore-table  = demands27.kirsa_rashodorderext
slave-skip-errors = 1062,1032,1356

###
sudo service mysql restart

# scp demands27.dmp.gz sunrise:~/
gunzip demands27.dmp.gz
### mysql -u demands27 -p demands27 < demands27.dmp
sudo mysql demands27 < demands27.dmp
head demands27.dmp -n80 | grep "MASTER_LOG_POS"

# ssh tupak 'echo "000000"| sudo -S mysql demands27 -e "ALTER TABLE demands27.loutgopos ADD column amc_code varchar(150) null;"'
# ssh tupak 'echo "000000"| sudo -S mysql demands27 -e "ALTER TABLE demands27.loutgopos ADD CONSTRAINT loutgopos_amc_code_3d2375e0_uniq UNIQUE KEY (amc_code);"'
# -------------------------------
ALTER TABLE demands27.loutgopos DROP FOREIGN KEY loutgopos_outgo_id_6e59c97d_fk_loutgo_id;
ALTER TABLE demands27.loutgopos ADD CONSTRAINT loutgopos_outgo_id_6e59c97d_fk_loutgo_id FOREIGN KEY (outgo_id) REFERENCES demands27.loutgo(id) ON DELETE CASCADE ON UPDATE RESTRICT;
CHANGE MASTER TO MASTER_HOST='10.252.1.2', MASTER_USER='replication', MASTER_PASSWORD='Rehima123', MASTER_LOG_FILE = 'binlog.000', MASTER_LOG_POS=, GET_MASTER_PUBLIC_KEY=1;
start slave;
show slave status \G
# ------------------------------

### django
git clone git@github.com:tfyr/kirsa.git

git checkout master
cd kirsa
mkdir pos_json
mkdir pos_json/10
mkdir egais_cheques
python3 -m venv env
source env/bin/activate

pip install -r ~/ubuntu_init/localback/requirements.txt
pip install ~/ubuntu_init/localback/telegram-0.1.6.tar.gz ~/ubuntu_init/localback/promocodes-0.1.1.tar.gz

cp ~/ubuntu_init/localback/settings_local.py ~/kirsa/kirsa
nano ~/kirsa/kirsa/settings_local.py

python ./manage.py runserver 0.0.0.0:8090

sudo cp ~/ubuntu_init/localback/daphne_kirsa.service /etc/systemd/system/
sudo systemctl enable daphne_kirsa
sudo systemctl start daphne_kirsa.service

crontab -e
# */30 8-23 * * * cd ~/kirsa;env/bin/python tools/exchange_outgo.py



# alter table tran drop foreign key tran_outgo_id_9f687ac6_fk_kirsa_outgo_id;
alter table kirsa_amc drop foreign key kirsa_amc_outgopos_id_46581fef_fk_kirsa_outgopos_id;
alter table tran drop foreign key tran_outgo_id_9f687ac6_fk_kirsa_outgo_id;
