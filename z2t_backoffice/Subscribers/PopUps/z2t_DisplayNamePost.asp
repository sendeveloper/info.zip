<%
Response.buffer=true
%>

<!--#include file="includes/z2t_Connection.asp"-->

<html>
<head>
    <title>Zip2Tax Display Name Edit Post</title>
</head>

<%
    If Request("DebugData") = "Y" Then
		DisplayName = Request("DisplayName") & " (Debug On)"
	Else
		DisplayName = Request("DisplayName")
	End If
	
	Dim rs
    Dim SQL

    SQL = "z2t_DisplayName_write(" &_ 
          Request("z2tID") & ", " &_
          "'" & fixAps(DisplayName) & "', " &_
          "'" & Request("user") & "')" 
    'Response.write sql & "<br>"
	connPublicWrite.Execute SQL
	
    Function fixAps( ByVal theString )
        fixAps = Replace( theString, "'", "''" )
    End Function

%>

<script>
//	var url = 'http://legacy.zip2tax.com/backoffice/TableDistribution_z2t_Accounts/z2t_Accounts_Subscription_Update.asp?z2tID=<%=Request("z2tID")%>';
	var url = 'http://www.harvestamerican.info/ha_backoffice/Servers/TableDistribution/z2t_Accounts_Subscriptions/TableDistribution_z2t_Accounts_Subscriptions_One.asp?z2tID=<%=Request("z2tID")%>';
	location.href = url;
    //window.close()
</script>
	

</html>
