USE [PortfolioProject_MarketingAnalytics]
GO

/****** Object:  Table [dbo].[customer_journey]    Script Date: 28-12-2024 16:11:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customer_journey](
	[JourneyID] [smallint] NOT NULL,
	[CustomerID] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[VisitDate] [date] NOT NULL,
	[Stage] [nvarchar](50) NOT NULL,
	[Action] [nvarchar](50) NOT NULL,
	[Duration] [float] NULL
) ON [PRIMARY]
GO


WITH DuplicateRecords AS (
SELECT
 JourneyID, ---Select the unique identifier for each journey (and any other columns you want to include in the final resu
 CustomerID,---Select the unique identifier for each customer
 ProductID,---Select the unique identifier for each product
 VisitDate,---Select the date of the visit, which helps in determining the timeline of customer interactions
 Stage,---Select the stage of the customer journey (e.g., Awareness, Consideration, etc.)
 Action, ---Select the action taken by the customer (e.g., View, Click, Purchase)
 Duration,---Select the duration of the action or interaction

 ---Use ROW NUMBER() to assign a unique row number to each record within the partition defined below
 ROW_NUMBER() OVER (
---PARTITION BY groups the rows based on the specified columns that should be unique
PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
---ORDER BY defines how to order the rows within each partition (usually by a unique identifier like Journey ID)
ORDER BY JourneyID
) AS row_num ---This creates a new column 'row num that numbers each row within its partition
  from
       dbo.customer_journey ---Specifies the source table from which to select the data
 )
---Select all records from the CTE where row num > 1, which indicates duplicate entries
SELECT *
FROM DuplicateRecords
---WHERE row_num >1 ---Filters out the first occurrence (row num 1) and only shows the duplicates (row_num > 1)
ORDER BY JourneyID

---Outer query selects the final cleaned and standardized data
 
 select
 JourneyID,
 CustomerID,
 ProductID,
 VisitDate,
 Stage,
 Action,
 coalesce(Duration, avg_duration ) as Duration
 FROM 
   (
select
 JourneyID,
 CustomerID,
 ProductID,
 VisitDate,
 Stage,
 Action,
 Duration,
 AVG(Duration) Over ( partition by VisitDate) as avg_Duration,
 ROW_NUMBER() OVER (
 partition by CustomerId,ProductID,VisitDate, Upper(stage), Action
 order by JourneyID) as row_num from dbo.customer_journey) as subquery where 
 row_num = 1;
