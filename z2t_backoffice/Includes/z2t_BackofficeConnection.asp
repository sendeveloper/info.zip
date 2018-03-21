<%
    Dim objcon: Set objcon=server.CreateObject("ADODB.Connection")
    objcon.Open "driver=SQL Server;server=66.119.50.228,7843;uid=davewj2o;pwd=get2it;database=ha_prod" ' Casper08

    'Dim connAdmin: Set connAdmin=server.CreateObject("ADODB.Connection")
	'connAdmin.Open "driver=SQL Server; server=208.109.189.101; uid=davewj2o; pwd=get2it; database=z2t_WebBackoffice" ' barley2 commented by humair 1 sep 2016, website recovery task
    'connAdmin.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_Backoffice" 

    Dim connPublic: Set connPublic=server.CreateObject("ADODB.Connection")
    connPublic.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_WebPublic" ' philly05

    Dim connUpdateRates: Set connUpdateRates=server.CreateObject("ADODB.Connection")
		connUpdateRates.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_UpdateRates" ' philly05
'    connUpdateRates.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_UpdateRates" ' philly04

    Dim connBackoffice: Set connBackoffice=server.CreateObject("ADODB.Connection")
    connBackoffice.Open "driver=SQL Server;server=localhost;uid=davewj2o; pwd=get2it; database=z2t_BackOffice" ' philly04

    Dim connWebBackoffice: Set connWebBackoffice=server.CreateObject("ADODB.Connection")
    connWebBackoffice.Open "driver=SQL Server;server=localhost;uid=z2t_BackOffice; pwd=r6b244uu; database=z2t_WebBackOffice" ' Philly05
	
    Dim connCasper: Set connCasper = server.CreateObject("ADODB.Connection")
    connCasper.Open "driver=SQL Server;server=66.119.50.230,7043;uid=davewj2o;pwd=get2it;database=z2t_BackOffice" ' Casper10
	'''philly01 for write Operations
	dim connPublicWrite
	set connPublicWrite=server.CreateObject("ADODB.Connection")
	connPublicWrite.Open "driver=SQL Server;server=Philly01.HarvestAmerican.net,8143;uid=davewj2o;pwd=get2it;database=z2t_Subscriptions" 

'''Philly01 Published Tables
	dim connPhilly01PublishTables
	set connPhilly01PublishTables=server.CreateObject("ADODB.Connection")
	connPhilly01PublishTables.Open "driver=SQL Server;server=Philly01.HarvestAmerican.net,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables"

'''	Philly01Maintenance	
	Dim connPhilly01Maintenance: Set connPhilly01Maintenance=server.CreateObject("ADODB.Connection")
	connPhilly01Maintenance.Open "driver=SQL Server;server=208.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_Maintenance" ' philly01


    Set rs=server.createObject("ADODB.Recordset")
    Set rs2=server.createObject("ADODB.Recordset")
    Set rs3=server.createObject("ADODB.Recordset")


    'Post the page load into activity

    Dim Data1: Data1 = ""
    Dim Data2: Data2 = ""

    pgeURL = Request.ServerVariables("path_info")

    If left(pgeURL,1) = "/" Then
        pgeURL = mid(pgeURL&"  ",2)
    End If

    pgeURL = trim(pgeURL)


    URL = Request.ServerVariables("HTTP_REFERER")


    Dim sqlText: sqlText = "z2t_Activity_add_new('" &_
      Session("z2t_UserName") & "', 17, " &_
      "'" & Data1 & "', " &_
      "'" & Data2 & "', " &_
      "'" & pgeURL & "', " &_
      "'" & URL & "', " &_
      "'" & Session.SessionID & "', " &_
      "'" & Request.ServerVariables("REMOTE_ADDR") & "', " &_
      "'z2t_BackofficeConnection.asp', " &_
      Session("CookieID") & ")"

    connBackoffice.Execute(sqlText)
%>
