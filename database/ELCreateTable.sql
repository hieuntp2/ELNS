USE [ELearningNotificationService]
GO
/****** Object:  Table [dbo].[SystemLog]    Script Date: 12/03/2014 14:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateCreate] [datetime] NULL,
	[Message] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FBUser]    Script Date: 12/03/2014 14:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FBUser](
	[FBID] [nvarchar](255) NOT NULL,
	[ELUsername] [nvarchar](255) NULL,
	[ULPassword] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[FBID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LinkPost]    Script Date: 12/03/2014 14:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LinkPost](
	[HrefTrack] [nvarchar](255) NOT NULL,
	[Tittle] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[HrefTrack] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FBUserLinkPost]    Script Date: 12/03/2014 14:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FBUserLinkPost](
	[FBID] [nvarchar](255) NOT NULL,
	[HrefTrack] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 12/03/2014 14:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[IDPost] [nvarchar](255) NOT NULL,
	[Title] [ntext] NULL,
	[HrefTrack] [nvarchar](255) NULL,
	[PostLink] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPost] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_FBUserLinkPost_FBUser]    Script Date: 12/03/2014 14:28:32 ******/
ALTER TABLE [dbo].[FBUserLinkPost]  WITH CHECK ADD  CONSTRAINT [FK_FBUserLinkPost_FBUser] FOREIGN KEY([FBID])
REFERENCES [dbo].[FBUser] ([FBID])
GO
ALTER TABLE [dbo].[FBUserLinkPost] CHECK CONSTRAINT [FK_FBUserLinkPost_FBUser]
GO
/****** Object:  ForeignKey [FK_FBUserLinkPost_LinkPost]    Script Date: 12/03/2014 14:28:32 ******/
ALTER TABLE [dbo].[FBUserLinkPost]  WITH CHECK ADD  CONSTRAINT [FK_FBUserLinkPost_LinkPost] FOREIGN KEY([HrefTrack])
REFERENCES [dbo].[LinkPost] ([HrefTrack])
GO
ALTER TABLE [dbo].[FBUserLinkPost] CHECK CONSTRAINT [FK_FBUserLinkPost_LinkPost]
GO
/****** Object:  ForeignKey [FK_Post_LinkPost]    Script Date: 12/03/2014 14:28:33 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_LinkPost] FOREIGN KEY([HrefTrack])
REFERENCES [dbo].[LinkPost] ([HrefTrack])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_LinkPost]
GO
