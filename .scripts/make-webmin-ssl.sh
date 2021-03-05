file=/etc/webmin/miniserv.pem

sudo openssl req -x509 -newkey rsa:2048 -keyout $file  -out $file \
 -days 3650 -nodes -subj \
 "/C=DE/ST=NRW/L=Brakel/O=Infoniqa/CN=www.infoniqa.com" 

sudo openssl x509 -x509toreq -in $file -signkey $file >> $file

sudo /etc/webmin/restart
