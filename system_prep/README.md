# Preparação do sistema:
* [Docker](#-prepara%C3%A7%C3%A3o-do-sistema-para-correr-em-docker)
* [Jupyter](#-prepara%C3%A7%C3%A3o-do-sistema-para-correr-em-jupyter-notebook)
* [Outras ferramentas](#-ferramentas-para-liga%C3%A7%C3%A3o-a-bases-de-dados)

---

# 🐳 Preparação do sistema para correr em Docker:
Neste docker-compose existem dois servidores de base de dados (mysql e postgres) e três serviços para aceder via web a esses servidores.

**Servidores** - Sistemas de Gerenciamento de Banco de Dados (SGBD):
- 🐬 **MySQL**	- SGBD Relacional (RDBMS);
- 🐘 **PostgreSQL** - SGBD Relacional Avançado (ORDBMS)
- 🍃 **MongoDB** — SGBD NoSQL orientado a documentos (Document Store)


**Ferramentas de acesso via Web** - Ferramentas de Administração de Banco de Dados:
- 🐬 **phpMyAdmin**: Focado em MySQL/MariaDB, com uma interface web;
- 🛠️ **Adminer**: Suporta vários SGBDs via uma única interface PHP leve;
- 🐘 **pgAdmin**: Ferramenta oficial de administração para PostgreSQL;
- 🍃 **Mongo Express**: Interface web leve para administração do MongoDB.


---
# 🛠️ Etapas da instalação:
## 0. Pré-requisito:
Ter o *Git* e o *Docker Desktop* instalado:
- 🐳 [Git](https://git-scm.com/downloads)
- 🐙 [Docker Desktop](https://www.docker.com/get-started/)


Ou em alternativa, fazer a instalação usando `winget` (em Windows)
```bash
winget update
winget install -e --id Git.Git
winget install -e --id Docker.DockerDesktop
```


## 1. Clonar este repositório:
```bash
git clone https://github.com/jpedrodias/FundamentosSQL.git
cd FundamentosSQL
```
ou copiar apenas o ficheiro `docker-compose.yml` (ou `docker-compose-extra.yml`) e o ficheiro `.env` com a definção das variáveis de ambiente. 


## 2. Inicial docker container
```bash
cd system_prep
docker compose up
```
Para manter os serviços ligados é necessário manter o terminal aberto e para parar estes serviços basta pressionar "`Ctrl+C`"

Em alternativa, é possível iniciar os serviços em background adicionando a flag ` -d` desta forma:
```bash
cd system_prep
docker compose up -d
```
E neste caso, para parar estes serviço basta fazer `docker compose down`


**Extra**:
* Para correr uma versão com apenas mais serviços (mysql, postgres e mongodb), 
basta utilizar o comando `docker compose -f docker-compose-extra.yml up`.


## 3. Dados de acesso
3.1. ao servidor `PostgresDB`  
```yml
Servidor: postgres
user: postgres_user
password: postgres_password
base de dados: mydatabase
```

3.2. ao servidor `MySQL`  
```yml
Servidor: mysql
user: mysql_user
password: mysql_password
base de dados: mydatabase
```

3.3. ao servidor `MongoDB`  
```yml
Servidor: mongo
user: mongo_user
password: mongo_password
base de dados: mydatabase
```


## 4. Aceder às db via Adminer, pgAdmin ou phpMyAdmin
- http://localhost:8081 - **Adminer** (para ligação a mysql e postgres)
- http://localhost:8082 - **phpMyAdmin** (apenas mysql/mariadb)
- http://localhost:8083 - **pgAdmin** (admin@admin.com | admin) (para ligação apenas postgres)
- http://localhost:8084 - **Mongo Express** (admin | pass) (apenas MongoDB)



## 5. 🧹 Limpeza completa do `cache` Docker
Para além do download das imagens, o docker cria volumes que podem ocupar algum espaço em disco. 
Usar as instruções seguintes com ponderação, pois poderá resultar na eliminação de mais do que deseja ou precisa. 

```bash
docker compose down
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q) -f
docker volume rm $(docker volume ls -q)
docker network prune -f
docker system prune -a --volumes -f
```



---
# 📓 Preparação do sistema para correr em Jupyter Notebook
O `JupySQL` permite executar comandos SQL e criar gráficos de grandes conjuntos de dados no Jupyter através das magias %sql, %%sql e %sqlplot. O JupySQL é compatível com todos os principais bancos de dados (por exemplo, PostgreSQL, MySQL, SQL Server), data warehouses (como Snowflake, BigQuery, Redshift) e motores embarcados (SQLite e DuckDB).

[ver JupySQL](https://jupysql.ploomber.io/en/latest/quick-start.html)


```python
!pip install ipykernel jupyterlab jupysql --upgrade --no-cache-dir
!pip cache purge

%load_ext sql
%sql sqlite:///database.sqlite

%config SqlMagic.displaylimit = None
%sql PRAGMA foreign_keys = ON
```

## a) Online Jupyter
- [Google Colab](https://colab.research.google.com/)
- [Try Jupyter Lab](https://jupyter.org/try-jupyter/lab/)


## b) Local Jupyter
```bash
python -m venv C:\TEMP\venvs\FundamentosSQL
C:\TEMP\venvs\FundamentosSQL\Scripts\Activate.ps1
pip install -r requirements.txt --no-cache-dir
pip cache purge
```


---
# 🧰 Ferramentas para ligação a Bases de Dados
## a) aplicações
- [DBveaver](https://dbeaver.io/download/) - ligação a diferentes bases de dados;
- [sqlite3](https://www.sqlite.org/download.html) - ferramenta de linha de comandos para ligar a sqlite;
- [DB Browser for SQLite](https://sqlitebrowser.org/) - ferramenta gráfica para sqlite;
- [pgAdmin](https://www.pgadmin.org/download/) - ligação a db postgres;
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) - para ligação a db mysql/mariadb
- [SqlDbx](https://www.sqldbx.com/index.htm) - ligação a diferentes bases de dados;
- [MongoDB Compass](https://www.mongodb.com/try/download/compass) - para ligação a MongoDB


## b) ferramentas web
- [Adminer](https://www.adminer.org/en/)
- [phpMyAdmin](https://www.phpmyadmin.net/)
- [pgAdmin](https://www.pgadmin.org/download/pgadmin-4-container/)
- [Mongo Express](https://github.com/mongo-express/mongo-express)


## b) apenas online
- [SandboxSQL](https://sandboxsql.com/)


---

