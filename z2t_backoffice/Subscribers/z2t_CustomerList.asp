<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/DBConstants.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/DBFunctions.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  PageHeading = "Customer List"
  ColorTab = 5

  If isnull(Request("OrderBy")) or Request("OrderBy") = "" then
    OrderBy = "Expiration Date"
  Else
    OrderBy = Request("OrderBy")
  End If
  
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
    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" typZip2Tax.info - Customer List</title>
</title>
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
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->              
  <%
                Dim rs, strSQL, conn
                set rs = server.createObject("ADODB.Recordset")
                Set conn = Server.CreateObject("ADODB.Connection")
                conn.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_Backoffice"
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
                  <td width="30%">&nbsp;
                    
                  </td>
                  <td width="40%">&nbsp;
                    
                  </td>
                  <td width="30%" align="right" style="color: black; font-weight: bold; font-size: 14px;">Order By:   <%
				   
                         						
		              select case Request("Status")
		              case "update"
                    %>
                    <!--Monthly Tax Table Update Layout-->
                    <table width="80%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr bgcolor="#990000">
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Zip2Tax%20ID&Page=<%=currentPage%>" class="white">Zip2Tax ID</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Harvest%20ID&Page=<%=currentPage%>" class="white">Harvest ID</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Company&Page=<%=currentPage%>" class="white">Company</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Email&Page=<%=currentPage%>" class="white">E-mail Updates To</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=State%20List&Page=<%=currentPage%>" class="white">State List</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Table%20Type&Page=<%=currentPage%>" class="white">Table Type</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=NY%20Clothing&Page=<%=currentPage%>" class="white">NY Clothing</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Notes&Page=<%=currentPage%>" class="white">Notes</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Expiration%20Date&Page=<%=currentPage%>" class="white">Expiration Date</a>
                        </th>
                        <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Auto%20Renew&Page=<%=currentPage%>" class="white">Auto Renew</a>
                         
                        </th>
                      </tr>
                      <%
                        Dim recordsPerPage, numOfPages, currentPage, count, rsCount

                        recordsPerPage = 20

                        If Request("Category") <> "" Then
                        query = "&Category=" & Request("Category")
                        End If

                        If Request("Status") <> "" Then
                        query = query & "&Status=" & Request("Status")
                        End If
                        linecount = 0
  
                        strSQL="z2t_BackOffice.dbo.z2t_Account_list('" & request("Status") & "', " & request("Category") & ", '" & OrderBy & "')"
						'response.Write(strSQL)
                        rs.CursorType = 3
                        rs.CursorLocation = 3 ' adUseClient
                        rs.LockType = 3
						
                        rs.open strSQL, connPublic
        
                        rs.PageSize = recordsPerPage
                        rsCount = rs.RecordCount
	                    numOfPages = rs.PageCount
                        rs.AbsolutePage = currentPage

	                    if not rs.eof then
                          do while not rs.eof and rs.AbsolutePage = currentPage

		                    linecount = linecount + 1
                            if linecount mod 5 = 0 then
                            bgcolor = "#EEEEEE"
                            else
                            bgcolor = "#FFFFFF"
                            end if
                      %>
                      <tr bgcolor="<%=bgColor%>">
                        <td width='50' align='center'>
                        <%=rs("z2t_ID")%>
                        </td>
                        <td width='75' align='center'>
                        <a href="http://crm.harvestamerican.info/Accounts/crm_AccountView/crm_AccountView.asp?ID=<%=rs("ha_ID")%>"
                        target="_new" title="Click to view account information in a new window">
                        <%=rs("ha_ID")%></a>
                        </td>
                        <td width='270' align='left'>
                        <%=rs("Company")%>
                        </td>
                        <td width='225' align='left'>
                        <%=rs("Email")%>
                        <% If Len(rs("Email2")) > 0 then %>
                        <br>
                        <%=rs("Email2")%>
                        <%
                          End If
                          If Len(rs("Email3")) > 0 then 
                        %>
                        <br>
                        <%=rs("Email3")%>
                        <% End If %>
                        </td>
                        <td width='225' align='left'>
                        <%=rs("StateList")%>
                        </td>
                        <td width='140' align='center'>
                        <%
	                      IF rs("TableTypeDesc") = "Sales Tax Table - Breakout Version" THEN
                        %>
                        <span style="color: #888888;">
                        <%=rs("TableTypeDesc")%></span>
                        <%
	                      ELSE
                        %>
                        <%=rs("TableTypeDesc")%>
                        <%
	                      END IF
                        %>
                        </td>
                        <td width='90' align='center'>
                        <%
                          IF rs("NYClothing") = 1 THEN
 	                        response.write("Yes")
                          ELSE
 	                        response.write("")
                          END IF
                        %>
                        </td>
                        <td width='200' align='left'>
                        <%=rs("Notes")%>
                        </td>
                        <td width='100' align='right'>
                        <%=rs("Expiration")%>
                        </td>
                        <td width='70' align='center'>
                        <%=rs("AutoRenew")%>
                        </td>
                      </tr>
                      <%
                        count = count + 1
                        rs.MoveNext
                      loop
                    end if
                      %>
                      <tr bgcolor="#990000">
                          <td colspan="10">
                        <%
                          ' page nav
                          Response.write GetHitCountAndPageLinks(Request.ServerVariables("URL"), rsCount, recordsPerPage, numOfPages, currentPage - 1, query)
                        %>
                          </td>
                        </tr>
                    </table>
                    <!--End Monthly Tax Table Update Layout-->
                      <%
		                case "link"
                      %>
                      <!--Database Link Layout-->
                      <table width="80%" border="0" cellspacing="1" cellpadding="3" align="center">
                        <tr bgcolor='#990000'>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Zip2Tax%20ID&Page=<%=currentPage%>" class="white">Zip2Tax ID</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Harvest%20ID&Page=<%=currentPage%>" class="white">Harvest ID</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Customer&Page=<%=currentPage%>" class="white">Customer</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Company&Page=<%=currentPage%>" class="white">Company</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Stored%20Procedure&Page=<%=currentPage%>" class="white">Stored Procedure</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Notes&Page=<%=currentPage%>" class="white">Notes</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Expiration%20Date&Page=<%=currentPage%>" class="white">Expiration Date</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Auto%20Renew&Page=<%=currentPage%>" class="white">Auto Renew</a>
                          </th>
                        </tr>
                      <%
                        linecount = 0

                        recordsPerPage = 20

                        If Request("Category") <> "" Then
                        query = "&Category=" & Request("Category")
                        End If

                        If Request("Status") <> "" Then
                        query = query & "&Status=" & Request("Status")
                        End If
                        linecount = 0
  
                        strSQL="z2t_Account_list('" & request("Status") & "', " & request("Category") & ", '" & OrderBy & "')"
                        rs.CursorType = 3
                        rs.CursorLocation = 3 ' adUseClient
                        rs.LockType = 3
						
                        rs.open strSQL, connPublic
                        'rs.open strSQL, connAdmin
        
                        rs.PageSize = recordsPerPage
                        rsCount = rs.RecordCount
	                    numOfPages = rs.PageCount
                        rs.AbsolutePage = currentPage

	                      if not rs.eof then
                            do while not rs.eof and rs.AbsolutePage = currentPage

                    		  linecount = linecount + 1
                              if linecount mod 5 = 0 then
                                bgcolor = "#EEEEEE"
                              else
                                bgcolor = "#FFFFFF"
                              end if
                        %>
                        <tr bgcolor="<%=bgColor%>">
                          <td width='75' align='center'><%=rs("z2t_ID")%></td>
                          <td width='75' align='center'><a href="http://crm.harvestamerican.info/Accounts/crm_AccountView/crm_AccountView.asp?ID=<%=rs("ha_ID")%>" target="_new" title="Click to view account information in a new window"><%=rs("ha_ID")%></a></td>
                          <td width='150' align='left'><%=rs("Customer")%></td>
                          <td width='250' align='left'><%=rs("Company")%></td>
                          <td width='175' align='left'><%=rs("StoredProcedure")%></td>
                          <td width='200' align='left'><%=rs("Notes")%></td>
                          <td width='100' align='right'><%=rs("Expiration")%></td>
                          <td width='70' align='center'><%=rs("AutoRenew")%></td>
                        </tr>
                        <%
                          rs.MoveNext
                          loop
                        end if
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
                      <!--End Database Link Layout-->
                      <%
		                case else
                      %>
                      <!--Web Lookup Layout-->
                      <table width="80%" border="0" cellspacing="1" cellpadding="3" align="center">
                        <tr bgcolor='#990000'>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Zip2Tax%20ID&Page=<%=currentPage%>" class="white">Zip2Tax ID</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Harvest%20ID&Page=<%=currentPage%>" class="white">Harvest ID</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Customer&Page=<%=currentPage%>" class="white">Customer</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Company&Page=<%=currentPage%>" class="white">Company</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Login&Page=<%=currentPage%>" class="white">Login</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Password&Page=<%=currentPage%>" class="white">Password</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Notes&Page=<%=currentPage%>" class="white">Notes</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Expiration%20Date&Page=<%=currentPage%>" class="white">Expiration Date</a>
                          </th>
                          <th>
                          <a href="z2t_CustomerList.asp?Status=<%=Request("Status")%>&Category=<%=Request("Category")%>&OrderBy=Auto%20Renew&Page=<%=currentPage%>" class="white">Auto Renew</a>
                          </th>
                        </tr>
                      <%
    
                        linecount = 0

                        recordsPerPage = 20

                        If Request("Category") <> "" Then
                        query = "&Category=" & Request("Category")
                        End If

                        If Request("Status") <> "" Then
                        query = query & "&Status=" & Request("Status")
                        End If
                        linecount = 0
  
                        strSQL="z2t_Account_list('" & request("Status") & "', " & request("Category") & ", '" & OrderBy & "')"
                        rs.CursorType = 3
                        rs.CursorLocation = 3 ' adUseClient
                        rs.LockType = 3						
                        rs.open strSQL, connPublic
                        'rs.open strSQL, connAdmin
        
                        rs.PageSize = recordsPerPage
                        rsCount = rs.RecordCount
	                    numOfPages = rs.PageCount
                        rs.AbsolutePage = currentPage
    
	                      if not rs.eof then
                            do while not rs.eof and rs.AbsolutePage = currentPage

		                      linecount = linecount + 1
                              if linecount mod 5 = 0 then
                                bgcolor = "#EEEEEE"
                              else
                                bgcolor = "#FFFFFF"
                              end if
                        %>
                        <tr bgcolor="<%=bgColor%>">
                          <td width='75' align='center'><%=rs("z2t_ID")%></td>
                          <td width='75' align='center'><a href="http://crm.harvestamerican.info/Accounts/crm_AccountView/crm_AccountView.asp?ID=<%=rs("ha_ID")%>" target="_new" title="Click to view account information in a new window"><%=rs("ha_ID")%></a></td>
                          <td width='150' align='left'><%=rs("Customer")%></td>
                          <td width='250' align='left'><%=rs("Company")%></td>
                          <td width='100' align='left'><%=rs("Login")%></td>
                          <td width='100' align='left'><%=rs("Pwd")%></td>
                          <td width='200' align='left'><%=rs("Notes")%></td>
                          <td width='90' align='right'><%=rs("Expiration")%></td>
                          <td width='70' align='center'><%=rs("AutoRenew")%></td>
                        </tr>
                        <%
                              rs.MoveNext
                            loop
                          end if
                        %>
                        <tr bgcolor="#990000">
                          <td colspan="9">
                        <%
                          ' page nav
                          Response.write GetHitCountAndPageLinks(Request.ServerVariables("URL"), rsCount, recordsPerPage, numOfPages, currentPage - 1, query)
                        %>
                          </td>
                        </tr>
                      </table>
                      <!--End Web Lookup Layout-->
                      <%
			            end select
                      %>
                  <table width="80%" border="0" cellspacing="10" cellpadding="0" align="center">
                    <tr valign="top">
                      <td width="100%%" align="right" style="color: black; font-weight: bold; font-size: 14px;">
                        Count: <%=LineCount%>
                      </td>
                    </tr> 
                  </table>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/footer.inc"-->
  </body>
</html>
