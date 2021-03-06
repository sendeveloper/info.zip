USE [z2t_Zip4]
GO
/****** Object:  StoredProcedure [dbo].[z2t_Basic_Lookup]    Script Date: 10/21/2016 20:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                                      
--  =============================================                                      
-- Created: <2012-09-06 Thu nathan>                                      
-- Description: Do basic 5-digit ZIP code lookups                                      
--                                      
-- Modified: <2012-12-05 Wed nathan>                                      
-- Description: Admins get sales tax for free. (The backoffice menu has no way to add add-ons to admin subscriptions.)                                      
--                                       
-- Modified: <2013-09-04 Wed nathan>                                      
-- Description: Return the soure of the data in the resultsets.                
              
-- Modified: <2014-12-06 Wed Swat>      
-- Description: Changes to incorporate use tax for sample userid       
      
-- Modified: <2014-13-06 Wed kanchan>                                      
-- Description: Get rates from legacy              
      
-- Modified: <2014-19-06 Wed Swat>                                    
-- Description: Using new SP to retrieve errorcode and message value                           

 -- Modified <9-9-2014> Kanchan      
-- Used z2t_zipcodes instead of z2t_ZipStandard 

-- Modified: <2015-10-12 Thu Swati>                                    
-- Description: Fixed for printing of Use tax only when subscribed                                                                          
--  =============================================                                         
                                      
ALTER procedure [dbo].[z2t_Basic_Lookup]                                      
 @zip nvarchar(max),                                       
 @userName nvarchar(max),                                      
 @errorCode int OUTPUT,                                      
 @severity int OUTPUT,                                      
 @errorMessage nvarchar(max) OUTPUT                                      
AS                                      
 set nocount on;                                      
                                      
BEGIN                                      
                                       
                                       
 SET @errorCode = 0;                                      
 SET @severity = 0;                                      
 SET @errorMessage = '';                                      
                                       
 DECLARE @tsqlResult  int;    SET @tsqlResult = 0;                                      
 DECLARE @zipCode  nvarchar(5);  SET @zipCode = '';                                       
 DECLARE @accountType nvarchar(12);  SET @accountType = '';                                      
 DECLARE @countyFIPS  nvarchar(3);  SET @countyFIPS = '';                                      
 DECLARE @countyName  nvarchar(45);  SET @countyFIPS = '';                                      
 DECLARE @state   nvarchar(2);  SET @state = '';                                      
 DECLARE @cityName  nvarchar(45);  SET @cityName = '';                                  
                                       
 DECLARE @useTaxFlag   bit    SET @useTaxFlag = 0;                                      
 DECLARE @hasCountySpecial bit;   SET @hasCountySpecial = 0;                                      
 DECLARE @hasCitySpecial  bit;   SET @hasCitySpecial = 0;                                      
 DECLARE @specialTaxTotal smallmoney;  SET @specialTaxTotal = 0;                          
                                       
 --##Cursor for ZipCode data                                      
 DECLARE @zipCodeDataCur  cursor;                                 
 DECLARE @IDCur    int;             
 SET @IDCur = 0;                                      
 DECLARE @cityCur   nvarchar(45); SET @cityCur = '';                                      
 DECLARE @stateCur   nvarchar(2); SET @stateCur = '';                                      
 DECLARE @cityAliasNameCur nvarchar(45); SET @cityAliasNameCur = '';                                      
DECLARE @countyNameCur  nvarchar(45); SET @countyNameCur = '';                                      
 --##                                      
                                      
 --##Temporary table to get results from z2t_VerifyAddress procedure                                      
 CREATE TABLE #addressLookup                                      
 (                                  
  ID    int    identity,                                      
  AddressLine1 nvarchar(100),                               
  AddressLine2 nvarchar(50),                                      
  City   nvarchar(45),                                      
  State   nvarchar(2),                                      
  ZipCode   nvarchar(10),                              
  CountyFIPS  nvarchar(3),                                      
  CountyName  nvarchar(45),                                      
 AddressSource nvarchar(max),                                      
  PlaceSource nvarchar(max),                                      
  StateSource nvarchar(max),                                      
  ZipCodeSource nvarchar(max),                                      
  CountySource nvarchar(max),                                      
  LSAD nvarchar(max)                                      
 );                                      
                                      
 CREATE TABLE #salesTaxRateLookup         (                                      
  ID      int default 1,                                      
  SalesTaxRate   smallmoney,                                      
  SalesTaxRateState  smallmoney,                                      
  SalesTaxJurState  nvarchar(50),                                      
  SalesTaxRateCounty  smallmoney,                                      
  HasCountySpecial  bit,                                      
  JurCodeCounty   nvarchar(12),                                      
  SalesTaxJurCounty  nvarchar(50),                                      
  SalesTaxRateCity  smallmoney,                                      
  HasCitySpecial   bit,                                      
  JurCodeCity    nvarchar(12),                                      
  SalesTaxJurCity   nvarchar(50)                                      
 )                                      
                                       
 --CREATE TABLE #specialSalesTaxRatesLookup                                      
 --(                                      
 -- ID      int default 1,                                      
 -- SpecialSalesTaxRate  smallmoney,                                      
 -- SpecialJurCode   nvarchar(12),                                      
 -- SpecialDistrictName  nvarchar(200)                                      
 --)                                      
                                      
 CREATE TABLE #useTaxRateLookup                                      
 (                                      
  ID      int default 1,                                      
  UseTaxRate    smallmoney,                                      
  UseTaxRateState   smallmoney,                                      
  UseTaxJurState   nvarchar(50),                                      
  UseTaxRateCounty  smallmoney,                                      
  HasCountySpecial  bit,                                      
  JurCodeCounty   nvarchar(12),                                      
  UseTaxJurCounty   nvarchar(50),                                      
  UseTaxRateCity   smallmoney,                                      
  HasCitySpecial   bit,                                      
  JurCodeCity    nvarchar(12),                                      
  UseTaxJurCity   nvarchar(50)                                 
 )                                      
                                       
 --CREATE TABLE #specialUseTaxRatesLookup                                      
 --(                                      
 -- ID      int default 1,                                      
 -- SpecialUseTaxRate  smallmoney,                                      
 -- SpecialJurCode   nvarchar(12),                                      
 -- SpecialDistrictName  nvarchar(200)                                      
 --)         
                                       
 CREATE TABLE #specialNotes                                      
 (                                      
  ID      int default 1,                                      
  Jurisdiction   nvarchar(50) NULL,                                  
  Category    nvarchar(50) NULL,                                      
  Note     nvarchar(2000) NULL                                      
 )                                       
                                       
 CREATE TABLE #zipCodeData                                      
 (                                      
  ID      int identity(1,1),                                      
  City     nvarchar(45),                                      
  State    nvarchar(2),                                      
  CityAliasName   nvarchar(45),                                      
  County     nvarchar(45),                                      
  ZipCode nvarchar(5),                                      
  RecordPref    int                                      
 )            
                                      
 IF(LEN(@zip) = 0)                                      
 BEGIN                      
  SET @errorCode = 5;                                      
 END;                                       
 ELSE                                      
 BEGIN                                      
                        
  SET @zipCode = SUBSTRING(@zip,1,5);                                        
                                        
  SELECT @accountType = ZA.Status                                      
  FROM z2t_Accounts_Subscriptions_repl ZA                                      
  LEFT JOIN  z2t_Accounts_Subscriptions_addons_repl LA ON ZA.AccountID = LA.z2t_AccountID                                       
  WHERE ZA.Login = @userName                                      
  AND ZA.Status not in ('initial', 'update')                                      
  AND (LA.TaxType = 2 OR ZA.Status in ('admin'))                                      
  AND LA.DeletedDate IS NULL                                      
                                         
  SET @tsqlResult = @@ROWCOUNT;                                      
                              
  --[SM]Changes to incorporate use tax for sample userid                                
  IF(@tsqlResult != 0 OR @accountType = 'admin' or @userName = 'sample')                                      
  BEGIN                                      
   SET @useTaxFlag = 1;                                      
  END;                                          
  ELSE                                      
  BEGIN                                      
   SET @useTaxFlag = 0;                                      
  END;                                        
 END;                                       
                                       

 --SELECT TOP 1 @cityName = City, @state = State                                                     
 --FROM z2t_ZipStandard                                                                              
 --WHERE ZipCode = @zipCode     
     
  SELECT TOP 1 @cityName = LL_City, @state = State                                                     
 FROM z2t_zipcodes                                                                              
 WHERE Zip_Code = @zipCode   
             
 INSERT INTO #addressLookup(AddressLine1, AddressLine2, City, State, ZipCode, CountyFips, CountyName, AddressSource, PlaceSource, StateSource, CountySource, ZipCodeSource, LSAD)                                      
 --SELECT null, null, dbo.z2t_ConvertTitleCase(CityAliasName) /*@cityName*/, [State] /*@state*/, @zipCode, countyFIPS, dbo.z2t_ConvertTitleCase(county) /*@countyFIPS*/ /*dbo.z2t_GetCountyNameFromFIPS(@state, @countyFIPS)*/                                
   
     
 --  /*City, State, CityAliasName, County, @zipCode, CASE PrimaryRecord WHEN 'P' THEN 1 ELSE 2 END RecordPref*/                
 -- , 'n/a', 'z', 'z', 'z', 'i', 'Place'                                                                              
 --FROM z2t_ZipStandard                                                                               
 --WHERE ZipCode = @zipCode                                                        
 -- AND CityAliasCode != 'A'                                                                              
 --ORDER BY CASE PrimaryRecord WHEN 'P' THEN 1 ELSE 2 END         
     
  SELECT null, null, dbo.z2t_ConvertTitleCase(CITYSTNAME) /*@cityName*/, [State] /*@state*/, @zipCode, countyFIPS, dbo.z2t_ConvertTitleCase(county) /*@countyFIPS*/ /*dbo.z2t_GetCountyNameFromFIPS(@state, @countyFIPS)*/                                     
 
   /*City, State, CityAliasName, County, @zipCode, CASE PrimaryRecord WHEN 'P' THEN 1 ELSE 2 END RecordPref*/                                                                              
  , 'n/a', 'z', 'z', 'z', 'i', 'Place'                                                                              
 FROM z2t_zipcodes                                                                               
 WHERE Zip_Code = @zipCode                                                        
  AND CityAliasCode != 'A'                                                                              
 ORDER BY CASE PrimaryRecord WHEN 'P' THEN 1 ELSE 2 END            
                                                                                             
                                       
 INSERT INTO #zipCodeData                                      
 --SELECT City, State, CityAliasName, County, @zipCode, CASE PrimaryRecord                                                                              
 --          WHEN 'P' THEN 1                                                    
 --          ELSE 2                                                                              
 --         END RecordPref                                                                              
 --FROM z2t_ZipStandard                                                                               
 --WHERE ZipCode = @zipCode                                                                              
 -- AND CityAliasCode != 'A'                                                                              
 --ORDER BY RecordPref                              
                                                                              
             
SELECT LL_City, State, CITYSTNAME, County, @zipCode, CASE PrimaryRecord                                                                              
           WHEN 'P' THEN 1                                                    
           ELSE 2                                                                              
          END RecordPref                                                                              
 FROM z2t_zipcodes                                                                               
 WHERE Zip_Code = @zipCode                                                                              
  AND CityAliasCode != 'A'                                                                              
 ORDER BY RecordPref       
                                                   
                                      
 --select * from #zipCodeData                                 
                                      
 SET @tsqlResult = @@ROWCOUNT;                                      
                                       
 IF(@tsqlResult <= 0)                                      
 BEGIN                                      
  SET @errorCode = 1;                                       
 END;                                      
 ELSE                                      
 IF (@tsqlResult > 1)                                      
 BEGIN                                      
  SET @zipCodeDataCur = CURSOR LOCAL SCROLL FOR                 
   SELECT ID, City, State, CityAliasName, County                                   FROM #zipCodeData;                                      
                                      
  OPEN @zipCodeDataCur;                                      
  FETCH NEXT FROM @zipCodeDataCur INTO @IDCur, @cityCur, @stateCur, @cityAliasNameCur, @countyNameCur;                                      
                                      
  WHILE(@@FETCH_STATUS = 0)                                      
  BEGIN                                      
   CREATE TABLE #tempSalesTaxRateLookup                           
   (                                      
    ID      int default 0,                                      
    SalesTaxRate   smallmoney,                                      
    SalesTaxRateState  smallmoney,                                      
    SalesTaxJurState  nvarchar(50),                                      
    SalesTaxRateCounty  smallmoney,                                      
    HasCountySpecial  bit,                                      
    JurCodeCounty   nvarchar(12),                                      
    SalesTaxJurCounty  nvarchar(50),                                      
    SalesTaxRateCity  smallmoney,                                      
   HasCitySpecial   bit,                                      
    JurCodeCity    nvarchar(12),                                      
    SalesTaxJurCity   nvarchar(50)                                      
   )                                      
                                           
   --CREATE TABLE #tempSpecialSalesTaxRatesLookup                                      
   --(                                        
   -- ID      int default 0,                                      
   -- SpecialSalesTaxRate  smallmoney,                                      
   -- SpecialJurCode   nvarchar(12),                                      
   -- SpecialDistrictName  nvarchar(200)                                      
   --)                                      
                                           
   CREATE TABLE #tempUseTaxRateLookup                                      
   (                                      
    ID      int default 0,                                      
    UseTaxRate    smallmoney,                                      
    UseTaxRateState   smallmoney,                                      
    UseTaxJurState   nvarchar(50),                                      
    UseTaxRateCounty  smallmoney,                                      
    HasCountySpecial  bit,                                      
    JurCodeCounty   nvarchar(12),                        
    UseTaxJurCounty   nvarchar(50),                                      
 UseTaxRateCity   smallmoney,                                      
    HasCitySpecial   bit,                                      
    JurCodeCity    nvarchar(12),                                      
    UseTaxJurCity   nvarchar(50)                                      
   )                                           
                                           
   --CREATE TABLE #tempSpecialUseTaxRatesLookup                                      
   --(                                      
   -- ID      int default 0,                                      
   -- SpecialUseTaxRate  smallmoney,                                      
   -- SpecialJurCode   nvarchar(12),                                      
   -- SpecialDistrictName  nvarchar(200)                                      
   --)                                           
                                           
   CREATE TABLE #tempSpecialNotes       
   (                                      
    ID      int default 0,                                      
    Jurisdiction   nvarchar(50) NULL,                                      
    Category    nvarchar(50) NULL,                                      
    Note     nvarchar(2000) NULL                                      
   )                                          
                                         
   INSERT INTO #tempSalesTaxRateLookup (SalesTaxRate, SalesTaxRateState, SalesTaxJurState,                                      
               SalesTaxRateCounty, HasCountySpecial, JurCodeCounty, SalesTaxJurCounty,                                      
             SalesTaxRateCity, HasCitySpecial, JurCodeCity, SalesTaxJurCity)                                      
   EXEC z2t_Zip4.dbo.z2t_GetSalesTax @stateCur, @countyNameCur, @cityAliasNameCur                                      
                                      
   UPDATE #tempSalesTaxRateLookup SET ID = @IDCur                                      
                                           
   INSERT INTO #salesTaxRateLookup                                      
   SELECT * FROM #tempSalesTaxRateLookup;                                      
                                           
   --SELECT @hasCountySpecial = HasCountySpecial, @hasCitySpecial = HasCitySpecial                                      
   --FROM #salesTaxRateLookup;                                      
                                           
   --IF(@hasCountySpecial = 1)                                      
   --BEGIN                                      
   -- INSERT INTO #tempSpecialSalesTaxRatesLookup(SpecialSalesTaxRate, SpecialJurCode, SpecialDistrictName)                                      
   -- EXEC z2t_GetSpecialDistrictDetails @countyNameCur, '', @state, 1, @zip, 1                         
   -- END;                                      
                                           
   --IF(@hasCitySpecial = 1)                                      
   --BEGIN                                      
   -- INSERT INTO #tempSpecialSalesTaxRatesLookup(SpecialSalesTaxRate, SpecialJurCode, SpecialDistrictName)                                        
   -- EXEC z2t_GetSpecialDistrictDetails @countyNameCur, @cityCur, @state, 2, @zip, 1                                      
   --END;                                        
                                           
   --UPDATE #tempSpecialSalesTaxRatesLookup SET ID = @IDCur;                                      
                                           
   --INSERT INTO #specialSalesTaxRatesLookup                                      
   --SELECT * FROM #tempSpecialSalesTaxRatesLookup;                                                  
                                      
   IF(@useTaxFlag = 1)                                      
   BEGIN                                      
    INSERT INTO #tempUseTaxRateLookup (UseTaxRate, UseTaxRateState, UseTaxJurState,       
               UseTaxRateCounty, HasCountySpecial, JurCodeCounty, UseTaxJurCounty,                                      
               UseTaxRateCity, HasCitySpecial, JurCodeCity, UseTaxJurCity)                                      
    EXEC z2t_Zip4.dbo.z2t_GetUseTax @stateCur, @countyNameCur, @cityAliasNameCur                                      
                                            
    UPDATE #tempUseTaxRateLookup SET ID = @IDCur                                      
                                            
    INSERT INTO #useTaxRateLookup                                      
    SELECT * FROM #tempUseTaxRateLookup;                                      
                                            
    --SELECT @hasCountySpecial = HasCountySpecial, @hasCitySpecial = HasCitySpecial                                      
    --FROM #useTaxRateLookup;                                      
                                            
--    IF(@hasCountySpecial = 1)                                      
--    BEGIN                                      
--    INSERT INTO #tempSpecialUseTaxRatesLookup(SpecialUseTaxRate, SpecialJurCode, SpecialDistrictName)                                      
--     EXEC z2t_GetSpecialDistrictDetails @countyNameCur, '', @state, 1, @zip, 1                                      
--    END;                                      
                                            
--    IF(@hasCitySpecial = 1)                            
--    BEGIN                                      
--     INSERT INTO #tempSpecialUseTaxRatesLookup(SpecialUseTaxRate, SpecialJurCode, SpecialDistrictName)                                        
--     EXEC z2t_GetSpecialDistrictDetails @countyNameCur, @cityCur, @state, 2, @zip, 1                                      
--    END;                                       
                                            
--    UPDATE #tempSpecialUseTaxRatesLookup SET ID = @IDCur;                                      
                                            
--    INSERT INTO #specialUseTaxRatesLookup                                      
--    SELECT * FROM #tempSpecialUseTaxRatesLookup;                                                  
   END                                      
                                      
   -- Update total sales tax rate in temporary #salesTaxRateLookup to include Special District Data                             
   --SELECT @specialTaxTotal = SUM(SpecialSalesTaxRate)                                      
   --FROM #specialSalesTaxRatesLookup                                      
   --WHERE ID = @IDCur;                                      
                                           
   --UPDATE #salesTaxRateLookup                                      
   --SET SalesTaxRate = ISNULL(SalesTaxRateState,0) + ISNULL(SalesTaxRateCounty,0) + ISNULL(SalesTaxRateCity,0) + ISNULL(@specialTaxTotal,0)                              
   --WHERE ID = @IDCur;                                      
                                           
   --SET @specialTaxTotal = 0.0;                                      
   --SELECT @specialTaxTotal = SUM(SpecialUseTaxRate)                                      
   --FROM #specialUseTaxRatesLookup                                      
   --WHERE ID = @IDCur;                                      
                                           
   --UPDATE #useTaxRateLookup                                      
   --SET UseTaxRate = ISNULL(UseTaxRateState,0) + ISNULL(UseTaxRateCounty,0) + ISNULL(UseTaxRateCity,0) + ISNULL(@specialTaxTotal,0)                                      
   --WHERE ID = @IDCur;                                                
                                           
   INSERT INTO #tempSpecialNotes(Jurisdiction, Category, Note)                                      
   EXEC z2t_Zip4.dbo.z2t_GetLookupNotes @state, @cityCur, @countyNameCur;                                       
                                           
   UPDATE #tempSpecialNotes SET ID = @IDCur;                                      
                                           
   INSERT INTO #specialNotes                                      
   SELECT * FROM #tempSpecialNotes;                                           
                                      
   DROP TABLE #tempSalesTaxRateLookup;                                      
   DROP TABLE #tempUseTaxRateLookup;                                      
   --DROP TABLE #tempSpecialSalesTaxRatesLookup;                                      
   --DROP TABLE #tempSpecialUseTaxRatesLookup;                                      
   DROP TABLE #tempSpecialNotes;                                      
                                           
   FETCH NEXT FROM @zipCodeDataCur INTO @IDCur, @cityCur, @stateCur, @cityAliasNameCur, @countyNameCur;                                      
                                             
  END;                                      
 END                                      
 ELSE                                      
 BEGIN                                      
  SELECT @countyName = County, @cityName = City, @state = State                                      
  FROM #zipCodeData                                      
                                         
  INSERT INTO #salesTaxRateLookup(SalesTaxRate, SalesTaxRateState, SalesTaxJurState,                                       
          SalesTaxRateCounty, HasCountySpecial, JurCodeCounty, SalesTaxJurCounty,                                       
          SalesTaxRateCity, HasCitySpecial, JurCodeCity, SalesTaxJurCity)                                      
  EXEC z2t_Zip4.dbo.z2t_GetSalesTax @state, @countyName, @cityName                                      
                                         
  --SELECT @hasCountySpecial = HasCountySpecial, @hasCitySpecial = HasCitySpecial                                      
  --FROM #salesTaxRateLookup;                                      
                                         
  --IF(@hasCountySpecial = 1)                                      
  --BEGIN                                      
  -- INSERT INTO #specialSalesTaxRatesLookup (SpecialSalesTaxRate, SpecialJurCode, SpecialDistrictName)                                      
  -- EXEC z2t_GetSpecialDistrictDetails @countyName, '', @state, 1, @zip, 1                          
  --END;                                      
                                         
  --IF(@hasCitySpecial = 1)                      
  --BEGIN                                      
  -- INSERT INTO #specialSalesTaxRatesLookup (SpecialSalesTaxRate, SpecialJurCode, SpecialDistrictName)                                       
  -- EXEC z2t_GetSpecialDistrictDetails @countyName, @cityName, @state, 2, @zip, 1                                      
  --END;                                       
                                         
  IF(@useTaxFlag = 1)                                      
  BEGIN--##Use Tax                                      
   INSERT INTO #useTaxRateLookup(UseTaxRate, UseTaxRateState, UseTaxJurState,                                      
            UseTaxRateCounty, HasCountySpecial, JurCodeCounty, UseTaxJurCounty,                                       
            UseTaxRateCity, HasCitySpecial, JurCodeCity, UseTaxJurCity)                                       
   EXEC z2t_Zip4.dbo.z2t_GetUseTax @state, @countyName, @cityName                                      
                       SELECT @hasCountySpecial = HasCountySpecial, @hasCitySpecial = HasCitySpecial                                      
   FROM #useTaxRateLookup;                                      
                                          
   --IF(@hasCountySpecial = 1)                                      
   --BEGIN                                      
   -- INSERT INTO #specialUseTaxRatesLookup(SpecialUseTaxRate, SpecialJurCode, SpecialDistrictName)                                      
   -- EXEC z2t_GetSpecialDistrictDetails @countyName, '', @state, 1, @zip, 2                                      
   --END;                                      
                                          
   --IF(@hasCitySpecial = 1)                                      
   --BEGIN                                      
   -- INSERT INTO #specialUseTaxRatesLookup(SpecialUseTaxRate, SpecialJurCode, SpecialDistrictName)                                         
   -- EXEC z2t_GetSpecialDistrictDetails @countyName, @cityName, @state, 2, @zip, 2                                      
   --END;                                       
  END;--##Use Tax                                      
 --#Sales Tax                                      
                                        
  -- Update total sales tax rate in temporary #salesTaxRateLookup to include Special District Data                                    
  --SELECT @specialTaxTotal = SUM(SpecialSalesTaxRate)                                      
  --FROM #specialSalesTaxRatesLookup                                      
                                        
  --UPDATE #salesTaxRateLookup                                      
  --SET SalesTaxRate = ISNULL(SalesTaxRateState,0) + ISNULL(SalesTaxRateCounty,0) + ISNULL(SalesTaxRateCity,0) +                                      
  --     ISNULL(@specialTaxTotal,0);                                      
                                        
  --SET @specialTaxTotal = 0.0;                                      
  --SELECT @specialTaxTotal = SUM(SpecialUseTaxRate)                                      
  --FROM #specialUseTaxRatesLookup                                      
                                        
 --UPDATE #useTaxRateLookup                                      
  --SET UseTaxRate = ISNULL(UseTaxRateState,0) + ISNULL(UseTaxRateCounty,0) + ISNULL(UseTaxRateCity,0) +                                      
  --     ISNULL(@specialTaxTotal,0);                                       
                                      
  INSERT INTO #specialNotes(Jurisdiction, Category, Note)                                      
  EXEC z2t_Zip4.dbo.z2t_GetLookupNotes @state, @cityName, @countyName;                                                
                                        
 END;                                      
                                       
 --SET @errorMessage =                                      
 -- CASE @errorCode                                      
 --  WHEN 0 THEN N'All Correct'                                      
  -- WHEN 1 THEN N'Incorrect Zipcode'                                      
  -- WHEN 5 THEN N'One of the mandatory input is blank'                   
 --  WHEN 9 THEN N'Invalid Zip+4'                                      
 -- END;      
     --[SM] Using new SP to retreive Errorcode from types table.      
 EXEC z2t_Zip4.dbo.z2t_Types_lookup @errorCode, 'ErrorCode', @errorMessage OUTPUT;                                        
                                   
                          -- 1.                             
SELECT #addressLookup.* FROM #addressLookup  inner join dbo.z2t_ZipCodes  -- Changed by Kanchan to  orderby ZipSequence from legacy table                        
  on #addressLookup.ZipCode = dbo.z2t_ZipCodes.zip_code and                           
 #addressLookup.City =  dbo.z2t_ZipCodes.citystname order by dbo.z2t_ZipCodes.ZipSequence;                                     
                
                
-- 2.                                 
 Select ZipSequence as ID,SalesTaxRate,SalesTaxRateState,('State of ' + State) as SalesTaxJurState,SalesTaxRateCounty,NULL as HasCountySpecial,                          
                  NULL as JurCodeCounty,('County of ' + County) as SalesTaxJurCounty,SalesTaxRateCity,NULL as HasCitySpecial,NULL as JurCodeCity,                          
                  ('City of ' + CITYSTNAME) as SalesTaxJurCity                          
                          
                   from  dbo.z2t_ZipCodes where ZipSequence > 0 and Zip_Code = @zip order by  ZipSequence                                    
                                    
                                   
-- commenting below out because in the rate split up county rates are not all same                                                           
-- Update #salesTaxRateLookup       --Changed by Kanchan to get rate from legacy table                                                                   
-- Set SalesTaxRate= (Select SalesTaxRate from dbo.z2t_ZipCodes where Zip_Code = @zip and ZipSequence =1)                                           
                                                                     
                                                
--SELECT  * FROM #salesTaxRateLookup                           
                       
-- 3.                                 
 --SELECT * FROM #specialSalesTaxRatesLookup;            
                   
Select ZipSequence AS ID,SalesTaxRateSpecial AS SpecialSalesTaxRate,'00000' as SpecialJurCode,'Special District' as SpecialDistrictName                   
 from   dbo.z2t_ZipCodes    where    Zip_Code = @zip   and ZipSequence <>0 order by ZipSequence                       
                
-- 4.               
                IF(@useTaxFlag = 1)                                                                          
				BEGIN                
                   Select ZipSequence as ID,UseTaxRate,UseTaxRateState,('State of ' + State) as UseTaxJurState,UseTaxRateCounty,NULL as HasCountySpecial,                          
                  NULL as JurCodeCounty,('County of ' + County) as UseTaxJurCounty,UseTaxRateCity,NULL as HasCitySpecial,NULL as JurCodeCity,                          
                  ('City of ' + CITYSTNAME) as UseTaxJurCity                          
                          
                 from  dbo.z2t_ZipCodes where ZipSequence > 0 and Zip_Code = @zip order by  ZipSequence                           
                END;
                ELSE
					BEGIN                                                   
 -- commenting below out because in the rate split up county rates are not all same                                
					 Update #useTaxRateLookup                                                                        
					 Set UseTaxRate= (Select UseTaxRate from dbo.z2t_ZipCodes where Zip_Code = @zip and  ZipSequence =1)                                                                          
					                                                       
					 SELECT * FROM #useTaxRateLookup; 
				END;                           
                
-- 5.              
 --SELECT  * FROM #specialUseTaxRatesLookup;                              
                       
 Select ZipSequence AS ID,UseTaxRateSpecial AS SpecialUseTaxRate,'00000' as SpecialJurCode,'Special District' as SpecialDistrictName                   
 from   dbo.z2t_ZipCodes    where    Zip_Code = @zip   and ZipSequence <>0 order by ZipSequence                                 
                           
-- 6.                         
 SELECT * FROM #specialNotes;                                 
                                       
 DROP TABLE #salesTaxRateLookup;                                      
 --DROP TABLE #specialSalesTaxRatesLookup;                                      
 DROP TABLE #useTaxRateLookup;                                      
 --DROP TABLE #specialUseTaxRatesLookup;                       
 DROP TABLE #specialNotes;                                      
END;                                      
                                      
/*                                      
 * Examples                                      
 *                                      
select top 1 * from z2t_ZipStandard where multicounty = 'y'                                      
         
DECLARE @errorCode int, @severity int, @errorMessage nvarchar(max)                                      
EXEC [dbo].[z2t_Basic_Lookup]                                      
  @zip = N'55431', --13210-2654                                      
  @userName = N'nathan',                                      
  @errorCode = @errorCode OUTPUT,                                      
  @severity = @severity OUTPUT,                                      
  @errorMessage = @errorMessage OUTPUT                                      
SELECT @errorCode as N'@errorCode', @severity as N'@severity', @errorMessage as N'@errorMessage'                                      
                                      
DECLARE @errorCode int, @severity int, @errorMessage nvarchar(max)                                      
EXEC [dbo].[z2t_Basic_Lookup]                                      
  @zip = N'13316', --13210-2654                                      
  @userName = N'nathan',                                      
  @errorCode = @errorCode OUTPUT,                                      
  @severity = @severity OUTPUT,                                      
  @errorMessage = @errorMessage OUTPUT                           
SELECT @errorCode as N'@errorCode', @severity as N'@severity', @errorMessage as N'@errorMessage'                                      
                                      
                                      
--grant execute on z2t_Basic_Lookup to z2t_PinPoint_User                                       
                                      
                                      
                                  
DECLARE @errorCode int, @severity int, @errorMessage nvarchar(max)                                      
EXEC [dbo].[z2t_Basic_Lookup]                                      
  @zip = N'13316', --13210-2654                                      
  @userName = N'lrowlands',                                      
  @errorCode = @errorCode OUTPUT,                                      
  @severity = @severity OUTPUT,                                      
  @errorMessage = @errorMessage OUTPUT                                      
SELECT @errorCode as N'@errorCode', @severity as N'@severity', @errorMessage as N'@errorMessage'                                      
                                      
*/ 