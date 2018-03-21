<%

    dim objcon
    set objcon=server.CreateObject("ADODB.Connection")
    objcon.Open "driver=SQL Server;server=66.119.50.228,7843;uid=davewj2o;pwd=get2it;database=ha_prod"  'Casper08

    dim connAdmin
    set connAdmin=server.CreateObject("ADODB.Connection")
    connAdmin.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Backoffice"   'Barley2

    dim connPublic
    set connPublic=server.CreateObject("ADODB.Connection")
     connPublic.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_WebPublic" '


	'''Philly05 one for replacement of Barley Read events
   	dim connPublicRead
	set connPublicRead=server.CreateObject("ADODB.Connection")
	connPublicRead.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_WebPublic" 
	
	'''philly01 for write Operations
	dim connPublicWrite
	set connPublicWrite=server.CreateObject("ADODB.Connection")
	connPublicWrite.Open "driver=SQL Server;server=Philly01.HarvestAmerican.net,8143;uid=davewj2o;pwd=get2it;database=z2t_Subscriptions" 

    Dim connCRM: Set connCRM=server.CreateObject("ADODB.Connection")
    connCRM.Open "driver=SQL Server;server=66.119.50.228,7843;uid=davewj2o;pwd=get2it;database=ha_CRM" ' Casper08 crm
	
    dim connPhilly05
    set connPhilly05=server.CreateObject("ADODB.Connection")
    connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Backoffice;"
	'' removing this user due rights   
	'' uid=z2t_Subscription_Admin;pwd=get2subscriptions;
    set rs=server.createObject("ADODB.Recordset")
    set rs2=server.createObject("ADODB.Recordset")
    set rs3=server.createObject("ADODB.Recordset")


    'Post the page load into activity

    Data2 = ""
    Data1 = ""

    pgeURL = Request.ServerVariables("path_info")

    if left(pgeURL,1) = "/" then
        pgeURL = mid(pgeURL&"  ",2)
    end if

    pgeURL = trim(pgeURL)


    URL = Request.ServerVariables("HTTP_REFERER")


Function MarkActivity(loginName, eventName,Data1, Data2, accountID, pageName)
 'Post the page load into activity z2t

    SQL = "z2t_Activity_add_new('" & Session("z2t_UserName") & "', 17, " & _
            "'" & Data1 & "', " & _
            "'" & Data2 & "', " & _
            "'" & pgeURL & "', " & _
            "'" & URL & "', " & _
            "'" & Session.SessionID & "', " & _
            "'" & Request.ServerVariables("REMOTE_ADDR") & "', " & _
            "'z2t_Connection.asp', " & _
            Session("CookieID") & ")"
			

    connPublic.Execute(sql)


 'Post the page load into activity crm
    sqlText = "crm_Activity_add('" & loginName & "', " & _
	  "'"& eventName &"', " &_
      "'" & Request.ServerVariables("path_info") & "', " &_
      "'" & Request.ServerVariables("HTTP_REFERER") & "', " &_
	  "'"& Data1 &"', " & _
	  "'"& Data2 &"', " & _
	  ""& accountId&", " & _
      "'" & Session.SessionID & "', " &_
      "'" & Request.ServerVariables("REMOTE_ADDR") & "', " &_
      "'"&pageName&"')"
 '  response.Write(sqlText)
'  response.End()

    connCRM.Execute(sqlText)
   
End Function

%>
