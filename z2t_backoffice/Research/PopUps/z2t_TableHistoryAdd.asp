<%
        Response.buffer=true
        Response.clear

        Title = "Zip2Tax Table History Add"

		Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
		Dim rs: Set rs=server.createObject("ADODB.Recordset")
		connPhilly01.Open "driver=SQL Server;server=208.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_Maintenance"
        strSQL = "z2t_TableEffectiveDateHistory_next"
        rs.open strSQL, connPhilly01, 3, 3, 4

		If not rs.eof Then
			eFullDate = rs("FullDate")
		End If
		
        rs.close

%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
    <script language="JavaScript" src="/z2t_BackOffice/includes/dates/checkDate.js" type="text/javascript"></script>
    <script language="JavaScript" src="/z2t_BackOffice/includes/dates/ts_picker.js" type="text/javascript"></script>
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
</head>


<body onLoad="SetScreen(550,450);">
  <form method="Post" action="z2t_TableHistoryAddPost.asp" name="frm">

	  <span class="popupHeading"><%=Title%></span>

<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
			<tr>
				<td>
					Clicking submit below will create the next month in the table history.
					Are you sure this is what you want to do?
				</td>		 
			</tr>

			<tr><td>&nbsp;</td></tr>
			
			<tr>
				<td align="center">
					Adding <%=eFullDate%>
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
