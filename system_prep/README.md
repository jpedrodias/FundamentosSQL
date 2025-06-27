# Preparação do sistema para correr em Docker, Jupyter ou VM

- 🐳 [Docker](#-preparação-do-sistema-para-correr-em-docker)
- 📓 [Jupyter Notebook](#-preparação-do-sistema-para-correr-em-jupyter-notebook)
- 🖥️ [Máquina virtual](#-preparação-do-sistema-para-correr-em-máquina-virtual)
- 🧰 [Outras ferramentas](#-ferramentas-para-ligação-a-bases-de-dados)


---
---

# 🐳 Preparação do sistema para correr em Docker

Nos ficheiros de *compose* incluídos neste repositório existem diferentes cenários de base de dados e respetivas ferramentas de administração:

| Ficheiro                      | Servidores                        | Ferramentas Web                             |
|-------------------------------|-----------------------------------|---------------------------------------------|
| **docker-compose.yml**        | MySQL                             | Adminer, phpMyAdmin                         |
| **docker-compose-extra.yml**  | MySQL, PostgreSQL e MongoDB       | Adminer, phpMyAdmin, pgAdmin, Mongo Express |
| **docker-compose-oracle.yml** | OracleDB CE (Community Edition)   | Adminer_ci8 (versão não oficial)            |



## Servidores incluídos

- 🐬 **[MySQL](https://www.mysql.com/)** — SGBD relacional (RDBMS)
- 🐘 **[PostgreSQL](https://www.postgresql.org/)** — SGBD relacional avançado (ORDBMS)
- 🍃 **[MongoDB](https://www.mongodb.com/)** — Base de dados NoSQL orientada a documentos (Document Store)
- 🔶 **[OracleDB CE](https://www.oracle.com/pt/database/technologies/appdev/xe.html)** — SGBD relacional corporativo, versão gratuita *Community Edition* para testes e desenvolvimento

## Ferramentas de administração via Web

- 🛠️ **[Adminer](https://www.adminer.org/)** — Interface única, leve, compatível com vários SGBDs
- 🐬 **[phpMyAdmin](https://www.phpmyadmin.net/)** — Interface clássica para MySQL/MariaDB
- 🐘 **[pgAdmin](https://www.pgadmin.org/)** — Ferramenta oficial de administração PostgreSQL
- 🍃 **[Mongo Express](https://github.com/mongo-express/mongo-express)** — Interface leve para MongoDB


---
---

## 🛠️ Etapas da instalação

### 0. Pré-requisitos

Certifique-se de que tem **Git** e **Docker Desktop** instalados:

- 🐳 [Git](https://git-scm.com/downloads)
- 🐙 [Docker Desktop](https://www.docker.com/get-started/)


Como alternativa, em windows, é possível fazer esta instalação usando o **winget**:

```bash
winget update
winget install -e --id Git.Git
winget install -e --id Docker.DockerDesktop
```


### 1. Clonar este repositório
```bash
git clone https://github.com/jpedrodias/FundamentosSQL.git
cd FundamentosSQL
```
> Ou, em alternatica, copie apenas o ficheiro `docker-compose.yml` e o ficheiro `.env`.


### 2. Inicial docker container:
```bash
cd system_prep
docker compose up
```
> Para manter os serviços ligados é necessário manter o terminal aberto e para parar estes serviços basta pressionar `Ctrl+C`

Para iniciar os serviços em background é a mesma instrução mas, com a flag ` -d` (detached mode):
```bash
cd system_prep
docker compose up -d
```
> E neste caso, para parar estes serviço que ficaram a correr em background fazer `docker compose down` ou fazer stop dentro do Docker Desktop.


#### Extra:
- Para correr a versão com mais serviços (mysql, postgres e mongodb), basta utilizar o comando:
>    ```bash
>    docker compose -f docker-compose-extra.yml up
>    ```

- Para correr a versão sem com a base de dados da Oracle, usar o comando:
>    ```bash
>    docker compose -f docker-compose-oracle.yml up
>    ```


### 3. Dados de acesso:

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



### 4. Clientes Web (sem instalações adicionais)
|LINK               |Serviço                  |Descrição                      |compose|extra|oracle|
|-------------------|-------------------------|-------------------------------|-------|-----|------|
|[http://localhost:8081](http://localhost:8081)|Adminer|MySQL & PostgreSQL|✅|✅|❌|
|[http://localhost:8082](http://localhost:8082)|phpMyAdmin|MySQL & MariaDB|✅|✅|❌|
|[http://localhost:8083](http://localhost:8083)|pgAdmin|(user: `admin@admin.com`, pass: `admin`)|❌|✅|❌|
|[http://localhost:8084](http://localhost:8084)|Mongo Express|(user: `admin`, pass: `pass`)|❌|✅|❌|
|[http://localhost:8085](http://localhost:8085)|Adminer_ci8|Oracle|❌|❌|✅|




### 5. 🧹 Limpeza completa do *cache* do Docker

Embora o Docker não tenha uma pegada tão grande quanto uma máquina virtual tradicional, continua a ser uma forma de virtualização que pode consumir espaço considerável em disco. Para além das imagens descarregadas, o Docker cria volumes, redes e outros artefactos que se podem acumular.

Nem sempre o Docker Desktop exibe todos os recursos ocupados. Para efetuar uma limpeza completa do *cache* utilize:

```bash
docker compose down
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q) -f
docker volume rm $(docker volume ls -q)
docker network prune -f
docker system prune -a --volumes -f
```

> ℹ️ **Nota:** Os *volumes* Docker armazenam dados persistentes, como os das bases de dados.  
> ⚠️ **Atenção:** Use estes comandos com precaução, pois podem eliminar dados importantes que não possam ser recuperados.



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
