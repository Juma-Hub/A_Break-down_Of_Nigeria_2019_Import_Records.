--Data source (Godwin abah; kaggle.com/dataset/godwinabah/2019-nigerian-import-data)

--Applicants that used Letter of Credit to purchase/import their items.

select BNK_NAM, APPLICANT_NAME, IMPORTER_ADDRESS
from dbo.[Nigeria Import Data]
where PAYMENT_MODE LIKE 'L%'
order by BNK_NAM

--Applicants that used Bill of Collection to purchase/import their items.

select BNK_NAM, APPLICANT_NAME, IMPORTER_ADDRESS
from dbo.[Nigeria Import Data]
where PAYMENT_MODE LIKE '%coll%'
order by BNK_NAM

--Names of applicants that imported via Access Bank Letter of credit.

select APPLICANT_NAME, ITEM, BNK_NAM
from dbo.[Nigeria Import Data]
where PAYMENT_MODE LIKE 'L%' 
	and BNK_NAM LIKE 'Acc%'
order by APPLICANT_NAME

select *
from dbo.[Nigeria Import Data]

--Total import value in USD
--At this point, I had to go back to Power Query to manipulate data because, the existing data type(varchar) didn't permit aggregation. That explains the change in table name, as both tables are in the database.
--The total import value in USD for 2019 was $365,990,321

Select sum(USD_EQUIVALENT) as Total_Import_Value_in_USD
from dbo.[EDITED IMPORT DATA]

--Total import value in Naira (#109,154,230,004)

select sum(FOB_Value_Naira ) as Total_Import_Value_in_Naira
from dbo.[EDITED IMPORT DATA]

--Average Import Value in Naira and USD respectively

select avg(FOB_Value_Naira) as Avg_Import_Value_in_Naira
from dbo.[EDITED IMPORT DATA]

select avg(USD_EQUIVALENT) as Avg_Import_Value_in_USD
from dbo.[EDITED IMPORT DATA]

--Top 5 Importers, their import rate and Bank names.

select TOP (5) max(FOB_Value_Naira)AS Highest_Importers, USD_EQUIVALENT, APPLICANT_NAME, BANK_NAME
from dbo.[EDITED IMPORT DATA]
GROUP BY APPLICANT_NAME, USD_EQUIVALENT, BANK_NAME
ORDER BY 1 DESC

--Import details of the highest Importer. Records show that BESTAF TRADING COMPANY LTD imported only Laminating Flooring Machine, at #19,935,631,130. Mode of payment: Bills for Collection and currency: EUR.
--Just to satisfy my curiosity, I ran a google check on Laminating Flooring machines. They're quite expensive.

select *
from dbo.[Nigeria Import Data]
where APPLICANT_NAME like 'BESTAF TRADING%'
