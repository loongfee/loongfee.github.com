sudo apt-get install python-pip
sudo pip install google-api-python-client
sudo -H pip install oauth2client
sudo pip install earthengine-api
sudo pip install matplotlib
sudo pip install pandas
sudo pip install shapely
sudo pip install geopandas
sudo pip install wget
sudo pip install geojson

sudo add-apt-repository -y ppa:ubuntugis/ppa
sudo apt update 
sudo apt upgrade # if you already have gdal 1.11 installed 
sudo apt install gdal-bin python-gdal

sudo pip install jupyter
jupyter notebook --generate-config
jupyter notebook password

cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
wget https://raw.githubusercontent.com/loongfee/loongfee.github.com/source/public/share/dropbox.py

python dropbox.py start
python dropbox.py exclude add Apps Software Public Document

nohup jupyter-notebook --allow-root --ip 0.0.0.0 ~/Dropbox/jupyter/ &>log &