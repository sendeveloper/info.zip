<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<%
  PageHeading = "State Phone Numbers"
  ColorTab = 3
%>

<html>
<head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  
  <script language='JavaScript'>
		
	function clickEdit(st)
		{
		var URL = 'z2t_StatePhoneNumbers_edit.asp' +
			'?State=' + st;
		openPopUp(URL);
		}
				
	function clickPrint()
		{
		var URL = 'z2t_StatePhoneNumbers_print.asp';
		openPopUp(URL);
		}
		
  </script>
  
  <style type="text/css">   
    .stateList td 
		{
		font-size: 10pt;
		background-color: white;
		}
		
    .stateList th
		{
		color: white;
		font-weight: bold;
		font-size: 10pt;
		text-align: center;
		background-color: #990000;
		}
  </style>
  
</head>

<body>
  <!--#include virtual="/z2t_Backoffice/includes/bodyParts/header.inc"-->
			  <table width="90%" border="0" cellspacing="2" cellpadding="2" align="center">
				<tr valign="top">
				  <tr><td>&nbsp;</td></tr>
				  <td style="font-size: 12pt;">
					Here is a list of states with the phone number to use for Sales Tax Information within that state.<br><br>
				  </td>
	              <td align="right">
	                <a href="javascript:clickPrint();" class="button90">Print Version</a>
                  </td>
				</tr>
			  </table>

			  <table width="90%" align="center" border="0" cellspacing="2" cellpadding="2" class="stateList">
			  
                <tr>
				  <th colspan="2">
				    State
				  </th>
				  <th>
				    Phone
				  </th>
				  <th>&nbsp;
				    
				  </th>
				  <th style="background-color:transparent;">&nbsp;
				    
				  </th>
				  <th colspan="2">
				    State
				  </th>
				  <th>
				    Phone
				  </th>
				  <th>&nbsp;
				    
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
%>
			  
                <tr>
                  <td align="center">
				    <%=rs("StateAbbr1")%>
                  </td>
                  <td>
				    <%=rs("StateName1")%>
                  </td>
                  <td align="right">
				    <%=rs("StatePhone1")%>
                  </td>
	              <td align="center">
	                <a href="javascript:clickEdit('<%=rs("StateAbbr1")%>');" class="button40">Edit</a>
                  </td>
				  
                  <td width="180px" style="background-color:transparent;">&nbsp;
				    
                  </td>
				  
                  <td align="center">
				    <%=rs("StateAbbr2")%>
                  </td>
                  <td>
				    <%=rs("StateName2")%>
                  </td>
                  <td align="right">
				    <%=rs("StatePhone2")%>
                  </td>
	              <td align="center">
<%	If rs("StateAbbr2") > "" Then %>
	                <a href="javascript:clickEdit('<%=rs("StateAbbr2")%>');" class="button40">Edit</a>
<%  Else  %>
					&nbsp;
<%	End If %>
                  </td>
                </tr>
				
<%
				rs.MoveNext
			Loop
		End If
		rs.Close
%>
				
              </table>
			  <table width="100%" border="0" cellspacing="5" cellpadding="5">
				<tr><td>&nbsp;</td></tr>
			  </table>
			  
             <!--#include virtual="/z2t_Backoffice/includes/bodyParts/Footer.inc"-->

</body>
</html>
