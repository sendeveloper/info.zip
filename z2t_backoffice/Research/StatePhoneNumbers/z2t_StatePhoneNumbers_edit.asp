<%
        Response.buffer=true
        Response.clear

        Title = "State Phone Numbers Edit"

		Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
		Dim rs: Set rs=server.createObject("ADODB.Recordset")
		connPhilly01.Open "driver=SQL Server;server=10.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables" ' philly01
        strSQL = "z2t_StateInfo_read('" & request("state") & "')"
        rs.open strSQL, connPhilly01, 3, 3, 4

		If not rs.eof Then
			ePhoneNumber = rs("ContactNumber")
			eStateName = rs("Name")
		End If
		
        rs.close

%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="/z2t_BackOffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
</head>


<body onLoad="SetScreen(550,450);">
  <form method="Post" action="z2t_StatePhoneNumbers_post.asp?State=<%=Request("State")%>" name="frm">

	  <span class="popupHeading"><%=Title%></span>

<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
			<tr>
				<td style="color: #999999;" colspan="2">
					These are the numbers you can give to customers
					who request more in depth information about a particular state.
				</td>		 
			</tr>

			<tr><td>&nbsp;</td></tr>
			
			<tr>
			  <td Width="45%" align="right">
			    <%=eStateName%> Phone Number:
			  </td>
			  <td width="55%" align="left">
				<input class="field date" type="text" size="20" name="PhoneNumber" id="PhoneNumber"
                  value="<%=ePhoneNumber%>">
			  </td>
			</tr>
						
			<tr><td>&nbsp;</td></tr>
						
</table>

    <div class="center" style="margin-top: 2em;">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


  </form>
</body>
</html>
