# Preparação do sistema usando Docker:

# 1. Clonar:
```bash
git clone https://github.com/jpedrodias/FundamentosSQL.git
cd FundamentosSQL
```

# 2. Inicial docker container
```bash
cd system_prep
docker compose up -d
```

# 3. Dados de acesso
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

# 4. Aceder ao Adminer, pgAdmin ou phpMyAdmin
```bash
http://localhost:8081 - Adminer
http://localhost:8082 - pgAdmin
http://localhost:8083 - phpMyAdmin

```

6. Outras ferramentas

[DBveaver](https://dbeaver.io/download/)
[pgAdmin](https://www.pgadmin.org/download/)
[sqlite3](https://www.sqlite.org/download.html)
