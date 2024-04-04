USE [PS_UserData]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginSuccessCheck]    Script Date: 4/4/2024 2:21:36 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.sp_OmgLoginSuccessCheck    Script Date: 2008-6-7 18:29:10 ******/



-- =============================
-- @Rtn_Success : 1-Success , 0-Fail
-- =============================

ALTER   PROCEDURE [dbo].[sp_LoginSuccessCheck] 
	@userid varchar(18),
	@checkPassword varchar(32),
	@Rtn_Success int OUTPUT
AS

BEGIN

	SET NOCOUNT ON;

	DECLARE @salt varchar(12)
	DECLARE @hashedPassword varchar(150)

	IF EXISTS(Select * From users_master with (nolock) Where userid=@userid)
		BEGIN 
			SET @salt = (Select Salt From users_master with (nolock) Where userid=@userid)
			SET @hashedPassword = SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('SHA2_512',CONCAT(@salt, @checkPassword))),3,150)
			IF @hashedPassword = (Select Pw From users_master with (nolock) Where userid=@userid)
				BEGIN
				--Login Success
				SET @Rtn_Success = 1
				END
			ELSE
				BEGIN
					--Login Fail
					SET @Rtn_Success =- 1
				END
			RETURN @Rtn_Success
		END
	ELSE
		BEGIN
			--Login Fail
			SET @Rtn_Success =- 1
		END
	RETURN @Rtn_Success


END