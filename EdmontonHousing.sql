--Renamed table name to "EdmontonHousingData"

--To check the status of the table EdmontonHousingData
SELECT *
FROM EdmontonHousingData

--Deleting unnecessary columns
ALTER TABLE EdmontonHousingData
DROP COLUMN [House Description], [Full Baths], Condo, County, Features, Parking, [Is Waterfront], [Has Pool], Interior, [Interior Features], Heating, Fireplace, [# of Stories], [Has Basement], Basement, [Separate Entrance], Exterior, [Exterior Features], Construction, Foundation, Elementary, Middle, High, Foreclosure, [RE / Bank Owned], Office, [Bedrooms Above Grade], [# of Garages], Garages, [Half Baths], Fireplaces, Zoning, [Lot Description], [HOA Fees], [HOA Fees Freq#], [Condo Fee]

--Checking if record exists where Area != City
SELECT *
FROM EdmontonHousingData
WHERE Area <> City

--Deleting Area column as it is unnecessary
ALTER TABLE EdmontonHousingData
DROP COLUMN Area

--Replacing NULL with 0s
UPDATE EdmontonHousingData
SET [Parking Spaces] = ISNULL([Parking Spaces], 0)
WHERE [Parking Spaces] IS NULL

--Replacing AB with Alberta
UPDATE EdmontonHousingData
SET Province = REPLACE(Province,'AB','Alberta')

--Remove $ and , from the Price, Square Footage column
UPDATE EdmontonHousingData
SET Price = REPLACE(REPLACE(Price, '$', ''), ',', ''),
    [Square Footage] = REPLACE([Square Footage], ',', '')

-- Alter the data type of Price, Square Footage, Acres, Bedrooms, Bathrooms, Year Built, Parking Spaces column
ALTER TABLE edmontonHousingData
ALTER COLUMN Price FLOAT

ALTER TABLE edmontonHousingData
ALTER COLUMN [Square Footage] FLOAT

ALTER TABLE edmontonHousingData
ALTER COLUMN Acres FLOAT

ALTER TABLE edmontonHousingData
ALTER COLUMN Bedrooms INT

ALTER TABLE edmontonHousingData
ALTER COLUMN Bathrooms FLOAT
ALTER TABLE edmontonHousingData
ALTER COLUMN Bathrooms INT

ALTER TABLE edmontonHousingData
ALTER COLUMN [Year Built] INT

ALTER TABLE edmontonHousingData
ALTER COLUMN [Parking Spaces] INT

-- Add a new column named 'Description' to the table
ALTER TABLE EdmontonHousingData
ADD Description VARCHAR(MAX);

-- Populate the 'Description' column with data from your query
UPDATE EdmontonHousingData
SET Description = CAST(Bedrooms AS VARCHAR) + ' Bedrooms ' + CAST(Bathrooms AS VARCHAR) + ' Bathrooms ' + Style + ' at ' + Community;

--Creating new table to rearrange the columns
CREATE TABLE EdmontonHousing (
	Description NVARCHAR(MAX),
	Price FLOAT,
	Bedrooms INT,
	Bathrooms INT,
	[Parking Spaces] INT,
	[Square Footage] FLOAT,
	Acres FLOAT,
	[Year Built] INT,
	Type NVARCHAR(255),
	[Sub-Type] NVARCHAR(255),
	Style NVARCHAR(255),
	Address NVARCHAR(255),
	Community NVARCHAR(255),
	City NVARCHAR(255),
	Province NVARCHAR(255),
	[Postal Code] NVARCHAR(255)
)

--Inserting the columns in the updated order in the new table
INSERT INTO EdmontonHousing(Description, Price, Bedrooms, Bathrooms, [Parking Spaces], [Square Footage], Acres, [Year Built], Type, [Sub-Type], Style, Address, Community, City, Province, [Postal Code])
SELECT EdmontonHousingData.Description, EdmontonHousingData.Price, EdmontonHousingData.Bedrooms, EdmontonHousingData.Bathrooms, EdmontonHousingData.[Parking Spaces], EdmontonHousingData.[Square Footage], EdmontonHousingData.Acres, EdmontonHousingData.[Year Built], EdmontonHousingData.Type, EdmontonHousingData.[Sub-Type], EdmontonHousingData.Style, EdmontonHousingData.Address, EdmontonHousingData.Community, EdmontonHousingData.City, EdmontonHousingData.Province, EdmontonHousingData.[Postal Code]
FROM EdmontonHousingData

--To check the status of the table EdmontonHousing
SELECT *
FROM EdmontonHousing

--Dropping the old table
DROP TABLE EdmontonHousingData