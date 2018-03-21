<%
        Title = "State Phone Numbers"
%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="/z2t_BackOffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
	
	<style type="text/css">   
		.separatorLine
			{
			}
									
		.separatorLine hr
			{
			margin: 0;
			}
			
		.separatorLine td
			{
			//border: 1px solid green;
			line-height: 2px;
			}
			
		td 
			{
			font-size: 9pt;
			}
			
		th
			{
			font-weight: bold;
			font-size: 10pt;
			text-align: center;
			border-bottom: 1px solid black;
			}
	</style>

</head>


<body onLoad="SetScreen(900,850);">
  <form method="Post" action="z2t_StatePhoneNumbers_post.asp?State=<%=Request("State")%>" name="frm">

	  <span class="popupHeading"><%=Title%></span>

	  <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
                <tr>
				  <th colspan="2">
				    State
				  </th>
				  <th>
				    Phone
				  </th>
				  
				  <td>
				    &nbsp;
				  </td>
				  
				  <th colspan="2">
				    State
				  </th>
				  <th>
				    Phone
				  </th>
				</tr>

<%			  
	Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
	Dim rs: Set rs=server.createObject("ADODB.Recordset")
	
	connPhilly01.Open "driver=SQL Server;server=10.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables" ' philly01
    strSQL = "z2t_StateInfo_Phones_list"
    rs.open strSQL, connPhilly01, 3, 3, 4

		If Not rs.EOF Then
			Do While Not rs.EOF
				Linecount = Linecount + 1
				If LineCount > 3 Then
%>
				<div><tr Class="separatorLine"><td colspan="3"><hr></td><td>&nbsp;</td><td colspan="3"><hr></td></tr></div>
<%
					LineCount = 1
				End If 
%>
			  
                <tr>
                  <td width="5%" align="center">
				    <%=rs("StateAbbr1")%>
                  </td>
                  <td width="22%">
				    <%=rs("StateName1")%>
                  </td>
                  <td width="21%" align="right">
				    <%=rs("StatePhone1")%>
                  </td>
				  
                  <td width="4%">
				    &nbsp;
                  </td>
				  
                  <td width="5%" align="center">
				    <%=rs("StateAbbr2")%>
                  </td>
                  <td width="22%">
				    <%=rs("StateName2")%>
                  </td>
                  <td width="21%" align="right">
				    <%=rs("StatePhone2")%>
                  </td>
                </tr>
				
<%
				rs.MoveNext
			Loop
		End If
		rs.Close
%>
						
			<tr><td>&nbsp;</td></tr>
						
	  </table>
  </form>
</body>
</html>
