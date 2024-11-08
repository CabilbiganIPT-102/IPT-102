﻿/*
Deployment script for CabilbiganCompany

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "CabilbiganCompany"
:setvar DefaultFilePrefix "CabilbiganCompany"
:setvar DefaultDataPath "C:\Users\Administrator\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Administrator\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating database $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating Table [dbo].[DEPARTMENT]...';


GO
CREATE TABLE [dbo].[DEPARTMENT] (
    [Dname]          VARCHAR (15) NOT NULL,
    [Dnumber]        INT          NOT NULL,
    [Mgr_ssn]        CHAR (9)     NOT NULL,
    [Mgr_start_date] DATE         NULL,
    CONSTRAINT [PK_Department_Number] PRIMARY KEY CLUSTERED ([Dnumber] ASC),
    CONSTRAINT [UX_Department_Name] UNIQUE NONCLUSTERED ([Dname] ASC)
);


GO
PRINT N'Creating Index [dbo].[DEPARTMENT].[IX_Department_Name]...';


GO
CREATE NONCLUSTERED INDEX [IX_Department_Name]
    ON [dbo].[DEPARTMENT]([Dname] ASC);


GO
PRINT N'Creating Table [dbo].[DEPENDENT]...';


GO
CREATE TABLE [dbo].[DEPENDENT] (
    [Essn]           CHAR (9)     NOT NULL,
    [Dependent_name] VARCHAR (15) NOT NULL,
    [Sex]            CHAR (1)     NULL,
    [Bdate]          DATE         NULL,
    [Relationship]   VARCHAR (8)  NULL,
    CONSTRAINT [PK_DEPENDENT_Essn, PK_DEPENDENT_name] PRIMARY KEY CLUSTERED ([Essn] ASC, [Dependent_name] ASC)
);


GO
PRINT N'Creating Index [dbo].[DEPENDENT].[IX_DEPENDENT_Sex]...';


GO
CREATE NONCLUSTERED INDEX [IX_DEPENDENT_Sex]
    ON [dbo].[DEPENDENT]([Sex] ASC);


GO
PRINT N'Creating Table [dbo].[DEPT_LOCATIONS]...';


GO
CREATE TABLE [dbo].[DEPT_LOCATIONS] (
    [Dnumber]   INT          NOT NULL,
    [Dlocation] VARCHAR (15) NOT NULL,
    CONSTRAINT [PK_Dlocation] PRIMARY KEY CLUSTERED ([Dnumber] ASC, [Dlocation] ASC)
);


GO
PRINT N'Creating Index [dbo].[DEPT_LOCATIONS].[IX_DEPT.LOCATION_LOCATION]...';


GO
CREATE NONCLUSTERED INDEX [IX_DEPT.LOCATION_LOCATION]
    ON [dbo].[DEPT_LOCATIONS]([Dlocation] ASC);


GO
PRINT N'Creating Table [dbo].[EMPLOYEE]...';


GO
CREATE TABLE [dbo].[EMPLOYEE] (
    [Fname]     VARCHAR (15)    NOT NULL,
    [Minit]     CHAR (10)       NULL,
    [Lname]     VARCHAR (15)    NOT NULL,
    [Ssn]       CHAR (9)        NOT NULL,
    [Bdate]     DATE            NULL,
    [Address]   VARCHAR (30)    NULL,
    [Sex]       CHAR (10)       NULL,
    [Salary]    DECIMAL (10, 2) NULL,
    [Super_ssn] CHAR (9)        NULL,
    [Dno]       INT             NOT NULL,
    CONSTRAINT [PK_EMPLOYEE_Ssn] PRIMARY KEY CLUSTERED ([Ssn] ASC)
);


GO
PRINT N'Creating Index [dbo].[EMPLOYEE].[IX,Employee_Name]...';


GO
CREATE NONCLUSTERED INDEX [IX,Employee_Name]
    ON [dbo].[EMPLOYEE]([Lname] ASC);


GO
PRINT N'Creating Table [dbo].[PROJECT]...';


GO
CREATE TABLE [dbo].[PROJECT] (
    [Pname]     VARCHAR (15) NOT NULL,
    [Pnumber]   INT          NOT NULL,
    [PLocation] VARCHAR (15) NULL,
    [Dnum]      INT          NOT NULL,
    CONSTRAINT [PK_PROJECT_Pnumber] PRIMARY KEY CLUSTERED ([Pnumber] ASC)
);


GO
PRINT N'Creating Index [dbo].[PROJECT].[IX_PROJECT_Location]...';


GO
CREATE NONCLUSTERED INDEX [IX_PROJECT_Location]
    ON [dbo].[PROJECT]([PLocation] ASC);


GO
PRINT N'Creating Table [dbo].[WORKS_ON]...';


GO
CREATE TABLE [dbo].[WORKS_ON] (
    [Essn]  CHAR (9)       NOT NULL,
    [Pno]   INT            NOT NULL,
    [Hours] DECIMAL (3, 1) NOT NULL,
    CONSTRAINT [PK_WORKS_ON_Essn, PK_Pno] PRIMARY KEY CLUSTERED ([Essn] ASC, [Pno] ASC)
);


GO
PRINT N'Creating Index [dbo].[WORKS_ON].[IX_WORKS_ON_Hours]...';


GO
CREATE NONCLUSTERED INDEX [IX_WORKS_ON_Hours]
    ON [dbo].[WORKS_ON]([Hours] ASC);


GO
PRINT N'Creating Foreign Key [dbo].[FX_Deparment_ssn]...';


GO
ALTER TABLE [dbo].[DEPARTMENT]
    ADD CONSTRAINT [FX_Deparment_ssn] FOREIGN KEY ([Mgr_ssn]) REFERENCES [dbo].[EMPLOYEE] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_DEPENDENT_Ssn]...';


GO
ALTER TABLE [dbo].[DEPENDENT]
    ADD CONSTRAINT [FK_DEPENDENT_Ssn] FOREIGN KEY ([Essn]) REFERENCES [dbo].[EMPLOYEE] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FX_Dnumber]...';


GO
ALTER TABLE [dbo].[DEPT_LOCATIONS]
    ADD CONSTRAINT [FX_Dnumber] FOREIGN KEY ([Dnumber]) REFERENCES [dbo].[DEPARTMENT] ([Dnumber]);


GO
PRINT N'Creating Foreign Key [dbo].[FX_WORKS_Ssn]...';


GO
ALTER TABLE [dbo].[WORKS_ON]
    ADD CONSTRAINT [FX_WORKS_Ssn] FOREIGN KEY ([Essn]) REFERENCES [dbo].[EMPLOYEE] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FX_WORKS_Pnumber]...';


GO
ALTER TABLE [dbo].[WORKS_ON]
    ADD CONSTRAINT [FX_WORKS_Pnumber] FOREIGN KEY ([Pno]) REFERENCES [dbo].[PROJECT] ([Pnumber]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9691d4ee-5523-4ba0-a897-9dcbb213b9ca')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9691d4ee-5523-4ba0-a897-9dcbb213b9ca')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '67464b89-cdfe-4929-9f5f-6eda564e7fb5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('67464b89-cdfe-4929-9f5f-6eda564e7fb5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5917f766-1ed6-48fb-a246-f614abb852c5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5917f766-1ed6-48fb-a246-f614abb852c5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '641c8027-455a-4b86-bff1-3331e08b43fb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('641c8027-455a-4b86-bff1-3331e08b43fb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ac7ed61d-a22c-4a19-88f0-630eef41c060')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ac7ed61d-a22c-4a19-88f0-630eef41c060')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4530ae80-e612-427c-80b6-64ed29557d1c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4530ae80-e612-427c-80b6-64ed29557d1c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'aa99923f-d7b5-4cad-adff-fa82b2cb15b1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('aa99923f-d7b5-4cad-adff-fa82b2cb15b1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2aeec20b-0074-4ad8-9814-7b0a93097882')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2aeec20b-0074-4ad8-9814-7b0a93097882')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b033c8c0-463e-4af3-8111-5ccb83549476')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b033c8c0-463e-4af3-8111-5ccb83549476')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '834bfa34-9834-4403-9be2-f807ba1362a7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('834bfa34-9834-4403-9be2-f807ba1362a7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '10590f9d-879f-418c-9b25-c52f906281c8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('10590f9d-879f-418c-9b25-c52f906281c8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a8116ca4-795c-4fe8-a7ed-dc3a12819e5c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a8116ca4-795c-4fe8-a7ed-dc3a12819e5c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ea03c7f8-f86c-4b96-acde-4f760cf7fb5f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ea03c7f8-f86c-4b96-acde-4f760cf7fb5f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '82199045-29fa-42ba-9a8c-0f8936585eea')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('82199045-29fa-42ba-9a8c-0f8936585eea')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '712de043-41dd-4c19-b03e-93b7df7619bd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('712de043-41dd-4c19-b03e-93b7df7619bd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '05663e8a-318d-4d6f-aec5-742a88b21d71')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('05663e8a-318d-4d6f-aec5-742a88b21d71')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2ea00b72-8bcb-4bc5-ac62-4fc72bd46fa9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2ea00b72-8bcb-4bc5-ac62-4fc72bd46fa9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f4f06a86-5fa2-4c72-b16e-850d1520a142')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f4f06a86-5fa2-4c72-b16e-850d1520a142')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '7bb6e442-6b50-4d95-ab15-48474b1b47fb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('7bb6e442-6b50-4d95-ab15-48474b1b47fb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'aca00bc9-7835-4357-b65c-e1217a485a16')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('aca00bc9-7835-4357-b65c-e1217a485a16')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8d31c2c4-c902-49a4-aafa-37e482693996')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8d31c2c4-c902-49a4-aafa-37e482693996')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '775caba3-d183-4923-be84-8c2143cf41c5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('775caba3-d183-4923-be84-8c2143cf41c5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6cf46751-ce88-49eb-9fa6-52a8b946b077')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6cf46751-ce88-49eb-9fa6-52a8b946b077')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
