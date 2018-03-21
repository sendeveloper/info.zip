<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<%
Response.buffer=true
%>

<html>
<head>
    <title>State Page Maintenance Titles Post</title>
</head>

<%	


	Dim rs: Set rs=server.createObject("ADODB.Recordset")

    Dim strSQL

    strSQL = "z2t_StatePageMaintenanceTitles_write(" & _
		"'" & Request("State") & "', " & _
		"'" & Request("LinkURL1") & "', " & _
		"'" & Request("LinkURL2") & "', " & _
		"'" & Request("LinkURL3") & "', " & _
		"'" & Request("LinkURL4") & "', " & _
		"'" & Request("LinkName1") & "', " & _
		"'" & Request("LinkName2") & "', " & _
		"'" & Request("LinkName3") & "', " & _
		"'" & Request("LinkName4") & "', " & _
		"'" & Session("z2t_ShortName") & "')"
	
	response.write strSQL
	connPhilly01PublishTables.Execute strSQL

%>

<script>
	window.opener.location.href = window.opener.location.href;
    window.close()
</script>
	

</html>
