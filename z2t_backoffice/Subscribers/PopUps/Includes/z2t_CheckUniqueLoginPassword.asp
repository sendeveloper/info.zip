<%

    dim objcon
    set objcon=server.CreateObject("ADODB.Connection")
    'connPublic.Open "driver=SQL Server;server=dbWeb.Zip2Tax.com;uid=z2t_WebUser;pwd=WebUser_z2t;database=z2t_WebPublic"
    objcon.Open "driver=SQL Server;server=66.119.50.228,7843;uid=davewj2o;pwd=get2it;database=ha_CRM"  'Casper08

    set rs=server.createObject("ADODB.Recordset")

    SQL="z2t_Login_Password_check(" & Request("ID") & ", '" & Request("L") & _
            "', '" & Request("P") & "')" 

    rs.open SQL,objcon, 3, 3, 4

    Response.Write rs("LoginCount") & ", " & rs("PasswordCount")

    rs.close

%>

