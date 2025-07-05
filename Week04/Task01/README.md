# Ficha de Trabalho

**Curso:** Fundamentos da linguagem SQL  
**UFCD/Módulo/Temática:** UFCD 10788 - Fundamentos da linguagem SQL  
**Ação:** 10788_1/AG - 10788 - Fundamentos da linguagem SQL  
**Formador/a:** Hugo Dias  
**Data:** 27/06/2025  
**Nome do Formando/a:** `Pedro Dias`

---

## 📅 Prazos de entrega e submissão

O trabalho tem de ser entregue através do sistema de submissão do Moodle até às **23h59 do dia 07 de julho**.

---

## 📄 Trabalho de SQL - Gestão de Artigos de um Jornal

### 🎯 Objetivo

Conceber e manipular uma base de dados relacional simples com comandos SQL, simulando o funcionamento editorial de um jornal — desde a redação de artigos até à respetiva publicação.

### 📝 Descrição

O trabalho consiste em criar uma base de dados para gerir **artigos**, **jornalistas**, **categorias** e **edições** do jornal. Os formandos deverão:

- Criar as tabelas,
- Inserir dados,
- Realizar consultas/queries úteis para a redação.

> O trabalho pode ser implementado através da base de dados **SQLite** ou **MySQL**.

---

## 🧱 Tabelas do Modelo

1. **jornalista**
   - `id_jornalista` (INT, PK)
   - `nome` (TEXT)
   - `especialidade` (TEXT)

2. **categoria**
   - `id_categoria` (INT, PK)
   - `nome` (TEXT) — ex: Política, Cultura, Desporto

3. **artigo**
   - `id_artigo` (INT, PK)
   - `titulo` (TEXT)
   - `data_publicacao` (DATE)
   - `id_jornalista` (INT, FK → jornalista.id_jornalista)
   - `id_categoria` (INT, FK → categoria.id_categoria)

4. **edicao**
   - `id_edicao` (INT, PK)
   - `data_edicao` (DATE)

5. **artigo_edicao**
   - `id_artigo` (INT, FK → artigo.id_artigo)
   - `id_edicao` (INT, FK → edicao.id_edicao)

---

## ✅ Funcionalidades (Tarefas/Consultas a Realizar)

### 📌 Parte 1: Criação das Tabelas

1. Criar todas as tabelas com as chaves primárias e estrangeiras corretamente definidas.
2. Inserir pelo menos:
   - 5 jornalistas
   - 3 categorias
   - 10 artigos
   - 5 edições
   - Registos correspondentes na tabela `artigo_edicao`

### 🔎 Parte 2: Consultas

1. Listar todos os artigos com nome do jornalista e categoria  
2. Listar os títulos de todos os artigos publicados a **01-Jun-2025**  
3. Mostrar o número total de artigos por categoria  
4. Mostrar os jornalistas que publicaram mais de 2 artigos mas em meses diferentes  
5. Mostrar os artigos ainda não associados a nenhuma edição  
6. Listar as categorias com mais de um artigo publicado  
7. Mostrar a média de artigos por edição  
8. Atualizar a data de publicação do artigo mais antigo para **01/01/2025**  
9. Remover os jornalistas só com um artigo  
10. Listar o nome dos jornalistas com mais de um artigo em todas as edições  
