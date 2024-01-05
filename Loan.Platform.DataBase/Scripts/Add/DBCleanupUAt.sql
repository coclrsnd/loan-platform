ALTER TABLE [dbo].[User] SET ( SYSTEM_VERSIONING = OFF)
ALTER TABLE [dbo].[UserRoleMapping] SET ( SYSTEM_VERSIONING = OFF)

ALTER TABLE [UserRoleMapping]
DROP CONSTRAINT FK_UserRoleMapping_User_UserId1
GO
DROP INDEX [UserRoleMapping].IX_UserRoleMapping_UserId1;
GO
ALTER TABLE [UserRoleMapping]
DROP Column UserId1
GO
ALTER TABLE [user]
DROP CONSTRAINT PK_User;
GO
alter table [user]
alter column id bigint
GO
ALTER TABLE [user]
ADD CONSTRAINT PK_User PRIMARY KEY (Id);
GO
ALTER TABLE [dbo].[UserRoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_UserRoleMapping_User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[UserRoleMapping] CHECK CONSTRAINT [FK_UserRoleMapping_User_UserId]
GO

ALTER TABLE [dbo].[UserRoleMapping] SET ( SYSTEM_VERSIONING = ON)
ALTER TABLE [dbo].[User] SET ( SYSTEM_VERSIONING = ON)

