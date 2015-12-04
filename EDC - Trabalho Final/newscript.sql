USE [master]
GO
/****** Object:  Database [EDCFootball]    Script Date: 04/12/15 14:03:09 ******/
CREATE DATABASE [EDCFootball]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EDCFootball', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EDCFootball.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EDCFootball_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EDCFootball_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EDCFootball] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EDCFootball].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EDCFootball] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EDCFootball] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EDCFootball] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EDCFootball] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EDCFootball] SET ARITHABORT OFF 
GO
ALTER DATABASE [EDCFootball] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EDCFootball] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EDCFootball] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EDCFootball] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EDCFootball] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EDCFootball] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EDCFootball] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EDCFootball] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EDCFootball] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EDCFootball] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EDCFootball] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EDCFootball] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EDCFootball] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EDCFootball] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EDCFootball] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EDCFootball] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EDCFootball] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EDCFootball] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EDCFootball] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EDCFootball] SET  MULTI_USER 
GO
ALTER DATABASE [EDCFootball] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EDCFootball] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EDCFootball] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EDCFootball] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EDCFootball]
GO
/****** Object:  Schema [football]    Script Date: 04/12/15 14:03:09 ******/
CREATE SCHEMA [football]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [football].[player]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [football].[player](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [text] NULL,
	[dateOfBirth] [text] NULL,
	[nationality] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [football].[season]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [football].[season](
	[id] [int] NOT NULL,
	[link_fixtures_href] [text] NULL,
	[link_leagueTable_href] [text] NULL,
	[link_self_href] [text] NULL,
	[link_teams_href] [text] NULL,
	[caption] [text] NULL,
	[last_updated] [text] NULL,
	[league] [text] NULL,
	[numberOfGames] [int] NULL,
	[numberOfTeams] [int] NULL,
	[seasonYear] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [football].[team]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [football].[team](
	[id] [int] NOT NULL,
	[link_fixtures_href] [text] NULL,
	[link_players_href] [text] NULL,
	[link_self_href] [text] NULL,
	[name] [text] NULL,
	[namePT] [text] NULL,
	[nameEN] [text] NULL,
	[code] [text] NULL,
	[shortName] [text] NULL,
	[squadMarketValue] [text] NULL,
	[crestURL] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [football].[teamNew]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [football].[teamNew](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [text] NULL,
	[link] [varchar](350) NOT NULL,
	[description] [text] NULL,
	[language] [varchar](2) NOT NULL,
	[team_id] [int] NOT NULL,
	[pubDate] [datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[link] ASC,
	[team_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [football].[teamplayer]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [football].[teamplayer](
	[playerID] [int] NULL,
	[teamID] [int] NULL,
	[position] [text] NULL,
	[jerseyNumber] [int] NULL,
	[contractUntil] [text] NULL,
	[marketValue] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [football].[teamRelatedNew]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [football].[teamRelatedNew](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [text] NULL,
	[link] [varchar](350) NOT NULL,
	[related_id] [int] NULL,
	[team_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[link] ASC,
	[team_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [football].[teamSeason]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [football].[teamSeason](
	[seasonID] [int] NULL,
	[teamID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [football].[teamSubscription]    Script Date: 04/12/15 14:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [football].[teamSubscription](
	[userID] [nvarchar](128) NULL,
	[teamID] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 04/12/15 14:03:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 04/12/15 14:03:09 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 04/12/15 14:03:09 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 04/12/15 14:03:09 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 04/12/15 14:03:09 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 04/12/15 14:03:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [football].[teamNew]  WITH CHECK ADD FOREIGN KEY([team_id])
REFERENCES [football].[team] ([id])
GO
ALTER TABLE [football].[teamplayer]  WITH CHECK ADD FOREIGN KEY([playerID])
REFERENCES [football].[player] ([id])
GO
ALTER TABLE [football].[teamplayer]  WITH CHECK ADD FOREIGN KEY([teamID])
REFERENCES [football].[team] ([id])
GO
ALTER TABLE [football].[teamRelatedNew]  WITH CHECK ADD FOREIGN KEY([related_id])
REFERENCES [football].[teamNew] ([id])
GO
ALTER TABLE [football].[teamRelatedNew]  WITH CHECK ADD FOREIGN KEY([team_id])
REFERENCES [football].[team] ([id])
GO
ALTER TABLE [football].[teamSeason]  WITH CHECK ADD FOREIGN KEY([seasonID])
REFERENCES [football].[season] ([id])
GO
ALTER TABLE [football].[teamSeason]  WITH CHECK ADD FOREIGN KEY([teamID])
REFERENCES [football].[team] ([id])
GO
ALTER TABLE [football].[teamSubscription]  WITH CHECK ADD FOREIGN KEY([teamID])
REFERENCES [football].[team] ([id])
GO
ALTER TABLE [football].[teamSubscription]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
USE [master]
GO
ALTER DATABASE [EDCFootball] SET  READ_WRITE 
GO
