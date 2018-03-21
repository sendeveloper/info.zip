<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/DBConstants.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/DBFunctions.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  Dim currentPage, query
  PageHeading = "Customer List"
  ColorTab = 5

  If isnull(Request("OrderBy")) or Request("OrderBy") = "" then
    OrderBy = "Expiration Date"
  Else
    OrderBy = Request("OrderBy")
  End If
  query = "&OrderBy=" & OrderBy
  ' check for page
  If Request.QueryString("Page") = "" Then
	currentPage = 1
  Else
	currentPage = Request("Page") + 1 ' convert Page request to an integer
  End If
%>
<html>
<head>
    <title>Zip2Tax.info - Customer List</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
    <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
    <style type="text/css">
        th a
        {
            color: #FFFFFF;
        }
        th a:hover
        {
            color: #E8E8E8;
        }
    </style>
</head>
<body>
  <table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">
    <!--#include virtual="/z2t_Backoffice/includes/heading.inc"-->
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr>
            <td width="100%" align="left" height="10" class="divDeskTop">
            </td>
          </tr>
          <tr>
            <td width="100%" align="left" class="divDeskMiddle">
              <%
                Dim rs, strSQL, conn
                set rs = server.createObject("ADODB.Recordset")
                Set conn = Server.CreateObject("ADODB.Connection")
                conn.Open "driver=SQL Server; server=barley2.HarvestAmerican.net; uid=davewj2o; pwd=get2it; database=z2t_WebBackoffice"
                strSQL = "SELECT [Description] FROM z2t_Types_repl WHERE [Class] = 'z2tLoginStatus' AND [Value] = '" & Request("Status") & "'"
                rs.open strSQL, connPublic, 1, 2

                if not rs.eof then
                desc = rs("Description")
                end if
                rs.close

                if Request("Status") = "(no entry)" then
                desc = "(no entry)"
                end if

                If Request("Category") = "0" Then
                  subHeading = "Customers Who Purchased A Single State Table"
                Else
                  subHeading = "Customers Who Purchased The U.S. Table"
                End If
              %>
              <table style="width: 80%; padding: 0" border="0" cellspacing="5" align="center">
                <tr>
                  <th style="color: black; font-weight: bold; font-size: 18px;" colspan="3">
                    <br /><br /><%=subHeading%>
                  </th>
                </tr>
                <tr>
                  <td width="30%">
                    &nbsp;
                  </td>
                  <td width="40%">
                    &nbsp;
                  </td>
                  <td width="30%" align="right" style="color: black; font-weight: bold; font-size: 14px;">Order By: <%=OrderBy%></td>
                </tr>
              </table>
              <table width="80%" border="0" cellspacing="1" cellpadding="3" align="center">
                <tr bgcolor="#990000">
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Harvest%20ID&Page=<%=currentPage%>" class="white">Harvest ID</a></th>
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Zip2Tax%20ID&Page=<%=currentPage%>" class="white">Zip2Tax ID</a></th>
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Customer&Page=<%=currentPage%>" class="white">Customer</a></th>
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Company&Page=<%=currentPage%>" class="white">Company</a></th>
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Email&Page=<%=currentPage%>" class="white">E-mail</a></th>
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Order%20Date&Page=<%=currentPage%>" class="white">Order Date</a></th>
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Updates&Page=<%=currentPage%>" class="white">Updates</a></th>
                  <th><a href="z2t_CustomerListTables.asp?Category=<%=Request("Category")%>&OrderBy=Notes&Page=<%=currentPage%>" class="white">Notes</a></th>
                </tr>
              <%
              Dim recordsPerPage, numOfPages, count, rsCount
              linecount = 0

              recordsPerPage = 20

              ' check for page
	          If Request.QueryString("Page") = "" Then
		        currentPage = 1
	          Else
		        currentPage = Request("Page") + 1 ' convert Page request to an integer
	          End If

              If Request("Category") <> "" Then
                query = query & "&Category=" & Request("Category")
              End If

              strSQL="z2t_Account_list_tables(" & request("Category") & ", '" & OrderBy & "')"
              
              rs.CursorType = 3
              rs.CursorLocation = 3 ' adUseClient
              rs.LockType = 3
              rs.open strSQL, connAdmin

              rs.PageSize = recordsPerPage
              rsCount = rs.RecordCount
	          numOfPages = rs.PageCount
              rs.AbsolutePage = currentPage
    
	          If Not rs.eof Then

                Do While Not rs.eof And rs.AbsolutePage = currentPage 'count <= 19

		        linecount = linecount + 1
                If linecount Mod 5 = 0 Then
                  bgcolor = "#EEEEEE"
                Else
                  bgcolor = "#FFFFFF"
                End If
              %>
                <tr bgcolor=<%=bgColor%>>
		          <td width="75" align="center"><a href="http://www.number-it.com/home/backoffice/boAccountView.asp?ID=<%=rs("ha_ID")%>" target="_new" title="Click to view account information in a new window"><%=rs("ha_ID")%></a></td>
		          <td width="75" align="center"><%=rs("z2t_ID")%></td>
		          <td width="150" align="left"><%=rs("Customer")%></td>
		          <td width="200" align="left"><%=rs("Company")%></td>
		          <td width="200" align="left"><%=rs("Email")%></td>
		          <td width="70" align="center"><%=rs("OrderDate")%></td>
		          <td width="50" align="center"><%=rs("Updates")%></td>
		          <td width="300" align="left"><%=rs("Note")%></td>
                </tr>
              <%
                  count = count + 1
                  rs.MoveNext
                Loop
              End If
              %>
                <tr bgcolor="#990000">
                  <td colspan="8">
                  <%
                  ' page nav
                  Response.write GetHitCountAndPageLinks(Request.ServerVariables("URL"), rsCount, recordsPerPage, numOfPages, currentPage - 1, query)
                  %>
                  </td>
                </tr>
              </table>
            <table width="80%" border="0" cellspacing="10" cellpadding="0" align="center">
              <tr valign="top">
                <td width="100%%" align="right" style="color: black; font-weight: bold; font-size: 14px;">
                Count: <%=LineCount%>
                </td>
              </tr> 
            </table>
          </td>
        </tr>
        <tr>
          <td width="100%" align="left" height="10" class="divDeskBottom">
          &nbsp;
          </td>
        </tr>
      </table>
    </td> 
  </tr> 
  </table>
  <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->
</body>
</html>