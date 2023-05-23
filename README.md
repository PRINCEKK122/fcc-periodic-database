# fcc-periodic-database

1. First you should have Postgresql installed. To check if you have an installation of Postgresql open up your terminal and type `psql --version`.

2. If the above was successful, populate the database by entering the following command in your terminal `psql -U postgres < periodic_table.sql`. This will create database and insert some records.

3. Add the executable permissions to the `element.sh` file by running this command `chmod +x element.sh`

4. Run the script in your terminal `./element.sh <argument:int|string>`. To check for the valid argument, you can query the database in your Postgres client by entering the following command 
```
SELECT * FROM elements;
```