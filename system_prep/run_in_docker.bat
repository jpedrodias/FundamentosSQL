@echo off
chcp 65001 >nul

if "%1"=="" goto MENU
if not "%1"=="" goto RUN

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
echo *. Todos os servidores
echo 0. Sair
echo ==========================================
set /p op=Opção: 

if "%op%"=="1" %0 mysql
if "%op%"=="2" %0 postgres
if "%op%"=="3" %0 mongo
if "%op%"=="4" %0 oracle
if "%op%"=="5" %0 sqlserver
if "%op%"=="*" %0 ALL
if "%op%"=="0" exit

echo Opção inválida!
pause
goto MENU

:RUN
docker compose -f docker-compose-%1.yml up
pause
goto MENU

:EOF