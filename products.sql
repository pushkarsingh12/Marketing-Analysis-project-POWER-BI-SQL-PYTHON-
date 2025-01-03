USE [PortfolioProject_MarketingAnalytics]
GO

/****** Object:  Table [dbo].[products]    Script Date: 27-12-2024 00:06:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO 

CREATE TABLE [dbo].[products](
	[ProductID] [tinyint] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Price] [float] NULL
) ON [PRIMARY]
GO


select 
    ProductID,
	ProductName,
	Price,
	Category,
	 
CASE
  when
   Price < 50 then 'Low'
   when
   Price between 50 and 200 then 'Medium'
   else 'High'
    end as PriceCategory
	from
	dbo.products;
