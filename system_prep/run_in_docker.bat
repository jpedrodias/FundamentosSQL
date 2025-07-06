@echo off
chcp 65001 >nul

if "%1"=="" goto MENU
if not "%1"=="" goto RUN

:MENU
cls
echo ==========================================
echo   Escolha o serviço Docker a arrancar:
echo =SERVIDORES===============================
echo [ 1 ] - MySQL
echo [ 2 ] - PostgreSQL
echo [ 3 ] - MongoDB
echo [ 4 ] - OracleDB CE
echo [ 5 ] - Microsoft SQL Server Express
echo [ * ] - Iniciar todos os servidores
echo [ x ] - STOP Parar todos os servidores
echo [ ! ] - PURGE - Limpar tudo (redes, volumes e imagens)
echo [ 0 ] - Sair
echo =FERRAMENTAS==============================
echo [ A ] - Iniciar Adminer
echo [ B ] - Iniciar phpMyAdmin
echo [ C ] - Iniciar pgAdmin
echo [ D ] - Iniciar Mongo Express
echo [ E ] - Iniciar Adminer_ci8
set /p op=Opção: 

if "%op%"=="1" %0 mysql
if "%op%"=="2" %0 postgres
if "%op%"=="3" %0 mongo
if "%op%"=="4" %0 oracle
if "%op%"=="5" %0 sqlserver
if "%op%"=="*" %0 ALL

if "%op%"=="A" %0 adminer
if "%op%"=="B" %0 phpmyadmin
if "%op%"=="C" %0 pgadmin
if "%op%"=="D" %0 mongo_express
if "%op%"=="E" %0 adminer_ci8

if "%op%"=="x" goto STOP
if "%op%"=="!" goto PURGE
if "%op%"=="0" exit

echo Opção inválida!
pause
goto MENU


:PURGE
docker compose down
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q) -f
docker volume rm $(docker volume ls -q)
docker network prune -f
docker system prune -a --volumes -f
echo Limpeza completa!
pause
goto MENU


:STOP
docker compose down
goto MENU

:RUN
docker compose -f docker-compose-%1.yml up -d
pause
goto MENU

:EOF