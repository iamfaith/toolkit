#!/usr/bin/bash
cd /home/faith/overleaf-toolkit/
mkdir -p ./sharelatex_backup/tmp
docker exec mongo bash -c "mongoexport --db=sharelatex --collection='projects' --jsonArray --out=files.json"
docker exec mongo bash -c "mongoexport --db=sharelatex --collection='docs' --jsonArray --out=docs.json"
docker exec mongo bash -c "mongoexport --db=sharelatex --collection='users' --jsonArray --out=users.json"
rm -rf ./sharelatex_backup/tmp/*
docker cp mongo:/files.json ./sharelatex_backup/tmp/files.json
docker cp mongo:/docs.json ./sharelatex_backup/tmp/docs.json
docker cp mongo:/users.json ./sharelatex_backup/tmp/users.json
# cd /mnt/backup/sharelatex_backup
/home/faith/miniconda3/bin/python export.py