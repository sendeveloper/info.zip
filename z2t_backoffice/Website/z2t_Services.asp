
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  dim strColor
  dim PageHeading
  dim recordCount
  dim StateAbbr(100)
  dim StateName(100)

  PageHeading = "Zip2Tax Services"
  ColorTab = 6

  '----- Be sure secure path is used -----


  sqlText="z2t_Services_list"

  set RS=server.createObject("ADODB.Recordset")
  RS.open sqlText, connBackoffice, 3, 3, 4

%>

<html>
<head>
  <title><%=PageHeading%></title>

  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

  <script type="text/javascript" src="../includes/lib.js"></script>
  <script>
  </script>
  
  <style type="text/css">
  
	th
		{
		color:			black;
		border-bottom:	1px solid black;
		}
  </style>

</head>

<body>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
  <tr><td>
        <table width="95%" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">
        <tr valign="top">
		  <th width="15%" align="left">Service</th>
		  <td width="1%">&nbsp;</td>
<%
	For i = 2 to rs.Fields.count - 1
		w = cInt(85/rs.Fields.count - 2)
		Response.write "<th width='" & cStr(w) & "%' align='center'>" & rs.Fields(i).Name & "</th>"
	Next
%>
		
        </tr>
	
<%
	Do while not rs.eof
		rowCount = rowCount + 1
		If rowCount mod 3 = 0 Then 
			uline = " style='border-bottom: 1px solid #C0C0C0;'"
		Else
			uline = ""
		End If
		Response.write "<tr><td" & uline & ">" & rs.Fields(1).Value & "</td><td>&nbsp;</td>"
		For i = 2 to rs.Fields.count - 1
			Response.write "<td align='center'" & uline & ">" & rs.Fields(i).Value & "</td>"
		Next
		Response.write "</tr>"
		rs.MoveNext
	Loop
	rs.close
%>
        
      </table>
</td></tr>

  <!--#include virtual="z2t_Backoffice/includes/BodyParts/footer.inc"-->
  </body>
</html>
