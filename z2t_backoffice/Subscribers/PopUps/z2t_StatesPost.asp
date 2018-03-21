<% 
''''' Changelog
' 
' <2011-03-15 Tue nathan> Fixed include path for `z2t_connection.asp'
' <2013-07-27 Sun Dave> Moved to Philly05
'
%>

 
<!--#include file="includes/z2t_Connection.asp"-->

<html>
<head>
    <title>Zip2Tax States Post</title>
</head>

<%
    SQL = ""

    for i = 1 to request("chkAction").Count
        'Response.Write(Request("chkAction")(i) & "<br />")
        SQL = SQL & Request("chkAction")(i) & ", "
    next

    If Len(SQL) > 2 Then
      SQL = left(SQL,Len(SQL)-2)
    Else
      SQL = ""
    End If
    'Response.Write(sql & "<br />")

    SQL = "z2t_StateEdit_post(" & Request("z2tID") & ", '" & SQL & "')"

    'Response.Write SQL
    connPublicWrite.Execute SQL
	
		MarkActivity Session("User"),"Z2T States", "States Change for Z2TID "&Request("z2tID"), " ",session("HarvestID"), "z2t_SStatesPost.asp"
%>

<script>
	//var url = 'http://legacy.zip2tax.com/backoffice/TableDistribution_z2t_Accounts/z2t_Accounts_Subscription_Update.asp?z2tID=<%=Request("z2tID")%>';
	var url = 'http://www.harvestamerican.info/ha_backoffice/Servers/TableDistribution/z2t_Accounts_Subscriptions/TableDistribution_z2t_Accounts_Subscriptions_One.asp?z2tID=<%=Request("z2tID")%>';
	location.href = url;
    //window.opener.location.href = window.opener.location.href;
    //window.close()
</script>
	

</html>
