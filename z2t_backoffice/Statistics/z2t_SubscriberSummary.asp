<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  PageHeading = "Subscriber Summary"
  ColorTab = 5

  Dim SubscriptionPeriod(99)
  SubscriptionPeriod(0) = "Custom"
  SubscriptionPeriod(1) = "Annual"
  SubscriptionPeriod(2) = "Semi-Annual"
  SubscriptionPeriod(3) = "Quarterly"
  SubscriptionPeriod(4) = "Monthly"
  SubscriptionPeriod(99) = "Total"
%>

<html>
<head>
  <title>Zip2Tax.info - Subscriber Summary</title>
  
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
</head>

<body>
  <table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">

  <!--#include virtual="/z2t_Backoffice/includes/heading.inc"-->

    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="content">
          <tr>
            <td width="100%" align="left" height="10" class="divDeskTop"></td>
          </tr>
          <tr>
            <td width="100%" align="left" class="divDeskMiddle">
              <%
                gtActive = 0
                gtExpired = 0
                gtTotal = 0

                strSQL = "z2t_Account_summary"
                rs.open strSQL, connAdmin, 3, 3, 4

                If Not rs.EOF Then
              %>
              <table width="500" border="0" cellspacing="2" cellpadding="2" style="float: left; margin-left: 2.5em; margin-right: 5em">
                <tr>
                  <td>
                    <br /><br />
                    <h4>Subscribers (Pulled from Orders)</h4>
                  </td>
                </tr>
                <tr bgcolor="#990000">
                  <th>
                    Description
                  </th>
                  <th>
                    Period
                  </th>
                  <th>
                    Current
                  </th>
                  <th>
                    Expired
                  </th>
                  <th>
                    Total
                  </th>
                </tr>
              <%
                Do While Not rs.EOF
                  gtActive = gtActive + rs("countActive")
                  gtExpired = gtExpired + rs("countExpired")
                  gtTotal = gtTotal + rs("countTotal")
              %>
                <tr bgcolor="#FFFFFF">
		          <td align="left">
                    <%If rs("SubscriptionPeriod") = 0 Then Response.Write rs("Description") End If%>
                  </td>
		          <td align="left">
                    <%=SubscriptionPeriod(rs("SubscriptionPeriod"))%>
                  </td>
		          <td align="right">
                    <a href="z2t_CustomerList.asp?Status=<%=rs("Category")%>&Category=1"><%=rs("countActive")%></a>
                  </td>
		          <td align="right">
                    <a href="z2t_CustomerList.asp?Status=<%=rs("Category")%>&Category=2"><%=rs("countExpired")%></a>
                  </td>
		          <td align="right">
                    <a href="z2t_CustomerList.asp?Status=<%=rs("Category")%>&Category=0"><%=rs("countTotal")%></a>
                  </td>
                </tr>
              <%
                  If rs("SubscriptionPeriod") = 99 Then Response.Write "<tr><td>&nbsp;</td></tr>"
                  rs.MoveNext
                Loop
              %>
                <tr>
		          <td width="44%">&nbsp;
			        
		          </td>
		          <td width="20%" align='right'>
                    <b>Total</b>
                  </td>
		          <td width="12%" align='right'>
                    <b><a href="z2t_CustomerList.asp?Category=1"><%=gtActive%></a></b>
                  </td>
		          <td width="12%" align='right'>
                    <b><a href="z2t_CustomerList.asp?Category=2"><%=gtExpired%></a></b>
                  </td>
		          <td width="12%" align='right'>
                    <b><a href="z2t_CustomerList.asp?Category=0"><%=gtTotal%></a></b>
                  </td>
                </tr>
              </table>
              <%
                End If

                Dim rs, strSQL: Set rs = Server.CreateObject("ADODB.Recordset")
                strSQL = "z2t_Account_summary_tables"
                rs.Open strSQL, connAdmin, 3, 3, 4

                If not rs.EOF Then
              %>
              <table width="500" border="0" cellspacing="2" cellpadding="2" style="float: right; margin-right: 2.5em">
                <tr colspan="4">
                  <td>
                    <br /><br />
                    <h4>Table Sales (Pulled from Orders)</h4>
                  </td>
                </tr>
                <tr bgcolor="#990000">
                  <th>
                    Description
                  </th>
                  <th>
                    Tables
                  </th>
                  <th>
                    Customers
                  </th>
                  <th>
                    Updated
                  </th>
                </tr>
              <%
                gtTables = gtTables + rs("SingleStateTables") + rs("EntireUSTables")
                gtCustomers = gtCustomers + rs("SingleStateCustomers") + rs("EntireUSCustomers")
                gtUpdates = gtUpdates + rs("SingleStateUpdates") + rs("EntireUSUpdates")
              %>
                <tr bgcolor="#FFFFFF">
		          <td align="left">
                    Individual States
                  </td>
		          <td align="right">
                    <%=rs("SingleStateTables")%>
                  </td>
		          <td align="right">
                    <a href="z2t_CustomerListTables.asp?Category=0"><%=rs("SingleStateCustomers")%></a>
                  </td>
		          <td align="right">
                    <%=rs("SingleStateUpdates")%>
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td align="left">
                    Entire US
                  </td>
		          <td align="right">
                    <%=rs("EntireUSTables")%>
                  </td>
		          <td align="right">
                    <a href="z2t_CustomerListTables.asp?Category=1"><%=rs("EntireUSCustomers")%></a>
                  </td>
		          <td align="right">
                    <%=rs("EntireUSUpdates")%>
                  </td>
                </tr>
              <%
              rs.close
              %>
                <tr>
		          <td width="220" align="right">
                    <b>Total</b>
                  </td>
		          <td width="60" align="right">
                    <b><%=gtTables%></b>
                  </td>
		          <td width="60" align="right">
                    <b><%=gtCustomers%></b>
                  </td>
		          <td width="60" align="right">
                    <b><%=gtUpdates%></b>
                  </td>
                </tr>
              </table>
              <%
                End If

                gtTables = 0
                gtCustomers = 0

                strSQL = "z2t_Account_summary_tables_updates"
                rs.open strSQL, connAdmin, 3, 3, 4

                gtTables = 0
                gtUpdates = 0
                gtDeclines = 0

                If Not rs.EOF Then
                  gtTables = gtTables + rs("SingleStateTableCustomers") + rs("EntireUSTableCustomers")
                  gtUpdates = gtUpdates + rs("SingleStateUpdateCustomers") + rs("EntireUSUpdateCustomers")
                  gtDeclines = gtDeclines + rs("SingleStateUpdateDeclinesNull") + rs("EntireUSUpdateDeclinesNull")
              %>
              <table width="500" border="0" cellspacing="2" cellpadding="2" style="float: right; margin-top: 5em; margin-right: 2.5em">
                <tr>
                  <td colspan="4">
                    <br /><br />
                    <h4>Table Update Prospects (Pulled from Zip2Tax Products)</h4>
                  </td>
                </tr>
                <tr bgcolor="#99000">
                  <th>
                  Description
                  </th>
                  <th>
                  Customers Purchased Tables
                  </th>
                  <th>
                  Customers Purchased Updates
                  </th>
                  <th>
                  Haven't Declined Updates
                  </th>
                </tr>
                <tr bgcolor="#FFFFFF">
		          <td align="left">
                    Individual States
                  </td>
		          <td align="right">
                    <%=rs("SingleStateTableCustomers")%>
                  </td>
		          <td align="right">
                    <%=rs("SingleStateUpdateCustomers")%>
                  </td>
		          <td align="right">
                    <%=rs("SingleStateUpdateDeclinesNull")%>
                  </td>
                </tr>
		        <tr bgcolor="#FFFFFF">
		          <td align="left">
                    Entire US
                  </td>
		          <td align="right">
                    <%=rs("EntireUSTableCustomers")%>
                  </td>
		          <td align="right">
                    <%=rs("EntireUSUpdateCustomers")%>
                  </td>
		          <td align="right">
                    <%=rs("EntireUSUpdateDeclinesNull")%>
                  </td>
                </tr>
                <tr>
		          <td width="220" align="right">
                    <b>Total</b>
                  </td>
		          <td width="60" align="right">
                    <b><%=gtTables%></b>
                  </td>
		          <td width="60" align="right">
                    <b><%=gtUpdates%></b>
                  </td>
		          <td width="60" align="right">
                    <b><%=gtDeclines%></b>
                  </td>
                </tr>
              </table>
              <%
                End If
                rs.close
              %>
            </td>
          </tr>
          <tr>
            <td width="100%" align="left" height="10" class="divDeskBottom">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->
</body>
</html>
