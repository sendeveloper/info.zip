<%

    dim objcon
    set objcon=server.CreateObject("ADODB.Connection")
    objcon.Open "driver=SQL Server;server=66.119.50.228,7843;uid=davewj2o;pwd=get2it;database=ha_prod"

    set rs=server.createObject("ADODB.Recordset")

    SQL="z2t_Login_Password_create(" & Request("ID") & ")" 

    rs.open SQL,objcon, 3, 3, 4

    Response.Write rs("Logon") & "," & rs("Password")

    rs.close

%>

