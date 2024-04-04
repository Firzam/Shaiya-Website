USE [PS_UserData]
GO

/****** 
Object: Table [dbo].[Users_Master]	Script DAte: 03.04.2023 18:53:00

Description: Refactoring Users_Master table
- Cleaning DB
- Adding Salt column
- Changing Pw type and renaming it to Password
- Reset UserUID increment to 1
******/

DELETE FROM [dbo].[Users_Master];

ALTER TABLE [dbo].[Users_Master]
ADD Salt varchar(12) NOT NULL;

ALTER TABLE [dbo].[Users_Master]
ALTER COLUMN Pw varchar(150) NOT NULL;

DBCC CHECKIDENT ('Users_Master', RESEED, 1);
