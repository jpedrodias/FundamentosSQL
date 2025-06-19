# 🐳 Preparação do sistema para correr em Docker:
Neste docker-compose existem dois servidores de base de dados (mysql e postgres) e três serviços para aceder via web a esses servidores.

**Servidores** - Sistemas de Gerenciamento de Banco de Dados (SGBD):
- 🐬 **MySQL**	- SGBD Relacional (RDBMS);
- 🐘 **PostgreSQL** - SGBD Relacional Avançado (ORDBMS)


**Ferramentas de acesso via Web** - Ferramentas de Administração de Banco de Dados:
- 🛠️ **Adminer**: Suporta vários SGBDs via uma única interface PHP leve;
- 🐘 **pgAdmin**: Ferramenta oficial de administração para PostgreSQL;
- 🐬 **phpMyAdmin**: Focado em MySQL/MariaDB, com uma interface web.


Etadas da instalação:
## 0. Pré-requisito:
Ter o docker instalado.
[Docker Desktop](https://www.docker.com/get-started/)


## 1. Clonar este repositório:
```bash
git clone https://github.com/jpedrodias/FundamentosSQL.git
cd FundamentosSQL
```
ou copiar apenas os ficheiros: `docker-compose.yml` e `.env` 

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


## 3. Dados de acesso
3.1 ao servidor MySQL  
```yml
Servidor: mysql
user: mysql_user
password: mysql_password
base de dados: mydatabase
```


3.2 ao servidor Postgress  
```yml
Servidor: postgres
user: postgres_user
password: postgres_password
base de dados: mydatabase
```


## 4. Aceder às db via Adminer, pgAdmin ou phpMyAdmin
- http://localhost:8081 - **Adminer** (para ligação a mysql e postgres)
- http://localhost:8082 - **pgAdmin** (admin@admin.com | admin) (para ligação apenas postgres)
- http://localhost:8083 - **phpMyAdmin** (para ligalão apenas mysql/mariadb)


***

# 📓 Preparação do sistema para correr em Jupyter Notebook

```python
!pip install jupysql ipython-sql sqlite3

%load_ext sql
%sql sqlite:///database.sqlite

%config SqlMagic.displaylimit = None
%sql PRAGMA foreign_keys = ON
```

## a. Online Jupyter
- [Google Colab](https://colab.research.google.com/)
- [Jupyter](https://jupyter.org/try-jupyter/lab/)


## b. Local Jupyter
```bash
python -m venv C:\TEMP\venvs\FundamentosSQL
C:\TEMP\venvs\FundamentosSQL\Scripts\Activate.ps1
pip install -r requirements.txt
```

***

# 🧰 Ferramentas para ligação a Bases de Dados
## a. aplicações
- [DBveaver](https://dbeaver.io/download/) - ligação a diferentes bases de dados;
- [sqlite3](https://www.sqlite.org/download.html) - ferramenta de linha de comandos para ligar a sqlite;
- [DB Browser for SQLite](https://sqlitebrowser.org/) - ferramenta gráfica para sqlite;
- [pgAdmin](https://www.pgadmin.org/download/) - ligação a db postgres;
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) - para ligação a db mysql/mariadb
- [SqlDbx](https://www.sqldbx.com/index.htm) - ligação a diferentes bases de dados;


## b. ferramentas web
- [Adminer](https://www.adminer.org/en/)
- [pgAdmin](https://www.pgadmin.org/download/pgadmin-4-container/)
- [phpMyAdmin](https://www.phpmyadmin.net/)


## b. apenas online
- [SandboxSQL](https://sandboxsql.com/)