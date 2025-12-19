sudo apt install -y mysql-server nginx redis python3-dev gcc pkg-config libmysqlclient-dev unixodbc 

sudo mkdir /var/www/kirsa-front
sudo chown pos:pos /var/www/kirsa-front
sudo usermod -a -G pos www-data

# rsync -rav -e ssh --exclude='categories_tree.json' /home/nash/PycharmProjects/kirsa-front/dist/ sunrise:/var/www/kirsa-front

sudo cp ~/ubuntu_init/localback/kirsa_nginx /etc/nginx/sites-available/kirsa
sudo ln -s /etc/nginx/sites-available/kirsa /etc/nginx/sites-enabled/kirsa
sudo nginx -s reload

sudo mysql -e "CREATE DATABASE demands27 CHARACTER SET utf8 COLLATE utf8_general_ci;CREATE USER 'demands27'@'localhost' IDENTIFIED BY 'sXdfsdf33458Wwe1';GRANT ALL PRIVILEGES ON demands27.* TO 'demands27'@'localhost' WITH GRANT OPTION;create user 'nash'@'10.252.1.%';grant select on demands27.* to 'nash'@'10.252.1.%';create user 'pos'@'localhost';GRANT REPLICATION CLIENT ON *.* TO 'pos'@'localhost';flush privileges;"
sudo mysql demands27 -e "
CREATE TABLE nashcart_cart (
  id int NOT NULL AUTO_INCREMENT,
  creation_date datetime(6) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=14400 DEFAULT CHARSET=utf8mb3;"


sudo cp ~/ubuntu_init/localback/localback.cnf ~/ubuntu_init/localback/settings_local.cnf /etc/mysql/mysql.conf.d/
sudo nano /etc/mysql/mysql.conf.d/settings_local.cnf

###
sudo service mysql restart

# scp demands27.dmp.gz sunrise:~/
gunzip demands27_.dmp.gz
### mysql -u demands27 -p demands27 < demands27.dmp
sudo mysql demands27 < demands27_.dmp

# ssh tupak 'echo "000000"| sudo -S mysql demands27 -e "ALTER TABLE demands27.loutgopos ADD column amc_code varchar(150) null;"'
# ssh tupak 'echo "000000"| sudo -S mysql demands27 -e "ALTER TABLE demands27.loutgopos ADD CONSTRAINT loutgopos_amc_code_3d2375e0_uniq UNIQUE KEY (amc_code);"'
# -------------------------------
sudo mysql demands27 -e "
ALTER TABLE demands27.loutgopos DROP FOREIGN KEY loutgopos_outgo_id_6e59c97d_fk_loutgo_id;
ALTER TABLE demands27.loutgopos ADD CONSTRAINT loutgopos_outgo_id_6e59c97d_fk_loutgo_id FOREIGN KEY (outgo_id)
                                    REFERENCES demands27.loutgo(id) ON DELETE CASCADE ON UPDATE RESTRICT;
alter table kirsa_amc drop foreign key kirsa_amc_outgopos_id_46581fef_fk_kirsa_outgopos_id;
"

CHANGE MASTER TO MASTER_HOST='10.252.1.2', MASTER_USER='replication', MASTER_PASSWORD='Rehima123', \
       MASTER_LOG_FILE = 'binlog.000717', MASTER_LOG_POS=188006, GET_MASTER_PUBLIC_KEY=1;
start slave;
show slave status \G
# ------------------------------

### django

cd ~
git clone https://___get_token_on_obsidian___@github.com/tfyr/kirsa
cd ~/kirsa
git checkout some_moves

cd ~
git clone https://___get_token_on_obsidian___@github.com/tfyr/kirsa-kkm
git clone https://___get_token_on_obsidian___@github.com/tfyr/kirsa-kkmpos

git clone https://___get_token_on_obsidian___@github.com/tfyr/kirsa-pos
cd ~/kirsa-pos
git checkout nokkm

cd ~/kirsa
mkdir pos_json
mkdir pos_json/10
mkdir egais_cheques
python3 -m venv env
source env/bin/activate

pip install -r ~/ubuntu_init/localback/requirements.txt
pip install ~/ubuntu_init/localback/telegram-0.1.6.tar.gz ~/ubuntu_init/localback/promocodes-0.1.1.tar.gz
deactivate

cp ~/ubuntu_init/localback/settings_local.py ~/kirsa/kirsa
nano ~/kirsa/kirsa/settings_local.py

sudo cp ~/ubuntu_init/localback/daphne_kirsa.service /etc/systemd/system/
sudo systemctl enable daphne_kirsa
sudo systemctl start daphne_kirsa.service


#######################

cd ~/kirsa-pos
mkdir logs
printf "localback = True
user_DEBUG = False

user_databases = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'CONN_MAX_AGE': 0,
        'NAME': 'demands27',
        'USER': 'demands27',
        'PASSWORD': 'sXdfsdf33458Wwe1',
        'HOST': 'localhost', 'PORT': '3306',
        'OPTIONS': {
            'charset': 'utf8mb4',
        },
    },
}
"| tee -a settings_local.py

python3 -m venv env
source env/bin/activate
pip3 install fastapi[standard] mysqlclient
deactivate

sudo cp ~/ubuntu_init/kirsa_pos.service /etc/systemd/system/
sudo systemctl enable kirsa_pos
sudo systemctl start kirsa_pos.service


########################

cd ~/kirsa-kkmpos
mkdir logs
printf "viki_port = '/dev/ttyS91'
viki_baudrate = 115200
viki_options = 1
"| tee -a settings_local.py

python3 -m venv env
source env/bin/activate
pip3 install fastapi[standard] pyserial
deactivate

sudo cp ~/ubuntu_init/kirsa_kkmpos.service /etc/systemd/system/
sudo systemctl enable kirsa_kkmpos
sudo systemctl start kirsa_kkmpos.service


crontab -e
# */30 8-23 * * * cd ~/kirsa;env/bin/python tools/exchange_outgo.py

