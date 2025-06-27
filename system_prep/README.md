# Preparação do sistema para correr em Docker, Jupyter ou VM

- 🐳 [Docker](#-preparação-do-sistema-para-correr-em-docker)
- 📓 [Jupyter Notebook](#-preparação-do-sistema-para-correr-em-jupyter-notebook)
- 🖥️ [Máquina virtual](#-preparação-do-sistema-para-correr-em-máquina-virtual)
- 🧰 [Outras ferramentas](#-ferramentas-para-ligação-a-bases-de-dados)



---

## 🐳 Preparação do sistema para correr em Docker

Nos ficheiros de *compose* incluídos neste repositório existem diferentes cenários de base de dados e respetivas ferramentas de administração:

| Ficheiro                      | Servidores                        | Ferramentas Web                             |
|-------------------------------|-----------------------------------|---------------------------------------------|
| **docker-compose.yml**        | MySQL                             | Adminer, phpMyAdmin                         |
| **docker-compose-extra.yml**  | MySQL, PostgreSQL, MongoDB        | Adminer, phpMyAdmin, pgAdmin, Mongo Express |
| **docker-compose-oracle.yml** | OracleDB CE (Community Edition)   | *Ainda não totalmente testado*              |



**Servidores** - Sistemas de Gerenciamento de Banco de Dados (SGBD):
- 🐬 **MySQL**	- SGBD Relacional (RDBMS);
- 🐘 **PostgreSQL** - SGBD Relacional Avançado (ORDBMS)
- 🍃 **MongoDB** — SGBD NoSQL orientado a documentos (Document Store)
- 🔶 **OracleDB CE** — SGBD Relacional Corporativo (RDBMS) com recursos avançados, versão gratuita Community Edition (CE) para testes e desenvolvimento


**Ferramentas de acesso via Web** - Ferramentas de Administração de Banco de Dados:
- 🛠️ **Adminer**: Suporta vários SGBDs via uma única interface PHP leve;
- 🐬 **phpMyAdmin**: Focado em MySQL/MariaDB, com uma interface web;
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


## 2. Inicial docker container:
```bash
cd system_prep
docker compose up
```
Para manter os serviços ligados é necessário manter o terminal aberto e para parar estes serviços basta pressionar `Ctrl+C`

Em alternativa, é possível iniciar os serviços em background adicionando a flag ` -d` (detached mode) desta forma:
```bash
cd system_prep
docker compose up -d
```
E neste caso, para parar estes serviço que ficaram a correr em background basta fazer `docker compose down` ou fazer stop dentro do Docker Desktop.


**Extra**:
- Para correr a versão mais completa, com mais serviços (mysql, postgres e mongodb), basta utilizar o comando:
```bash
docker compose -f docker-compose-extra.yml up
```

- Para correr a ver~so sem licença da base de dados da oracle, usar o comando:
```bash
docker compose -f docker-compose-oracle.yml up
```


## 3. Dados de acesso:

3.1. ao servidor `MySQL`
```yml
Servidor: mysql
user: mysql_user
password: mysql_password
base de dados: mydatabase
```

3.1. ao servidor `PostgresDB`
```yml
Servidor: postgres
user: postgres_user
password: postgres_password
base de dados: mydatabase
```

3.3. ao servidor `MongoDB`
```yml
Servidor: mongo
user: mongo_user
password: mongo_password
base de dados: mydatabase
```

3.4. ao servidor `OracleDB CE`
```yml
Servidor: oracle
user: system
password: oracle_password
base de dados: mydatabase
```


## 4. Aceder às bases de dados via clientes web (sem instalações adicionais):
- http://localhost:8081 - **Adminer** é uma ferramenta para ligação ao servidor mysql e postgres;
- http://localhost:8082 - **phpMyAdmin** é uma ferramanta par aligação ao servidor mysql e mariadb;
- http://localhost:8083 - **pgAdmin** (user: admin@admin.com | pass: admin) é uma ferramenta para ligação ao servidor postgres;
- http://localhost:8084 - **Mongo Express** (user: admin | pass: pass) é uma ferramenta para ligação ao servidor MongoDB.


## 5. 🧹 Limpeza completa do `cache` Docker:
Embora o Docker não tenha uma pegada tão grande quanto uma máquina virtual tradicional, continua a ser uma forma de virtualização que pode consumir espaço considerável em disco. Para além das imagens descarregadas, o Docker cria volumes, redes e outros artefactos que podem acumular-se ao longo do tempo.
Nem sempre o Docker Desktop exibe a totalidade dos recursos utilizados, pelo que, para efetuar uma limpeza completa do cache, podem ser usados os seguintes comandos:
```bash
docker compose down
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q) -f
docker volume rm $(docker volume ls -q)
docker network prune -f
docker system prune -a --volumes -f
```

ℹ️ Nota: Os volumes Docker armazenam dados persistentes, como os das bases de dados.
⚠️ Atenção: Estes comandos devem ser utilizados com precaução, pois poderão eliminar mais do que o pretendido, incluindo dados importantes que não possam ser recuperados.



---

# 📓 Preparação do sistema para correr em Jupyter Notebook:
O `JupySQL` permite executar comandos SQL e criar gráficos de grandes conjuntos de dados no Jupyter através das magias %sql, %%sql e %sqlplot. O JupySQL é compatível com todos os principais bancos de dados (por exemplo, PostgreSQL, MySQL, SQL Server), data warehouses (como Snowflake, BigQuery, Redshift) e motores embarcados (SQLite e DuckDB).

[ver JupySQL](https://jupysql.ploomber.io/en/latest/quick-start.html)


```python
!pip install ipykernel jupyterlab jupysql --upgrade --no-cache-dir
!pip cache purge

%load_ext sql
%sql sqlite:///database.sqlite

%config SqlMagic.displaylimit = 0
%sql PRAGMA foreign_keys = ON
```

## a) Correr Jupyter Online:
- [Google Colab](https://colab.research.google.com/)
- [Try Jupyter Lab](https://jupyter.org/try-jupyter/lab/)


## b) Correr Jupyter localmente em windows:
```bash
python -m venv C:\TEMP\venvs\FundamentosSQL
C:\TEMP\venvs\FundamentosSQL\Scripts\Activate.ps1
pip install -r requirements.txt --upgrade --no-cache-dir
pip cache purge
```


## c) Correr Jupyter localmente em macOS/Linux:
```bash
python3 -m venv /tmp/FundamentosSQL
source /tmp/FundamentosSQL/bin/activate
pip install -r requirements.txt --upgrade --no-cache-dir
pip cache purge
```



---
# 🖥️ Preparação do sistema para correr em máquina virtual:
- [Oracle Database Free VirtualBox Appliance](https://www.oracle.com/database/technologies/databaseappdev-vm.html) (da Oracle)
    - user: oracle | system, password: oracle
    - fazer atualizações
    ```bash
    sudo dnf check-updates
    sudo dnf clean all
    ```
- [Máquinal Virtual "Mint" com base de dados MySql e Postgress](https://drive.google.com/file/d/15cBQOABUNHihoPV5I7NGLIcFw-IkJ3k7/view)
    - user: osboxes.org, password: osboxes.org
    - fazer/forçar atualizações:
    ```bash
    sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y
    sudo apt autoclean -y && sudo apt autoremove -y
    ```
    - consertar falhas na atualização:
    ```bash
    sudo apt -fix-missing install
    ```


---

# 🧰 Ferramentas para ligação a bases de dados:
## a) aplicações:
- [DBveaver](https://dbeaver.io/download/) - ligação a diferentes bases de dados (sqlite, mysql, postgres, mongodb, oracle, etc);
- [sqlite3](https://www.sqlite.org/download.html) - ferramenta de linha de comandos para ligar a sqlite;
- [DB Browser for SQLite](https://sqlitebrowser.org/) - ferramenta gráfica para sqlite;
- [pgAdmin](https://www.pgadmin.org/download/) - ligação a db postgres;
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) - para ligação a db mysql/mariadb
- [SqlDbx](https://www.sqldbx.com/index.htm) - ligação a diferentes bases de dados;
- [MongoDB Compass](https://www.mongodb.com/try/download/compass) - para ligação a MongoDB


## b) ferramentas web:
- [Adminer](https://www.adminer.org/en/)
- [phpMyAdmin](https://www.phpmyadmin.net/)
- [pgAdmin](https://www.pgadmin.org/download/pgadmin-4-container/)
- [Mongo Express](https://github.com/mongo-express/mongo-express)


## b) apenas online:
- [SandboxSQL](https://sandboxsql.com/)


---
