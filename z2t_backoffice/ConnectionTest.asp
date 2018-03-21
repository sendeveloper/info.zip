<% 
	Response.Write "Hello<br>"

    Dim connUpdateRates: Set connUpdateRates=server.CreateObject("ADODB.Connection")
    connUpdateRates.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_UpdateRates" ' philly05

	
    Dim connBackoffice: Set connBackoffice=server.CreateObject("ADODB.Connection")
    connBackoffice.Open "driver=SQL Server;server=localhost;uid=davewj2o;pwd=get2it;database=z2t_BackOffice" ' philly05

	Response.Write "Connection to Philly05 Established<br>"
	
	
	
    Dim connCasper: Set connCasper = server.CreateObject("ADODB.Connection")
    connCasper.Open "driver=SQL Server;server=66.119.55.118,7043;uid=davewj2o;pwd=get2it;database=z2t_BackOffice" ' Casper10

	Response.Write "Connection to Casper10 Established<br>"
	
	
	
    Dim objcon: Set objcon=server.CreateObject("ADODB.Connection")
    objcon.Open "driver=SQL Server;server=68.178.202.54;uid=davewj2o;pwd=get2it;database=ha_prod" ' barley1
	
	Response.Write "Connection to Barley1 Established<br>"

	
	
    Dim connAdmin: Set connAdmin=server.CreateObject("ADODB.Connection")
    connAdmin.Open "driver=SQL Server; server=208.109.189.101; uid=davewj2o; pwd=get2it; database=z2t_WebBackoffice" ' barley2
	
	Response.Write "Connection to Barley2 Established<br>"

	
    Dim connPublic: Set connPublic=server.CreateObject("ADODB.Connection")
    connPublic.Open "driver=SQL Server; server=208.109.189.101; uid=davewj2o; pwd=get2it; database=z2t_WebPublic" ' barley2

		
%>
