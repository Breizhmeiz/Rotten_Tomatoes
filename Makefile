data_importer:
	python data_importer.py

init:
	pip install -r requirements.txt

test:
	pytest tests

run:
	python data_importer.py

mysql_docker:
	docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -d mysql

mysql_local_docker:
	docker run --name mysql -v "$(PWD)/mysql_data":/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -d mysql

mysql_dump:
	docker exec mysql sh -c 'exec mysqldump --all-databases -uroot -p"root"' > all-databases.sql

mysql_restore:
	docker exec -i mysql sh -c 'exec mysql -uroot -p"root"' < all-databases.sql
