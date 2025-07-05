@echo off
chcp 65001 >nul
:MENU
cls
echo ==========================================
echo   Escolha o serviço Docker a arrancar:
echo ==========================================
echo 1. MySQL
echo 2. PostgreSQL
echo 3. MongoDB
echo 4. OracleDB CE
echo 5. Microsoft SQL Server Express
echo 6. Todos os servidores
echo 0. Sair
echo ==========================================
set /p op=Opção: 

if "%op%"=="1" (
    docker compose -f docker-compose-mysql.yml up
    pause
    goto MENU
)

if "%op%"=="2" (
    docker compose -f docker-compose-postgres.yml up
    pause
    goto MENU
)
if "%op%"=="3" (
    docker compose -f docker-compose-mongo.yml up
    pause
    goto MENU
)

if "%op%"=="4" (
    docker compose -f docker-compose-oracle.yml up
    pause
    goto MENU
)

if "%op%"=="5" (
    docker compose -f docker-compose-sqlserver.yml up
    pause
    goto MENU
)

if "%op%"=="6" (
    docker compose -f docker-compose-ALL.yml up
    pause
    goto MENU
)

if "%op%"=="0" exit

echo Opção inválida!
pause
goto MENU