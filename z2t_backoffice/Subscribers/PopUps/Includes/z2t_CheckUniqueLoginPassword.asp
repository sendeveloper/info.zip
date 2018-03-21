<%

    dim connPublic
    set connPublic=server.CreateObject("ADODB.Connection")
    connPublic.Open "driver=SQL Server;server=dbWeb.Zip2Tax.com;uid=z2t_WebUser;pwd=WebUser_z2t;database=z2t_WebPublic"

    set rs=server.createObject("ADODB.Recordset")

    SQL="z2t_Login_Password_check(" & Request("ID") & ", '" & Request("L") & _
            "', '" & Request("P") & "')" 

    rs.open SQL,connPublic, 3, 3, 4

    Response.Write rs("LoginCount") & ", " & rs("PasswordCount")

    rs.close

%>

