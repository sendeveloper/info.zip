<%

    dim objcon
    set objcon=server.CreateObject("ADODB.Connection")
    objcon.Open "driver=SQL Server;server=66.119.50.228,7843;uid=davewj2o;pwd=get2it;database=ha_prod"  'Casper08

    dim connAdmin
    set connAdmin=server.CreateObject("ADODB.Connection")
    connAdmin.Open "driver=SQL Server;server=208.109.189.101;uid=z2t_WebAdmin;pwd=WebAdmin_z2t;database=z2t_WebBackoffice"   'Barley2

    dim connPublic
    set connPublic=server.CreateObject("ADODB.Connection")
    connPublic.Open "driver=SQL Server;server=208.109.189.101;uid=z2t_WebUser;pwd=WebUser_z2t;database=z2t_WebPublic"  'Barley2

    dim connPhilly05
    set connPhilly05=server.CreateObject("ADODB.Connection")
    connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=z2t_Subscription_Admin;pwd=get2subscriptions;database=z2t_Backoffice;"
	
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

%>
