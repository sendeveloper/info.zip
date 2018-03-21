<%
	Response.buffer=true
	Response.clear
	Dim strMessage
	Dim strMode
	
	Response.Write(Request.Form("Origin"))
%>

<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/functions.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<html>
<head>
    <title>Zip2Tax State Maintenance Options Edit</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
    <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
    <link href="/z2t_Backoffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">

	<script language="JavaScript" type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	

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
    </style>
</head>

    <%
	Dim rs, rsDD
	Dim SQL, SQLDD
	Dim strState
	Dim EditMode
	
    If Request("State")="" or IsNull(Request("State")) Then
		Close
	Else
		strState = Request("State")
    End If

    If IsNull(Request("EditMode")) or UCase(Request("EditMode")) <> "Y" Then
		EditMode = ""
	Else
		EditMode = "Y"
    End If

	Set rs = server.createObject("ADODB.Recordset")


	SQL="z2t_StateMaintenancePage_read '" & strState & "'"

	Dim Field(12)
	Dim FieldCnt
	Dim FieldSub
	Dim FieldName
	
	FieldCnt = 12
	
	Field(1) = "Jurisdictions"
	Field(2) = "UseTaxBase"
	Field(3) = "Shipping"
	Field(4) = "Origin"
	Field(5) = "Source"
	Field(6) = "Clothing"
	Field(7) = "NexusDef"
	Field(8) = "Nexus"
	Field(9) = "Finance"
	Field(10) = "Installation"
	Field(11) = "Contact"
	Field(12) = "Holiday"
	
	rs.open SQL, connPhilly01PublishTables, 2, 3



	Title = "State Page Maintenance Options - " & Rs("StateFullName") & "(" & strState & ")"
		%>

<body onLoad="SetScreen(850,750);">

<form method="Post" action="z2t_StateMaintenanceOptions_Post.asp" name="frm">
<input type="hidden" name="State" value="<%=strState%>">
<input type="hidden" name="EditMode" value="<%=EditMode%>">

	  <span class="popupHeading"><%=Title%></span>


<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td colspan="2">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td>

			<table width="100%" border="0" cellspacing="10" cellpadding="0" align="center">
				<tr>
					<td style="color: #888888; font-weight: bold; font-size: 10pt; padding-bottom: 10px;" colspan="2">
						This data comes from the z2t_StateInfo table. You can edit this data on the Research >> State Information page.
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

				<% If EditMode = "Y" Then %>
				
					<tr>
						<td style="color: #888888; font-weight: bold; font-size: 10pt; padding-bottom: 10px;" colspan="2">
							These options you can edit here. (z2t_StateInfo_Website table)
						</td>		 
					</tr>
					
					<%	For FieldSub = 1 to FieldCnt 
							FieldName = Field(FieldSub) %>
						<tr>
							<td align="right" valign="top" width="15%">
								<b><%=FieldName%></b>
							</td>
							
							<td width="85%">
								<table border="0" cellpadding="0" cellspacing="0">

									<tr>
										<td width="1%" align="left" valign="top">
									    <select id="<%=FieldName%>" name="<%=FieldName%>" style="min-width:200px;max-width:500px" >
										<%	set rsDD = server.createObject("ADODB.Recordset")
            
                                        SQLDD = "SELECT * FROM z2t_Types " & _
                                            "WHERE class = 'StatePageVariables_" & FieldName & "' " & _
                                            "ORDER BY Sequence"
						                rsDD.open SQLDD, connPhilly01PublishTables, 2, 3
                                            
                                        Do Until rsDD.eof  %>
											<option title="<%=rsDD("Description")%>" value="<%=rsDD("Value")%>"
												<%if rsDD("Value") = iisNull(rs(FieldName)) then %> selected<%end if%>>
													<%=rsDD("Description")%>
                                             </option> 
                   						<%		rsDD.MoveNext
												Loop 
												rsDD.Close
											%>	    
                                        </select>
										</td>
										<td width="1%">&nbsp;&nbsp;</td>
										<td width="98%" valign="middle">
											
										</td>
									</tr>
									<tr height="4" />


								</table>
							</td>
						</tr>
					<%	Next %>
							
					<tr>
						<td align="center" colspan="2">
							<a class="buttons bo_Button80" href="javascript:document.frm.submit()">Submit</a> 
							&nbsp;&nbsp;
							<a class="buttons bo_Button80" href="z2t_StateMaintenanceOptions_Edit.asp?State=<%=strState%>">Cancel</a>
						</td>
					</tr>
				<% Else %>
					
					<tr>
						<td style="color: #888888; font-weight: bold; font-size: 10pt; padding-bottom: 10px;" colspan="2">
							These options you can edit here. (z2t_StateInfo_Website table)
						</td>		 
					</tr>
										
					<%	For FieldSub = 1 to FieldCnt 
							FieldName = Field(FieldSub) 
							
					%>
					<%	set rsDD = server.createObject("ADODB.Recordset")
						if iisNull(rs(FieldName) ) ="" then 
							rs(FieldName)=0
						end if
						
						
						
                        SQLDD = "SELECT * FROM z2t_Types " & _
                            "WHERE class = 'StatePageVariables_" & FieldName & "' " & _
							" And value="& iisNull(rs(FieldName)) & _
                            "ORDER BY Sequence"
						'	response.Write(SQLDD)
                        rsDD.open SQLDD, connPhilly01PublishTables, 2, 3
                            
                        Do Until rsDD.eof  %>
						<tr>
							<td align="right" valign="top" width="15%">
								<b><%=FieldName%></b>
							</td>
							
							<td width="85%">
								<%=rsDD("Description")%>
							</td>
						</tr>
						<%		rsDD.MoveNext
                                Loop 
                                rsDD.Close
                            %>	    
					<%	Next %>

					
					<tr>
						<td align="center" valign="middle" colspan="2">
							<a class="buttons bo_Button80" href="javascript:document.EditForm.submit()">Edit</a> 
							&nbsp;&nbsp;
							<a class="buttons bo_Button80" href="javascript:window.close()">Cancel</a> 
						</td>
					</tr>

				<% End If %>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<%'  rs.Close  %>

<form method="Post" action="z2t_StateMaintenanceOptions_Edit.asp" name="EditForm">
	<input type="hidden" name="State" value="<%=strState%>">
	<input type="hidden" name="EditMode" value="Y">
</form>

</body>
</html>
