
/*
    PROJETO: Banco de Dados - Jogo de RPG Online
    SGBD: Microsoft SQL Server
    OBJETIVO: Criacao do banco e das tabelas conforme o diagrama ER.
*/

-- 1. Criacao do banco de dados
IF DB_ID('RPG_Online') IS NULL
BEGIN
    CREATE DATABASE RPG_Online;
END;
GO

USE RPG_Online;
GO

-- 2. Tabela de usuarios
IF OBJECT_ID('dbo.USUARIOS', 'U') IS NULL
BEGIN
    CREATE TABLE USUARIOS (
        UsuarioId INT IDENTITY(1,1) NOT NULL,
        Email NVARCHAR(255) NOT NULL,
        Senha NVARCHAR(255) NOT NULL,

        CONSTRAINT PK_USUARIOS PRIMARY KEY (UsuarioId),
        CONSTRAINT UQ_USUARIOS_Email UNIQUE (Email)
    );
END;
GO

-- 3. Tabela de classes
IF OBJECT_ID('dbo.CLASSES', 'U') IS NULL
BEGIN
    CREATE TABLE CLASSES (
        ClasseId INT IDENTITY(1,1) NOT NULL,
        Nome NVARCHAR(100) NOT NULL,
        Descricao NVARCHAR(500) NULL,

        CONSTRAINT PK_CLASSES PRIMARY KEY (ClasseId)
    );
END;
GO

-- 4. Tabela de habilidades
IF OBJECT_ID('dbo.HABILIDADES', 'U') IS NULL
BEGIN
    CREATE TABLE HABILIDADES (
        HabilidadeId INT IDENTITY(1,1) NOT NULL,
        Nome NVARCHAR(100) NOT NULL,

        CONSTRAINT PK_HABILIDADES PRIMARY KEY (HabilidadeId)
    );
END;
GO

-- 5. Tabela de personagens
IF OBJECT_ID('dbo.PERSONAGENS', 'U') IS NULL
BEGIN
    CREATE TABLE PERSONAGENS (
        PersonagemId INT IDENTITY(1,1) NOT NULL,
        NomePersonagem NVARCHAR(100) NOT NULL,
        UsuarioId INT NOT NULL,
        ClasseId INT NOT NULL,

        CONSTRAINT PK_PERSONAGENS PRIMARY KEY (PersonagemId),

        CONSTRAINT FK_PERSONAGENS_USUARIOS
            FOREIGN KEY (UsuarioId)
            REFERENCES USUARIOS (UsuarioId),

        CONSTRAINT FK_PERSONAGENS_CLASSES
            FOREIGN KEY (ClasseId)
            REFERENCES CLASSES (ClasseId)
    );
END;
GO

-- 6. Tabela associativa entre classes e habilidades
IF OBJECT_ID('dbo.CLASSES_HABILIDADES', 'U') IS NULL
BEGIN
    CREATE TABLE CLASSES_HABILIDADES (
        ClasseId INT NOT NULL,
        HabilidadeId INT NOT NULL,

        CONSTRAINT PK_CLASSES_HABILIDADES
            PRIMARY KEY (ClasseId, HabilidadeId),

        CONSTRAINT FK_CLASSES_HABILIDADES_CLASSES
            FOREIGN KEY (ClasseId)
            REFERENCES CLASSES (ClasseId),

        CONSTRAINT FK_CLASSES_HABILIDADES_HABILIDADES
            FOREIGN KEY (HabilidadeId)
            REFERENCES HABILIDADES (HabilidadeId)
    );
END;
GO
