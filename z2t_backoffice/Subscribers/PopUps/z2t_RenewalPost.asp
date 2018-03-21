<% 
''''' Changelog
' 
' <2011-03-15 Tue nathan> Fixed include path for `z2t_connection.asp'
' <2012-02-06 Mon Dave> Added ShutoffDate field.
'
%>

<%
Response.buffer=true
%>

<!--#include file="../../includes/config.asp"-->
<!--#include file="includes/z2t_Connection.asp"-->

<html>
<head>
    <title>Zip2Tax Renewal Effort</title>
</head>

<%
    Dim rs
    Dim SQL

    SQL = "z2t_Renewal_write(" &_ 
          Request("z2tID") & ", " &_
          "'" & fixAps(Request("Note")) & "', " &_
          "'" & Session("ha_login") & "')" 
    'Response.Write SQL
    'Response.End
    connDallas.Execute SQL

    Function fixAps( ByVal theString )
        fixAps = Replace( theString, "'", "''" )
    End Function

%>

<script>
    window.opener.location.href = window.opener.location.href;
    window.close()
</script>
	

</html>
