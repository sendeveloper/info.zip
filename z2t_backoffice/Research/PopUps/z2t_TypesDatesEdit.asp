<%
        Response.buffer=true
        Response.clear

        Title = "z2t_Types Dates Edit"

		Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
		Dim rs: Set rs=server.createObject("ADODB.Recordset")
		connPhilly01.Open "driver=SQL Server;server=208.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_Maintenance"
        strSQL = "z2t_Types_Dates_read"
        rs.open strSQL, connPhilly01, 3, 3, 4

		If not rs.eof Then
			eEffectiveDate = rs("EffectiveDate")
			eReleaseDate = rs("ReleaseDate")
			eResearchingDate = rs("ResearchingDate")
		End If
		
        rs.close

	    DateCaption = "<img src=""/z2t_BackOffice/includes/dates/cal.gif"" " & _
            "width=""16"" height=""16"" border=""0"" alt=""Calendar""></a>" & _
            "<span style=""margin-left: .5em; font-size: 8pt; color: #C0C0C0;"">[mm/dd/yyyy]</span>"

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
  <form method="Post" action="z2t_TypesDatesPost.asp" name="frm">

	  <span class="popupHeading"><%=Title%></span>

<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
			<tr>
				<td style="color: #999999;" colspan="2">
					These dates are in Philly01.z2t_Types.z2t_PublishedTables and will be
					distributed to other servers once editing is complete.
				</td>		 
			</tr>

			<tr><td>&nbsp;</td></tr>
			
			<tr>
			  <td Width="35%" align="right">
			    Effective Date:
			  </td>
			  <td width="55%" align="left">
				<input class="field date" type="text" size="10" name="EffectiveDate" id="EffectiveDate"
                  value="<%=eEffectiveDate%>">
					<a href="javascript:show_calendar('document.frm.EffectiveDate', document.frm.EffectiveDate.value);">
					  <%=DateCaption%></a>
			  </td>
			</tr>
			
			<tr>
			  <td align="right">
			    Release Date:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="10" name="ReleaseDate" id="ReleaseDate"
                  value="<%=eReleaseDate%>">
					<a href="javascript:show_calendar('document.frm.ReleaseDate', document.frm.ReleaseDate.value);">
					  <%=DateCaption%></a>
			  </td>
			</tr>

			<tr>
			  <td align="right">
			    Researching Date:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="10" name="ResearchingDate" id="ResearchingDate"
                  value="<%=eResearchingDate%>">
					<a href="javascript:show_calendar('document.frm.ResearchingDate', document.frm.ResearchingDate.value);">
					  <%=DateCaption%></a>
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
