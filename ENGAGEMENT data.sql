USE [PortfolioProject_MarketingAnalytics]
GO

/****** Object:  Table [dbo].[engagement_data]    Script Date: 27-12-2024 00:15:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[engagement_data](
	[EngagementID] [smallint] NOT NULL,
	[ContentID] [tinyint] NOT NULL,
	[ContentType] [nvarchar](50) NOT NULL,
	[Likes] [smallint] NOT NULL,
	[EngagementDate] [date] NOT NULL,
	[CampaignID] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[ViewsClicksCombined] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO


-- Query to clean and normalize the engagement_data table

SELECT 
    EngagementID,  -- Selects the unique identifier for each engagement record
    ContentID,  -- Selects the unique identifier for each piece of content
	CampaignID,  -- Selects the unique identifier for each marketing campaign
    ProductID,  -- Selects the unique identifier for each product
    UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,  -- Replaces "Socialmedia" with "Social Media" and then converts all ContentType values to uppercase
    LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views,  -- Extracts the Views part from the ViewsClicksCombined column by taking the substring before the '-' character
    RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,  -- Extracts the Clicks part from the ViewsClicksCombined column by taking the substring after the '-' character
    Likes,  -- Selects the number of likes the content received
    -- Converts the EngagementDate to the dd.mm.yyyy format
    FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate  -- Converts and formats the date as dd.mm.yyyy
FROM 
    dbo.engagement_data  -- Specifies the source table from which to select the data
WHERE 
    ContentType != 'Newsletter';  -- Filters out rows where ContentType is 'Newsletter' as these are not relevant for our analysis
