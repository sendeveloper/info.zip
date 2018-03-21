<%
	Response.AddHeader "Access-Control-Allow-Origin", "*"
	Response.AddHeader "Access-Control-Allow-Credentials", true 

	
    Response.ContentType = "text/xml"
    Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>"
    Response.Write "<Domain_Test>"
	
	Response.Write "<IP>" & Request.ServerVariables("LOCAL_ADDR") & "</IP>"
	Response.Write "<Server_Name>" & Request.ServerVariables("Server_Name") & "</Server_Name>"
	Response.Write "<Server_Protocol>" & Request.ServerVariables("Server_Protocol") & "</Server_Protocol>"
	Response.Write "<Server_Software>" & Request.ServerVariables("Server_Software") & "</Server_Software>"
	
    Response.Write "</Domain_Test>"
	
%>
