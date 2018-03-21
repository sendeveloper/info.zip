<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  PageHeading = "Subscriber Table Types"
  ColorTab = 5
%>

<!DOCTYPE html>
<html>
  <head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  
  <style>
    .on-desk {margin-left: 5em; margin-right: auto; display: inline-block; white-space: nowrap; vertical-align: top;}
    .download-xlsx {display: block; margin-left: 10em; margin-right: auto; margin-top: 1em;}

    .subscribers {display: inline-block;}
    .on-desk * {white-space: normal;}
    .subscribers table.resultset th {font-size: 150%;}
    .subscribers table.resultset td {padding-left: 2em; text-align: right; font-size: 150%;}
    .subscribers table.resultset td:first-child {padding-left: 0em; text-align: left;}

    .bob-note {display: inline-block; vertical-align: top; margin-top: 5em; width: 30%;}
  </style>
  
  </head>
  
<body>
  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->
    
	  
        <%
			Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
			Dim rs: Set rs=server.createObject("ADODB.Recordset")
			connPhilly05.Open "driver=SQL Server;server=localhost;uid=davewj2o;pwd=get2it;database=z2t_BackOffice" ' philly05
            strSQL = "z2t_TableTypesCount"
            rs.open strSQL, connPhilly05, 3, 3, 4

            Dim t1, t2, t3, t4
			
			If Not rs.EOF Then
        %>
              <table width="500" border="0" cellspacing="2" cellpadding="2" style="float: left; margin-left: 2.5em; margin-right: 5em">
                <tr>
                  <td colspan="5">

                    <h4>Table Customer Counts by Table Type</h4>
                  </td>
                </tr>
				
                <tr bgcolor="#990000">
                  <th>&nbsp;
                    
                  </th>
                  <th colspan="2">
                    Sales Tax
                  </th>
                  <th colspan="2">
                    Use Tax
                  </th>
                </tr>
				
                <tr bgcolor="#990000">
                  <th>
                    Table Type
                  </th>
                  <th>
                    Initial
                  </th>
                  <th>
                    Update
                  </th>
                  <th>
                    Initial
                  </th>
                  <th>
                    Update
                  </th>
                </tr>
				
              <%
                Do While Not rs.EOF
				  If not isnull(rs("totalInitialSales")) Then t1 = t1 + rs("totalInitialSales") End If
				  If not isnull(rs("totalUpdateSales"))  Then t2 = t2 + rs("totalUpdateSales")  End If
				  If not isnull(rs("totalInitialUse"))   Then t3 = t3 + rs("totalInitialUse")   End If
				  If not isnull(rs("totalUpdateUse"))    Then t4 = t4 + rs("totalUpdateUse")    End If
              %>
			  
                <tr bgcolor="#FFFFFF">
		          <td align="left">
                    <%=rs("ShortName")%>
                  </td>
		          <td align="right">
                    <%=DisplayNumber(rs("totalInitialSales"))%>
                  </td>
		          <td align="right">
                    <%=DisplayNumber(rs("totalUpdateSales"))%>
                  </td>
		          <td align="right">
                    <%=DisplayNumber(rs("totalInitialUse"))%>
                  </td>
		          <td align="right">
                    <%=DisplayNumber(rs("totalUpdateUse"))%>
                  </td>
                </tr>
              <%
                  rs.MoveNext
                Loop
              %>
                <tr>
		          <td width="40%" align='right'>
                    <b>Total</b>
                  </td>
		          <td width="15%" align='right'>
                    <b><%=DisplayNumber(t1)%></b>
                  </td>
		          <td width="15%" align='right'>
                    <b><%=DisplayNumber(t2)%></b>
                  </td>
		          <td width="15%" align='right'>
                    <b><%=DisplayNumber(t3)%></b>
                  </td>
		          <td width="15%" align='right'>
                    <b><%=DisplayNumber(t4)%></b>
                  </td>
                </tr>
				
				<tr><td>&nbsp;</td></tr>
				
              </table>
              <%
                End If
				rs.Close
			  %>
  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
  </body>
</html>

<%
  Function DisplayNumber(n)
	If isnull(n) Then
		DisplayNumber = ""
	Else
        DisplayNumber = FormatNumber(n,0)
	End If
  End Function
%>


