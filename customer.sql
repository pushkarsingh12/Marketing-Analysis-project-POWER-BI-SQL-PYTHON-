USE [PortfolioProject_MarketingAnalytics]
GO

/****** Object:  Table [dbo].[customers]    Script Date: 26-12-2024 15:23:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customers](
	[CustomerID] [tinyint] NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[Age] [tinyint] NOT NULL,
	[GeographyID] [tinyint] NOT NULL
) ON [PRIMARY]
GO

select
  c.CustomerID,
  c.CustomerName,
  c.Email,
  c.Gender,
  c.Age,
  g.Country,
  g.City
from
   dbo.customers as c 
   ---left join 
   right join
   ---inner join
   ---full outer join

   dbo.geography  g
on
 c.GeographyID = g.GeographyID
