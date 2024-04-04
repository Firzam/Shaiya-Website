USE [PS_GameData]
GO

/****** 
Object: Database [PS_GameData]	Script DAte: 03.04.2023 18:53:00

Description: Cleaning Table
******/

DELETE FROM [dbo].[_CreatedChars];
DBCC CHECKIDENT ('_CreatedChars', RESEED, 0);

DELETE FROM [dbo].[_DeletedChars];
DBCC CHECKIDENT ('_DeletedChars', RESEED, 0);

DELETE FROM [dbo].[CharApplySkills];
DBCC CHECKIDENT ('CharApplySkills', RESEED, 0);

DELETE FROM [dbo].[CharItems];
DBCC CHECKIDENT ('CharItems', RESEED, 0);

DELETE FROM [dbo].[CharQuests];
DBCC CHECKIDENT ('CharQuests', RESEED, 0);

DELETE FROM [dbo].[CharQuickSlots];
DBCC CHECKIDENT ('CharQuickSlots', RESEED, 0);

DELETE FROM [dbo].[Chars];
DBCC CHECKIDENT ('Chars', RESEED, 0);

DELETE FROM [dbo].[CharSkills];
DBCC CHECKIDENT ('CharSkills', RESEED, 0);

DELETE FROM [dbo].[GuildChars];
DBCC CHECKIDENT ('GuildChars', RESEED, 0);

DELETE FROM [dbo].[Guilds];
DBCC CHECKIDENT ('Guilds', RESEED, 0);

DELETE FROM [dbo].[Keeps];
DBCC CHECKIDENT ('Keeps', RESEED, 0);

DELETE FROM [dbo].[UserMaxGrow];
DBCC CHECKIDENT ('UserMaxGrow', RESEED, 0);

DELETE FROM [dbo].[UserStoredItems];
DBCC CHECKIDENT ('UserStoredItems', RESEED, 0);

DELETE FROM [dbo].[UserStoredMoney];
DBCC CHECKIDENT ('UserStoredMoney', RESEED, 0);
