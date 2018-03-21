<% 
''''' Changelog
' 
' <2011-03-15 Tue nathan> Fixed include path for `z2t_connection.asp'
' <2012-02-06 Mon Dave> Added ShutoffDate field.
' <2013-08-08 Thur Dave> Migrated to Philly05.
'
%>

<!--#include file="includes/z2t_Connection.asp"-->

<html>
<head>
    <title>Zip2Tax Subscription Post</title>
</head>

<%
    Dim rs
    Dim sqlText
	
	If Request("SubscriptionServiceLevel") = "" Then
		request_SubscriptionServiceLevel = 0
	Else
		request_SubscriptionServiceLevel = Request("SubscriptionServiceLevel")
	End If
	
	If Request("SubscriptionPeriod") = "" Then
		request_SubscriptionPeriod = 0
	Else
		request_SubscriptionPeriod = Request("SubscriptionPeriod")
	End If

	'Response.Write "|" & Request("LookupLimitWeb") & "|<br>"
	If IsNumeric(Request("LookupLimitWeb")) Then
		request_LookupLimit = Request("LookupLimitWeb")
	Else
		request_LookupLimit = 0
	End If

	If Trim(Request("TableType")) = "" Then
		request_TableType = 0
	Else
		request_TableType = Request("TableType")
	End If
	
	SubscriptionType = Trim(Left(Request("SubscriptionType") & "   ", 3))
		
	Dim tmp_usetax
	
	if Request("SubscriptionType") = "link" Then
		tmp_usetax = Request("UseTax1")
	Else
		tmp_usetax = Request("UseTax")
	End If

    sqlText = "exec z2t_Subscription_write " & _
	Request("z2tID") & ", " & _
	Request("HarvestID") & ", " & _
	"'" & Request("Login") & "', " & _
	"'" & Request("Password") & "', " & _
	"'" & Session("User") & "', " & _
	"'" & Request("SubscriptionType") & "', " & _
	request_SubscriptionServiceLevel & ", " & _
	request_SubscriptionPeriod & ", " & _
	"'" & Request("AutoRenew") & "', " & _
	"'" & Request("StartDate") & "', " & _
	"'" & Request("ExpirationDate") & "', " & _
	"'" & Request("ShutoffDate") & "', " & _
	"'" & Request("OriginalExpirationDate") & "', " & _
	"'" & Request("EmailNotification1") & "', " & _
	"'" & Request("EmailNotification2") & "', " & _
	"'" & Request("EmailNotification3") & "', " & _
	"'" & Request("DatabaseLinkSingleState") & "', " & _
	request_TableType & ", " & _
	Request("SpecialTableNYClothing") & ", " & _
	"'" & fixAps(Request("Note")) & "', " & _
    "'" & tmp_usetax & "', " & _
	"null, " & _
	"null, " & _
	request_LookupLimit 
	
''  Response.Write sqlText & "<br><br>"
	''response.End()
	rs.Open sqlText, connPublicWrite, 1, 4
	
	If Not rs.eof Then
		result_z2tID = rs("z2tID")
		result_UseTaxID = rs("UseTaxID")
		result_DateNow = rs("DateNow")
	End if
	
	rs.Close()

    sqlText = "merge into z2t_BackOffice.dbo.z2t_Subscriptions as s " &_
          "using (values (" & Request("z2tID") & ")) as v(id) " &_
          "on s.z2t_AccountId = v.id " &_ 
          "when matched then " &_
          "  update set  " &_
          "    OriginalExpirationDate = case when '"  & Request("OriginalExpirationDate") & "' = '' then null else '"  & Request("OriginalExpirationDate") & "' end, " &_
          "    EditedDate = case when CreatedDate is null then EditedDate else getdate() end, " &_
          "    EditedBy = case when CreatedDate is null then EditedBy else '" & Session("login") & "' end " &_
          "when not matched by target then " &_
          "  insert (z2t_AccountID, OriginalExpirationDate, CreatedBy, CreatedDate) " &_
          "  values (" & Request("z2tID") & ", case when '" & Request("OriginalExpirationDate") & "' = '' then null else '" & Request("OriginalExpirationDate") & "' end, '" & Session("login") & "', getdate());"
    'Response.Write sqlText
    'connDallas.Execute sqlText

    Function fixAps( ByVal theString )
        fixAps = Replace( theString, "'", "''" )
    End Function

%>

<script>
	var subType = '<%=SubscriptionType%>';
	var tableType = '<%=request_TableType%>'
	if (((subType=='ini') || (subType=='upd')) && (tableType != 17))  //table subs only and not Canada
		{
		//It's a table subscription, we're heading for the state selector
		var url = 'z2t_StatesEdit.asp?z2tID=<%=result_z2tID%>&subType=Tab';
		}
	else
		{
		//Or, maybe just the update screen
		//var url = 'http://legacy.zip2tax.com/backoffice/TableDistribution_z2t_Accounts/z2t_Accounts_Subscription_Update.asp?z2tID=<%=result_z2tID%>';
		var url = 'http://www.harvestamerican.info/ha_backoffice/Servers/TableDistribution/z2t_Accounts_Subscriptions/TableDistribution_z2t_Accounts_Subscriptions_One.asp?z2tID=<%=result_z2tID%>';
		}
	
	 location.href = url;
</script>
	

</html>
