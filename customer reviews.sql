USE [PortfolioProject_MarketingAnalytics]
GO

/****** Object:  Table [dbo].[customer_reviews]    Script Date: 26-12-2024 15:55:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customer_reviews](
	[ReviewID] [smallint] NOT NULL,
	[CustomerID] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[ReviewDate] [date] NOT NULL,
	[Rating] [tinyint] NOT NULL,
	[ReviewText] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO

select
  ReviewID,
  CustomerID,
  ProductID,
  ReviewDate,
  Rating,

  Replace (ReviewText,'  ',' ') as ReviewText  

  from
     dbo.customer_reviews
