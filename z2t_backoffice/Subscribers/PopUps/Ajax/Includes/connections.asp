<%
   ' Activity
	Dim pathLookupAPI, connStrRequestVariables
	connStrRequestVariables = "driver=SQL Server;server=66.119.50.229,7943;uid=davewj2o;pwd=get2it;database=z2t_WebPublic"
	pathLookupAPI = "http://frank02-api.zip2tax.com/"

	Set ObjCon = server.CreateObject("ADODB.Connection")
	ObjCon.Open connStrRequestVariables 'Casper09

%>
