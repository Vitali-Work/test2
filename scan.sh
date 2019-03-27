
#!/bin/bash
#while getopts :P:H:D:U:p: option 
#do 
# case "${option}" 
# in 
# P) db_port=${OPTARG};; 
# H) db_host=${OPTARG};; 
# D) db_schema=${OPTARG};;
# U) db_user=${OPTARG};;
# p) db_password=${OPTARG};;
# \?) ...;; 
# esac 
#done 
 
#echo "PORT:"$db_port 
#echo "HOST:"$db_host
#echo "schema:"$db_schema
#echo "db_user:"$db_user
#echo "db_password:"$db_password



scan_path=$1

#db_host=$2
#db_port=$3
#db_schema=$4
#db_user=$5
#db_password=$6
#real_scan_path=$(realpath $1)

while [ -n "$2" ]
do
	case "$2" in
	-P) db_port="$3" 
	shift  ;;
	-H) db_host="$3"
	shift  ;;
	-D) db_schema="$3"
	shift  ;;
	-U) db_user="$3"
	shift  ;;
	-p) db_password="$3" 
	shift  ;;
esac
shift
done

find $scan_path -type f -fprintf files.csv "'%f',%s,'%CY-%Cm-%Cd','%P'\n"
cp -f files.csv files2.csv

str='VALUES'
while read lines; do
str=$str',('$lines')'
done < files2.csv
echo "$str" >> ./output
sed -ri 's/,//' ./output
sed -ri 's/ /_/g' ./output
str=$(cat ./output)
rm output

echo ____________________
echo -n "Please, enter container name: "
read container_name

echo "PORT: "$db_port 
echo "HOST: "$db_host
echo "schema: "$db_schema
echo "db_user: "$db_user
echo "db_password: "$db_password

sudo docker exec -it $container_name sh -c 'exec mysql -h"'$db_host'" -P"'$db_port'" -u"'$db_user'" -p"'$db_password'" -e"
CREATE DATABASE IF NOT EXISTS '$db_schema';
USE '$db_schema';
CREATE TABLE IF NOT EXISTS files (
id INT NOT NULL AUTO_INCREMENT,
filename VARCHAR(255),
size INT,
created DATE,
path TEXT,
PRIMARY KEY (id)
);
INSERT INTO files (filename,size,created,path) '$str';"
"'











#sed -i '1s/^/filename,size,created,path ' files2.csv

#Pid=16
#Pfilename="'asde'"
#Psize=100
#Pdate="'2019-10-10'"
#Ppath="'asdads'"

#sudo docker run -it --net=testdocker_default --link testdocker_db_1:testdocker_db --rm testdocker_db sh -c 'exec mysql -h"172.18.0.2" -P"3306" -u"root" -p"A123dmin" -e"

#run -i --net=testdocker_default --link testdocker_db_1:testdocker_db --rm testdocker_db sh -c




#sudo docker run -i --net=testdocker_default --link testdocker_db_1:testdocker_db --rm testdocker_db sh -c 'exec mysql -h"172.18.0.2" -P"3306" -u"root" -p"A123dmin" -e"

#sudo docker run -i --net=testdocker_default --link testdocker_db_1:testdocker_db --rm testdocker_db sh -c 'exec mysql -h"'$db_host'" -P"'$db_port'" -u"'$db_user'" -p"'$db_password'" -e"

#done < files2.csv
#


#while read LINE; do
	#echo "$LINE"
#echo $SERVISE -b $LINE
#sudo docker run -i --net=testdocker_default --link testdocker_db_1:testdocker_db --rm testdocker_db sh -c 'exec mysql -h"172.18.0.2" -P"3306" -u"root" -p"A123dmin" -e"
#USE file_database;
#INSERT INTO file_data (filename,size,created,path) VALUES('$LINE');"'
#done < files2.csv


#sudo docker run -it --net=testdocker_default --link testdocker_db_1:testdocker_db --rm #testdocker_db sh -c 'exec mysql -h"172.18.0.2" -P"3306" -u"root" -p"A123dmin" -e"
#INSERT INTO file_data (filename,size,created,path) #VALUES('$Pfilename','$Psize','$Pdate','$Ppath');"'

#INSERT INTO file_data (filename,size,created,path) VALUES("asde",100,'2019-10-10',"asdads");

#INSERT INTO file_data VALUES(3,"asde",100,'2019-10-10',"asdads");

#BULK INSERT 'file_data'
#FROM '$filepath'
#WITH (fieldterminator = ',', rowterminator = '\n');
#"' 
#--events --triggers --routines >db_name.sql
#IF NOT EXISTS


#USE file_database;
#LOAD DATA LOCAL INFILE '$filepath'
#INTO TABLE file_data
#FIELDS TERMINATED BY ','
#ENCLOSED BY '*'
#LINES TERMINATED BY '\n'
#IGNORE 1 ROWS;"
