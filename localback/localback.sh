sudo apt install -y mysql-server nginx redis python3-dev gcc pkg-config libmysqlclient-dev unixodbc 

sudo mkdir /var/www/kirsa-front
sudo chown pos:pos /var/www/kirsa-front
sudo usermod -a -G pos www-data

chmod 600 ~/.ssh/authorized_keys
ssh-keygen

cat ~/.ssh/id_rsa.pub
# rsync -rav -e ssh --exclude='categories_tree.json' /home/nash/PycharmProjects/kirsa-front/dist/ sunrise:/var/www/kirsa-front

sudo mv ~/ubuntu_init/localback/kirsa_nginx /etc/nginx/sites-available/kirsa
sudo nano /etc/nginx/sites-available/kirsa
sudo ln -s /etc/nginx/sites-available/kirsa /etc/nginx/sites-enabled/kirsa
sudo nginx -s reload

sudo mysql -e "CREATE DATABASE demands27 CHARACTER SET utf8 COLLATE utf8_general_ci;CREATE USER 'demands27'@'localhost' IDENTIFIED BY 'sXdfsdf33458Wwe1';GRANT ALL PRIVILEGES ON demands27.* TO 'demands27'@'localhost' WITH GRANT OPTION;flush privileges;"

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
slave-skip-errors = 1062,1032
###
sudo service mysql restart

# scp demands27.dmp.gz sunrise:~/
gunzip demands27.dmp.gz
mysql -u demands27 -p demands27 < demands27.dmp

# ssh tupak 'echo "000000"| sudo -S mysql demands27 -e "ALTER TABLE demands27.loutgopos ADD column amc_code varchar(150) null;"'
# ssh tupak 'echo "000000"| sudo -S mysql demands27 -e "ALTER TABLE demands27.loutgopos ADD CONSTRAINT loutgopos_amc_code_3d2375e0_uniq UNIQUE KEY (amc_code);"'
# -------------------------------
ALTER TABLE demands27.loutgopos DROP FOREIGN KEY loutgopos_outgo_id_6e59c97d_fk_loutgo_id;
ALTER TABLE demands27.loutgopos ADD CONSTRAINT loutgopos_outgo_id_6e59c97d_fk_loutgo_id FOREIGN KEY (outgo_id) REFERENCES demands27.loutgo(id) ON DELETE CASCADE ON UPDATE RESTRICT;
CHANGE MASTER TO MASTER_HOST='10.252.1.2', MASTER_USER='replication', MASTER_PASSWORD='Rehima123', MASTER_LOG_FILE = 'binlog.000259', MASTER_LOG_POS=90338 GET_MASTER_PUBLIC_KEY=1;
start slave;
show slave status \G;
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

pip3 install mysqlclient
pip install -r ~/ubuntu_init/localback/requirements.txt
pip install ~/ubuntu_init/localback/telegram-0.1.6.tar.gz ~/ubuntu_init/localback/promocodes-0.1.1.tar.gz

python ./manage.py runserver 0.0.0.0:8090
scp settings_local.py tupak48:~/kirsa/kirsa
# nano ~/kirsa/kirsa/settings_local.py

sudo cp ~/ubuntu_init/localback/daphne_kirsa.service /etc/systemd/system/
sudo systemctl enable daphne_kirsa
sudo systemctl start daphne_kirsa.service
