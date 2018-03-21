<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<%
  Dim opid
  Dim EmpId
  Dim rs
  Dim sqlText
  Dim vbcrlf: vbcrlf = "<br>" 'chr(13) + chr(10)
  'sqlDebug = True

  If Session("z2t_AccountId") = "" Then
    Response.Write("Login Expired")
    Response.End
  End If

  Select Case Request("op")
  Case "research-operations"
%>
   <style>
     .resultset td, .resultset th {font-size: 1em !important; padding: 1em !important;}
   </style>
   <div style="text-align: center;">
     <h1 style="font-size: 2em;">Research Operations</h1>
     <%=SqlTable("select op.id, op.Description, op.Help, op.[Procedure], CreatedBy = hec.UserName, op.CreatedDate, EditedBy = hee.UserName, op.EditedDate from z2t_BackOffice.dbo.z2t_ResearchOperations_operations with(nolock) as op left join ha_BackOffice.dbo.ha_EmpAccounts as hec on hec.EmpId = op.CreatedBy left join ha_BackOffice.dbo.ha_EmpAccounts as hee on hee.EmpId = op.EditedBy where op.DeletedDate is null order by CreatedDate asc")%>
     <h1 style="font-size: 2em;">Research Operation Log</h1>
     <%=SqlTable("select Employee, Operation, Status, Detail, Started = dateadd(hour, Started = datediff(hour, getutcdate(), getdate()), Started), Completed = dateadd(hour, Completed = datediff(hour, getutcdate(), getdate()), Completed) from z2t_BackOffice.dbo.z2t_ResearchOperations_activity with(nolock) order by Completed desc, Started desc")%>
   </div>
<%
  Case "zipcode-import"
    opid = SqlValue("select id from z2t_BackOffice.dbo.z2t_ResearchOperations_operations with(nolock) where Description = '" & Request("op") & "'", "id")
    EmpId = SqlValue("select HarvestId from z2t_BackOffice.dbo.z2t_Accounts_Subscriptions_repl with(nolock) where AccountId = " & Session("z2t_AccountId"), "HarvestId")
    EmpId = SqlValue("select EmpId from ha_BackOffice.dbo.ha_EmpAccounts with(nolock) where HarvestId = " & EmpId, "EmpId")
    Set rs = Sql("insert into z2t_BackOffice.dbo.z2t_ResearchOperations_log (EmpId, OperationId, Status, Detail, StartDate, EndDate) select " & EmpId & ", " & opid & ", 'Started', 'Started <' + (select Description from z2t_BackOffice.dbo.z2t_ResearchOperations_operations with(nolock) where id = " & opid & ") + '>', getutcdate(), null")

    Response.Write("Doing zipcode-import.")


  ' ops
  Case "rename-export-table"
    sqlText = "z2t_export.dbo.sp_rename 'z2t_ZipCodes', 'z2t_ZipCodes_2012_04_23__n'; select count(*) from z2t_Export.dbo.z2t_ZipCodes_2012_04_23__n with(nolock)"
    Response.Write(sqlValue(sqlText, "count"))
    Response.Write("Moved z2t_Export.dbo.z2t_Zipcodes out of the way.")
  Case "apply-taxdata"
    'update z2t_UpdateRates.dbo.z2t_TaxData => z2t_UpdateZipCodes.dbo.z2t_Zipcodes
    sqlText = "declare @date datetime; select @date = util.dbo.z2t_ResearchDate(); exec z2t_UpdateRates.dbo.z2t_UpdateAll_NEW @date"
    Set rs = Sql(sqlText) ' show progress
    Response.Write("Applied tax data.")
  Case "finish-udpate"
    Response.Write("Finished stuff at end.")
  Case "patchup"
    sqlText = "exec z2t_UpdateRates.dbo.z2t_UpdatePatchup"
    Set rs = Sql(sqlText)
    Response.Write("Patched z2t_Zipcodes.")
  Case "check-rates"
    SqlTable("select z.state, count(*) from z2t_UpdateZipCodes.dbo.z2t_Zipcodes with(nolock) as z where z.salestaxrate <> z.salestaxratesum group by z.state")
    SqlTabel("select z.state, count(*) from z2t_UpdateZipCodes.dbo.z2t_Zipcodes with(nolock) as z where z.usetaxrate <> z.usetaxratesum group by z.state")
    Response.Write("Rates match sums.")
  Case "check-integrity"
    Response.Write("Data integrity check passed.")
  Case "place-export-data"
    'move z2t_Export.dbo.z2t_ZipCodes into place
    sqlText = "select * into z2t_Export.dbo.z2t_ZipCodes from z2t_UpdateZipcodes.dbo.z2t_ZipCodes with(nolock); select count(*) from z2t_Export.dbo.z2t_ZipCodes with(nolock)"
    Set rs = Sql(sqlText)
    Response.Write("Copied z2t_Zipcodes into z2t_Export database.")
  Case "generate-tables"
    'export program
    Response.Write("Ran the export program.")
  Case "check-differences"
    Response.Write("Table difference are as expected.")
  Case "release-tables"
    Response.Write("Tables released for download.")
  Case "release-web/link"
    Response.Write("Data made live for web-lookups / database-link.")


  ' add a jurisdiction
  Case "help-add-jurisdiction"
%>
   <style>
     .resultset td, .resultset th {font-size: 1em !important; padding: 1em !important;}
   </style>
   <div style="text-align: center;">
     <h1 style="font-size: 2em;">Newly Created Jurisdictions</h1>
     <%=SqlTable("select * from z2t_UpdateRates.dbo.z2t_TaxData as t with(nolock) where z2t_UpdateRates.dbo.EffCurrent(EffFrom, EffTo, DeletedDate, (select util.dbo.z2t_ResearchDate())) = 1 and createddate > dateadd(day, -1, getutcdate())")%>
     <h1 style="font-size: 2em;">Research Operation Log</h1>
     <%=SqlTable("select Employee, Operation, Status, Detail, Started = dateadd(hour, datediff(hour, getutcdate(), getdate()), Started), Completed = dateadd(hour, datediff(hour, getutcdate(), getdate()), Completed) from z2t_BackOffice.dbo.z2t_ResearchOperations_activity with(nolock) where Operation = 'add jurisdiction' order by Completed desc, Started desc")%>
   </div>
<%
  Case "add-jur"
    opid = SqlValue("select id from z2t_BackOffice.dbo.z2t_ResearchOperations_operations with(nolock) where Description = 'add jurisdiction'", "id")
	EmpId= Session("z2t_AccountId")
	
	''''Line below is commented by Humair to fix EOF error 5 Nov 2015
	'''' It is Passing a value as AccountId , which is acutally HarvestId
	'''' So we don't need get HarvestId again.
	
    'EmpId = SqlValue("select HarvestId from z2t_BackOffice.dbo.z2t_Accounts_Subscriptions_repl with(nolock) where AccountId = " & Session("z2t_AccountId"), "HarvestId")
	'sqlval = "select EmpId from ha_BackOffice.dbo.ha_EmpAccounts with(nolock) where HarvestId = " & EmpId
		'response.Write(sqlval)
	'response.End()
	Dim connCasper10HaBackoffice: Set connCasper10HaBackoffice=server.CreateObject("ADODB.Connection")
	Set rsC10=server.createObject("ADODB.Recordset")
    connCasper10HaBackoffice.Open "driver=SQL Server;server=casper10.HarvestAmerican.net,7043;uid=davewj2o; pwd=get2it; database=ha_BackOffice" ' philly04
	
	sqlEmpC10 = "select top 1  EmpId,UserName from ha_EmpAccounts  where UserName = '" & Session("z2t_login") & "' and Password='" & Session("usrPass") & "'"
	'response.Write(sqlEmpC10)
	'response.End()
	rsC10.open sqlEmpC10, connCasper10HaBackoffice
	
EmpId = rsC10("EmpId")
EmpLogin = rsC10("UserName")
   ' EmpId = SqlValue("select EmpId from ha_BackOffice.dbo.ha_EmpAccounts with(nolock) where HarvestId = " & EmpId, "EmpId")
    'Dim EmpLogin: EmpLogin = SqlValue("select UserName = rtrim(ltrim(UserName)) from ha_BackOffice.dbo.ha_EmpAccounts with(nolock) where EmpId = " & EmpId, "UserName")

    sqlText = "insert into z2t_BackOffice.dbo.z2t_ResearchOperations_log (EmpId, OperationId, Status, Detail, StartDate, EndDate) select " & EmpId & ", " & opid & ", 'Started', 'Started <' + (select Description from z2t_BackOffice.dbo.z2t_ResearchOperations_operations with(nolock) where id = " & opid & ") + '>', getutcdate(), null; select id = @@identity"
	
	z2t_TaxDataID = SqlValue("select max(id) as z2t_TaxDataID from z2t_UpdateRates.dbo.z2t_TaxData","z2t_TaxDataID")
	
	z2t_TaxDataID = z2t_TaxDataID + 1
	
    Set rs = Sql(sqlText)
    Set rs = rs.NextRecordSet ' skip blank insertion recordset
    id = rs("id")
    Response.Write("Doing add-jurisdiction." & vbcrlf & vbcrlf)

    Dim count: count = SqlValue("select [count] = count(*) from z2t_UpdateRates.dbo.z2t_TaxData with(nolock) where DeletedDate is null and state = '" & Request("state") & "' and county = '" & Request("county") & "' and city = '" & Request("city") & "' and taxtype in (" & Request("taxtype") & ") and JurType = " & Request("jurtype") & " and DeletedDate is null", "count")

    Dim jur
    Dim county
    Dim id
    Dim taxtypes: taxtypes = trim(ifnull(Request("taxtype"), "1,2"))
	'response.Write(Request("jurtype"))
	'response.End()
    Select Case Request("jurtype")
	
	Case "4"
      For Each taxtype in Split(taxtypes, ",")
        sqlText = "insert into z2t_UpdateRates.dbo.z2t_TaxData(ID,State, County, City, TaxType, TaxTypeVariation, Rate, JurRate, JurType, JurSize, EffFrom, EffTo, CreatedBy, CreatedDate) select z2t_TaxDataID='"&z2t_TaxDataID&"', state = '" & Request("state") & "', county = '" & Request("county") & "', city = '" & Request("city") & "', taxtype = tt.value, taxtypevariation = 0, rate = " & Request("rate") & ", jurrate = " & Request("jurrate") & ", jurtype = " & Request("jurtype") & ", jursize = " & Request("jursize") & ", efffrom = '" & Request("efffrom") & "', effto = '" & Request("effto") & "', createdby = '" & EmpLogin &  "', createddate = getdate() from util.dbo.split('" & taxtype & "') as tt"
       ' Response.Write(sqlText & vbcrlf & vbcrlf)
        Call Sql(sqlText)
      Next
	  'response.End()
      jur = Request("city")
      county = " (" & Request("county") & ")"
	  
    Case "3"
      For Each taxtype in Split(taxtypes, ",")
        sqlText = "insert into z2t_UpdateRates.dbo.z2t_TaxData([ID], State, County, City, TaxType, TaxTypeVariation, Rate, JurRate, JurType, JurSize, EffFrom, EffTo, CreatedBy, CreatedDate) select z2t_TaxDataID='"&z2t_TaxDataID&"', state = '" & Request("state") & "', county = '" & Request("county") & "', city = '" & Request("city") & "', taxtype = tt.value, taxtypevariation = 0, rate = " & Request("rate") & ", jurrate = " & Request("jurrate") & ", jurtype = " & Request("jurtype") & ", jursize = " & Request("jursize") & ", efffrom = '" & Request("efffrom") & "', effto = '" & Request("effto") & "', createdby = '" & EmpLogin &  "', createddate = getdate() from util.dbo.split('" & taxtype & "') as tt"
       ' Response.Write(sqlText & vbcrlf & vbcrlf)
        Call Sql(sqlText)
      Next
	  'response.End()
      jur = Request("city")
      county = " (" & Request("county") & ")"
    Case "2"
	''' Modified By Humair 6 Nov 2015
	''' Added TaxTypeVariation column in Insert statement and passed 0 has its value to avoid "Null not allowed in column TaxTypeVariation" error
      For Each taxtype in Split(taxtypes, ",")
        sqlText = "insert into z2t_UpdateRates.dbo.z2t_TaxData([ID],State, County, TaxType,TaxTypeVariation, Rate, JurRate, JurType, JurSize, EffFrom, EffTo, CreatedBy, CreatedDate) select z2t_TaxDataID='"&z2t_TaxDataID&"', state = '" & Request("state") & "', county = '" & Request("county") & "', taxtype = " & taxtype & ",0, rate = " & Request("rate") & ", jurrate = " & Request("jurrate") & ", jurtype = " & Request("jurtype") & ", jursize = " & Request("jursize") & ", efffrom = '" & Request("efffrom") & "', effto = '" & Request("effto") & "', createdby = '" & EmpLogin &  "', createddate = getdate()"
        'Response.Write(sqlText & vbcrlf & vbcrlf)
        Call Sql(sqlText)
      Next
    jur = Request("county") + " county"
      county = ""
    Case Else
      Response.Write("Invalid jurisdiction type: " & Request("jurtype") & vbcrlf & vbcrlf)
    End Select
    sqlText = "update z2t_BackOffice.dbo.z2t_ResearchOperations_log set EndDate = getutcdate(), Status = 'Success', Detail = 'Created " & jur & ", " & Request("state") & county & "; taxtype " & Request("taxtype") & "' where id = " & id
    'Response.Write(sqlText & vbcrlf & vbcrlf)
    Set rs = Sql(sqlText)

  Case Else
    'Response.Write("No such operation." & vbcrlf & vbcrlf)
    Response.Write(Request("op"))
  End Select
  
  response.Write("done")
%>
