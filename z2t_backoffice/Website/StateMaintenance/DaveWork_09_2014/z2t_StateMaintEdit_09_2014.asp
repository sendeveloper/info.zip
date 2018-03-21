<!--#include virtual="z2t_Backoffice/includes/functions.asp"-->

<%
	Response.buffer=true
	Response.clear
	Dim strMessage
	Dim strMode
	Dim strState
	
	Dim Field(99)
	Dim FieldEdit(99)
	Dim FieldValue(99)
	Dim FieldCount

    If Request("State")="" or IsNull(Request("State")) Then
		Close
	Else
		strState = Request("State")
    End If

	Dim connLocal: Set connLocal=server.CreateObject("ADODB.Connection")
	Dim rs: Set rs=server.createObject("ADODB.Recordset")
	connLocal.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Backoffice"

	'Get Field Names (Variables)
    strSQL = "z2t_Types_StatePageVariables_read"
    rs.Open strSQL, connLocal, 3, 3, 4

	If Not rs.eof Then
		Do While Not rs.eof
			FieldCount = FieldCount + 1
			Field(FieldCount) = rs("Description")
			rs.MoveNext
		Loop
	End If
	
	rs.Close
	
	'Read Field Values
	Dim rsDD
	Dim SQL, SQLDD
	Dim EditMode
	
    
    If IsNull(Request("EditMode")) or UCase(Request("EditMode")) <> "Y" Then
		EditMode = ""
	Else
		EditMode = "Y"
    End If

	Set rs = server.createObject("ADODB.Recordset")

	SQL="SELECT * FROM z2t_Webpage_Duplication_States " & _
	    "WHERE [State] = '" & strState & "'"

	Dim FieldSub
	Dim FieldName
		
	rs.open SQL, connLocal, 2, 3
	
    Title = "State Page Maintenance - " & rs("StateFullName") & "(" & strState & ")"
	
	For i = 1 to FieldCount
		FieldValue(i) = iisNull(rs(Field(i)))
	Next
	
%>



<html>
<head>
    <title><%=Title%></title>
	
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>		
    <link href="/z2t_BackOffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">

	<script language='JavaScript'>
					
		function clickEdit(id)
			{
			document.getElementById("editWindowTitle").innerHTML = 'Edit ' + Field[id];
			document.getElementById("editWindowText").innerHTML = FieldEdit[id];
			document.getElementById("editWindow").style.visibility='visible';
			}
			
		function clickEditCancel()
			{
			document.getElementById("editWindow").style.visibility='hidden';
			}
	</script>
	
    <style type="text/css">
        th {font-family: arial; color: black; font-size: 12}
        td {font-family: arial; color: black; font-size: 12}

		a.button {font-weight: bold; font-size: 10px; 
			font-family: Verdana, Arial, Helvetica, sans-serif;	
			padding: 4px 8px; 
			border-top: 1px solid #E0E0E0;
			border-right: 1px solid black; 
			border-bottom: 1px solid black;
			border-left: 1px solid #E0E0E0; 
			background-color: #BB0000; color: #FFFFFF;
			text-align: center; width: 100px;
			text-decoration: none;}

		a.button:hover {border-color: black white white black;}
		
		td.label
			{
			vertical-align:	top;
			text-align:		right;
			width:			15%;
			}
			
		td.middle
			{
			vertical-align:	top;
			text-align:		center;
			width:			10%;
			}
			
		td.value
			{
			text-align:		left;
			width:			75%;
			}
			
		.editWindow 
			{
			position: 		absolute;
			visibility: 	hidden;
			left:			100px;
			top:			100px;
			}			
			
		.editInput
			{
			width:			300px;
			height:			60px;
			}
    </style>
</head>

<body onLoad="SetScreen(950,750);">

<form method="Post" action="z2t_StateMaintPost.asp" name="frm">
<input type="hidden" name="State" value="<%=strState%>">
<input type="hidden" name="EditMode" value="<%=EditMode%>">

<span class="popupHeading"><%=Title%></span>


<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td colspan="2">

			<table width="100%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td style="font-weight: bold; color: red;" colspan="3">
						Data from the z2t_StateInfo Table
					</td>
				</tr>
				
				<tr>
					<td align="right" width="15%" valign="top">
						<b>StateRate</b>
					</td>
					<td width="85%">
						<%=FormatNumber(rs("StateRate"), 2)%>
					</td>
				</tr>
				<tr>
					<td align="right" width="15%" valign="top">
						<b>UseTax</b>
					</td>
					<td width="85%">
						<%=iisNull(rs("UseTax"))%>
					</td>
				</tr>
				<tr>
					<td align="right" width="15%" valign="top">
						<b>ShippingTaxable</b>
					</td>
					<td width="85%">
						<%=iisNull(rs("ShippingTaxable"))%>
					</td>
				</tr>
				<tr>
					<td align="right" width="15%" valign="top">
						<b>LaborTaxable</b>
					</td>
					<td width="85%">
						<%=iisNull(rs("LaborTaxable"))%>
					</td>
				</tr>
				<tr>
					<td align="right" width="15%" valign="top">
						<b>LaborTaxableNotes</b>
					</td>
					<td width="85%">
						<%=iisNull(rs("LaborTaxableNotes"))%>
					</td>
				</tr>

				<tr>
					<td style="font-weight: bold; color: red;" colSpan="3">
						Data you can edit here
					</td>
				</tr>
				
				
				<% If EditMode = "Y" Then %>
					<tr height="40">
						<td align="center" valign="middle" colspan="2">
							<a class="button" href="javascript:document.frm.submit()">Submit</a> 
							&nbsp;&nbsp;
							<a class="button" href="javascript:window.close()">Close</a>
						</td>
					</tr>
					
					<%	For FieldSub = 1 to FieldCount 
							FieldName = Field(FieldSub) %>
						<tr>
							<td align="right" valign="top" width="15%">
								<b><%=FieldName%></b>
							</td>
							
							<td width="85%">
								<table border="0" cellpadding="0" cellspacing="0">
						<%	set rsDD = server.createObject("ADODB.Recordset")

							SQLDD = "SELECT * FROM z2t_Webpage_Types " & _
								"WHERE class = '" & FieldName & "' " & _
								"ORDER BY Sequence"

							rsDD.open SQLDD, connBackoffice, 2, 3

							Do Until rsDD.eof  %>
									<tr>
										<td width="1%" align="left" valign="top">
											<input type="radio" name="<%=FieldName%>" value="<%=rsDD("Value")%>"
												<%if rsDD("Value") = iisNull(rs(FieldName)) then %> Checked<%end if%>
											> 
										</td>
										<td width="1%">&nbsp;&nbsp;</td>
										<td width="98%" valign="middle">
											<%=rsDD("Description")%>
										</td>
									</tr>
									<tr height="4" />
						<%		rsDD.MoveNext
							Loop 
							
							rsDD.Close
						%>
								</table>
							</td>
						</tr>
					<%	Next %>
							
					<tr>
						<td align="center" colspan="2">
							<a class="button" href="javascript:document.frm.submit()">Submit</a> 
							&nbsp;&nbsp;
							<a class="button" href="javascript:window.close()">Close</a> 
						</td>
					</tr>
				<% Else %>
					<tr height="40">
						<td align="center" valign="middle" colspan="2">
							<a class="button" href="javascript:document.EditForm.submit()">Edit</a> 
							&nbsp;&nbsp;
							<a class="button" href="javascript:window.close()">Close</a>
						</td>
					</tr>

<%	
	For i = 1 to FieldCount - 2
%>
					<tr>
						<td align="right" valign="top" width="15%">
							<b><%=Field(i)%></b>
						</td>
							
						<td width="85%">
							<%=iisNull(rs(Field(i) & "_Text"))%>
						</td>
					</tr>
<%	
	Next
	End If
%>

            </table>

			<table width="100%" border="0" cellspacing="2" cellpadding="2">
				
<%	
	For i = 13 to FieldCount
%>
				
				<tr>
					<td class="label">
						<b><%=Field(i)%></b>
					</td>
					<td class="middle">
						<a href="javascript:clickEdit(<%=i%>);" class="buttons bo_ButtonSmall">Edit</a>
					</td>
					<td class="value">
						<%=FieldValue(i)%>
					</td>
				</tr>
				
<%	
		s = "<tr><td vAlign=""top""><input class=""editInput"" value = """ & FieldValue(i) & """></td></tr>"
		FieldEdit(i) = s
	Next
%>
			
            </table>

	</td>
  </tr>
</table>

<%  rs.Close  %>

    <div class="center" style="margin-top: 2em;">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


<div id="editWindow" class="editWindow">
	<table width="700" height="500" cellspacing="2" cellpadding="2" style="background-color:#FFFF99; border: 2px solid black;">
	  <tr vAlign="top">
	    <td align="center">
		  <span id="editWindowTitle" style="display: block;
											font-size: 14pt; 
		                                    font-weight: bold;
											border-bottom: 2px solid black;
											width: 95%;
											padding-top: 5px;
											text-align: center;">
				Edit Window Title
		  </span>
		</td>
	  </tr>
	  <tr vAlign="top">
		<td>
		  &nbsp;&nbsp;&nbsp;
		  <table border="0" cellspacing="2" cellpadding="2">
		    <span id="editWindowText">Edit Window Text</span>
		  </table>
		</td>
	  </tr>
	  <tr>
	    <td align="center">
	      <a href="javascript:clickEditApply();" class="buttons bo_Button80">Apply</a>
		  <a href="javascript:clickEditCancel();" class="buttons bo_Button80">Cancel</a>
	    </td>
	  </tr>
	</table>
</div>

	
<form method="Post" action="z2t_StateMaintEdit.asp" name="EditForm">
	<input type="hidden" name="State" value="<%=strState%>">
	<input type="hidden" name="EditMode" value="Y">
</form>

	<script language='JavaScript'>
		
		var Field = ['',  +
			<%
				For i = 1 to FieldCount
					If i <> 1 Then Response.write ", "
					Response.write "'" & Field(i) & "'"
				Next
			%>
			];
		
		var FieldEdit = ['',  +
			<%
				For i = 1 to FieldCount
					If i <> 1 Then Response.write ", "
					Response.write "'" & FieldEdit(i) & "'"
				Next
			%>
			];
	</script>

</body>
</html>
