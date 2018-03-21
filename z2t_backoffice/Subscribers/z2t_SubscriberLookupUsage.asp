<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/ColumnHeadingFunction.inc"-->

<%  
  PageHeading = "Subscriber Lookup Usage"
  ColorTab = 5

  Dim adOpenForwardOnly: adOpenForwardOnly = 0
  Dim adLockBatchOptimistic: adLockBatchOptimistic = 4

	Dim strYear
	Dim strMonth
	Dim strDate
	Dim strPage
	Dim MaxYear
	Dim MaxMonth
	Dim MaxDate
	Dim ForPrinting
	Dim OrderBy
	Dim AscDesc
	Dim AscDescSQL
	Dim SortFields

	set objRS = Server.CreateObject("ADODB.Recordset")
	objRS.CursorLocation = 3

	strSQL = "SELECT Top 1 ActivityYear, ActivityMonth " & _
	         "FROM z2t_AggregateActivityLookupsBy_All " & _
	         "ORDER BY ActivityYear desc, ActivityMonth desc "

	objRS.open strSQL, connBackoffice, 2, 3

	MaxYear = objRS("ActivityYear")
	MaxMonth = objRS("ActivityMonth")

	objRS.close
	
	If isnull(Request("year")) or Request("year") = "" then
		strYear = MaxYear
	Else
		strYear = Request("year")
	End If

	If isnull(Request("month")) or Request("month") = "" then
		strMonth = MaxMonth
	Else
		strMonth = Request("month")
	End If
	
	strDate = strMonth & "/1/" & strYear
	MaxDate = MaxMonth & "/1/" & MaxYear
	
	If isnull(Request("forPrinting")) or Request("forPrinting") <> "True" then
		ForPrinting = False
	Else
		ForPrinting = True
	End If
	
	If isnull(Request("page")) or Request("page") = "" then
		strPage = 0
	Else
		strPage = Request("page")
	End If
	
	HarvestURL="http://crm.harvestamerican.info/Accounts/crm_AccountView/crm_AccountView.asp"
%>

	<!--#include virtual='z2t_Backoffice/includes/DBConstants.inc'-->
	<!--#include virtual='z2t_Backoffice/includes/DBFunctions.asp'-->

<html>
<head>
    <title>Zip2Tax.info - Subscriber Lookup Usage</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" media="screen" />
	<style type="text/css" media="screen">
		table.z2tdata td a{display: block;}   /* Enlarge the tiny links, by making the entire cell clickable */

		td.white
			{
			font-family: Arial, Helvetica, sans-serif; 
			font-size: 12px; 
			font-weight: bold; 
			color: white;
			}
	</style>
    <% If ForPrinting Then %>
      <style type="text/css">
        body, .divDeskTop, .divDeskMiddle, .divDeskBottom
			  { background:url();
				background-color: white; }
		th {color: black;}
		.white {color: black;}
		a.white {color: black;}
	    td.white {color: black;}
      </style>
    <% End If %>

	<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

	<script type="text/javascript">
		function changeDates(d)
			{
			dt = new Date(d);
			document.frm.month.value = dt.getMonth() + 1;
			document.frm.year.value = dt.getFullYear();

			document.frm.submit();
			}

		function clickSubmit()
			{
			document.frm.month.value = document.frm.searchMonth.value;
			document.frm.year.value  = document.frm.searchYear.value;

			document.frm.submit();
			}

		function sortFrm(fld, ascDesc)
			{
			document.getElementById('orderBy').value = fld;
			document.getElementById('ascDesc').value = ascDesc;

			document.frm.submit();
			}

		function printable(v)
			{
			document.getElementById('forPrinting').value = v;
			document.getElementById('page').value = <%=strPage%>;
			document.frm.submit();
			}

		function clickSearch()
			{
			document.getElementById('harvestID').value   = document.getElementById('harvestIDSearch').value;
			document.getElementById('userLogin').value   = document.getElementById('userLoginSearch').value;
			document.getElementById('clientName').value  = document.getElementById('clientNameSearch').value;

			document.getElementById('orderBy').value  = "";

			document.frm.submit();
			}
			
		var isIE = 1;    
		if (navigator.appName == "Netscape")
			{ 
			isIE = 0;
			}

		function whichKey(e)
			{
			if (isIE)
				{
				return e.keyCode;
				}
			else
				{
				return e.which;
				}
			}
			
		function keytest(e) 
			{
			var k = whichKey(e);
			if (k == 13) 
				{
				clickSearch();
				}
			}
	</script>
<%
	strSQL = ""
	strSubHead = ""
	strServiceType = 8  'Database interface
	rData = "&year=" & strYear & "&month=" & strMonth & "&forPrinting=" & cstr(ForPrinting)
	
	'If first time at this page, search all rows
	If request("userLogin") = "" and request("harvestID") = "" and request("clientName") = "" then
		strSQL = ""
		strSubHead = ""
	Else
		If request("userLogin")<>"" then
			strSQL = " AND [UserLogin] LIKE '" & Request("userLogin") & "%'"
			strSubHead = "User Login starting with '" & Request("userLogin") & "'"
			rData = rData & "&userLogin=" & Request("userLogin")
		End If
		If request("harvestID")<>"" then
			strSQL = strSQL & " AND [HarvestID] = " & Request("harvestID")
			If strSubHead <> "" then
				strSubHead = strSubHead & ", "
			End If
			strSubHead = strSubHead & "Harvest ID is '" & Request("harvestID") & "'"
			rData = rData & "&harvestID=" & Request("harvestID")
		End If
		If request("clientName")<>"" then
			strSQL = strSQL & " AND [ClientName] LIKE '" & Request("clientName") & "%'"
			If strSubHead <> "" then
				strSubHead = strSubHead & ", "
			End If
			strSubHead = strSubHead & "Client Name starting with '" & Request("clientName") & "'"
			rData = rData & "&clientName=" & Request("clientName")
		End If
	End If
	
	
	If isnull(Request("ascDesc")) or Request("ascDesc") = "" then
		AscDesc = "a"
	Else
		AscDesc = Request("ascDesc")
	End If

	If isnull(Request("orderBy")) or Request("OrderBy") = "" then
		OrderBy = "ClientName"
	Else
		OrderBy = Request("OrderBy")

		If strSubHead <> "" then
			strSubHead = strSubHead & ", "
		End If

		strSubHead = strSubHead & "Sort by " & OrderBy

		If LCase(AscDesc) <> "a" then
			strSubHead = strSubHead & " (desc)"
		End If
	End If

	rData = rData & "&orderBy=" & OrderBy & "&ascDesc=" & AscDesc

	If LCase(AscDesc) = "a" Then
		AscDescSQL = " Asc"
	Else
		AscDescSQL = " Desc"
	End If

	Select Case LCase(OrderBy)
	  Case "userlogin"
		SortFields = "UserLogin" & AscDescSQL
	  Case "clientname"
		SortFields = "ClientName" & AscDescSQL & ", UserLogin"
	  Case "monthtotal"
		SortFields = "MonthTotal" & AscDescSQL & ", ClientName"
	  Case "harvestid"
		SortFields = "HarvestID" & AscDescSQL & ", UserLogin"
	End Select
%>
</head>

<body onkeypress="keytest(event);">

<table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">

<%If ForPrinting then %><tr><td><div style='display:none;'><%End If%>
  <!--#include virtual="z2t_Backoffice/includes/heading.inc"-->
<%If ForPrinting then %></div></td></tr><%End If%>

    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="content">
          <tr>
            <td width="100%" align="left" height="10" class="divDeskTop">
            </td>
          </tr>
          <tr>
            <td width="100%" align="left" class="divDeskMiddle">
              <table width="1160" border="0" cellspacing="0" cellpadding="0" align="center">  <!--Main Inside-->
                <tr>
                  <td>
                  
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">  <!-- input section-->
                      <form name="frm" action="z2t_SubscriberLookupUsage.asp" method="Post">
                        <tr valign="top">
                          <td width="40%" align="left">
                         
                            <table width="400" border="0" cellspacing="2" cellpadding="0" align="left" style="height: 60px;">
                                <tr valign="middle">
                                    <td>
                                        <b>Year:</b>
                                    </td>
                                    <td>
                                        <input name="searchYear" id="searchYear" type="text" size="2" value="<%=strYear%>" />
                                    </td>
        
                                    <td>
                                        <b>Month:</b>
                                    </td>
                                    <td>
                                        <select name="searchMonth" id="searchMonth">
                                            <% For mo = 1 to 12 %>					
                                                <option value="<%=mo%>" <% If mo = cint(strMonth) Then %>Selected<%End If%>>
                                                <%=MonthName(mo)%>
                                                </option>
                                            <% Next %>					
                                        </select>
                                    </td>
                <%
                                    If ForPrinting Then
                                        ButtonClass = ""
                                    Else
                                        ButtonClass = "class='button'"
                                    End If
                %>
                                    <td valign="middle">
                                        <a href='javascript:clickSubmit();' <%=ButtonClass%>>Submit</a>
                                    </td>							
                                </tr>
                            </table>
                            
                          </td>
                          <td width="20%" align="center" valign="middle">
                            <%=strSubHead%>
                          </td>
                          <td width="40%" align="right">
                          
                            <table width="400" border="0" cellspacing="2" cellpadding="0" align="right" style="height: 60px;">
                                <tr valign="middle">
                                    <td align="right">
                                        <a href="javascript:changeDates('<%=DateAdd("m",-1,cDate(strDate))%>');" <%=ButtonClass%>>&lt; Previous Month</a>
                                        &nbsp;
                                        <a href="javascript:changeDates('<%=MaxDate%>');" <%=ButtonClass%>>Current Month</a>
                                        &nbsp;
                                        <a href="javascript:changeDates('<%=DateAdd("m",1,cDate(strDate))%>');" <%=ButtonClass%>>Next Month&gt;</a>
                                    </td>
                                </tr>
                            </table>
                            
                          </td>
                        </tr>
                        
                        <input type='hidden' id='year'  name='year'  value='<%=strYear%>'>
                        <input type='hidden' id='month' name='month' value='<%=strMonth%>'>
                        <input type='hidden' id='orderBy' name='orderBy' value='<%=OrderBy%>'>
                        <input type='hidden' id='ascDesc' name='ascDesc' value='<%=AscDesc%>'>
                        <input type="hidden" id="forPrinting" name="forPrinting" value="<%=ForPrinting%>" />
                        <input type="hidden" id="page" name="page" value="" />
        
                        <input type="hidden" id="userLogin"   name="userLogin"   value="<%=Request("userLogin")%>">
                        <input type="hidden" id="harvestID"   name="harvestID"   value="<%=Request("harvestID")%>">
                        <input type="hidden" id="clientName"  name="clientName"  value="<%=Request("clientName")%>">
                        
                      </form>
                    </table>  <!-- input section-->
        
            
        <%
                    If ForPrinting Then
                        BGColor = "#E5E5E5"
                    Else
                        BGColor = "#990000"
                    End If
        %>
        
                    <table width="100%" class="z2tdata" border="0" cellspacing="1" cellpadding="0" align="center" bgcolor="white">  <!-- main list section-->
                      <thead>
                        <tr valign='top' bgcolor="<%=BGColor%>">
                          <%=ColumnHeading("User Login", "userlogin")%>
                          <%=ColumnHeading("Harvest ID", "harvestID")%>
                          <%=ColumnHeading("Client Name", "clientname")%>
                          <%=ColumnHeading("Month Total", "monthtotal")%>
                          <th>&nbsp;</th>
                        </tr>
                      </thead>
        
                      <thead>
                          <tr height="27" valign='center' bgcolor="<%=BGColor%>">
                            <th width="10%" align="center" valign="middle"><input type="text" id="userLoginSearch"   style="width:100px"></th>
                            <th width="8%" align="center" valign="middle"><input type="text" id="harvestIDSearch"   style="width:45px"></th>
                            <th width="20%" align="left"   valign="middle">
                              <input type="text" id="clientNameSearch"  style="width:200px">
                              &nbsp;&nbsp;
                              <a href='javascript:clickSearch();' <%=ButtonClass%>>Search</a>
                            </th>
                            <th width="50%" align="left" valign="middle">
                              <table width = "100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <th width="14%" align="center" title="Database Interface">Link</th>
                                  <th width="14%" align="center" title="iPhone or z2t.Mobi">Mobi</th>
                                  <th width="14%" align="center" title="Database Interface using the Request Variable">Request</th>
                                  <th width="14%" align="center" title="Online Lookup">Web</th>
                                  <th width="14%" align="center" title="Widget">Widget</th>
                                  <th width="16%" align="center" title="Total Lookups from all Devices">Total</th>
                                  <th width="14%" align="center" title="Upper Limit Customer Has Purchased">Limit</th>
                                </tr>
                              </table>
                            </th>
                            <th width="12%" valign="middle" class="white">Last Activity</th>
                        </tr>
                      </thead>
        
                <%
                set objRS=Server.CreateObject("ADODB.Recordset")
        
                objRS.CursorLocation = 3  'Client-side
        
                strSQL = replace(strSQL, "'", "''")
                strSQL = strYear & ", " & strMonth & ", '" & strSQL & "'"
        
                strSQL = "z2t_Reporting_Subscriber_Lookup_Usage(" & strSQL & ")"
'                response.Write(strSQL)
                objRS.Open strSQL, connBackoffice, adOpenForwardOnly, adLockBatchOptimistic, 4
                
                Set objRS.ActiveConnection = Nothing
        
                objRS.Sort = SortFields
                
                noRecords = False
                
                If Not objRS.eof Then
                    '------------------------------------Starting Paging from Here-----------------------------------
                    iRecordperpage = 30
                    ObjRS.PageSize = iRecordperpage
                    nRecordsPerPage = ObjRS.PageSize
                    ObjRS.CacheSize = ObjRS.PageSize
                    intPageCount = ObjRS.PageCount 
                    intRecordCount = ObjRS.RecordCount
        
                    icurrentPage = TRIM(REQUEST("page"))  'icurrentPage = 0 for first page
        
                    If icurrentPage = "" Then 
                        icurrentPage = 0
                    Else
                        icurrentPage = CInt(request("page"))
                    End If
        
                    If CInt(icurrentPage) > CInt(intPageCount)-1 Then icurrentPage = intPageCount-1
                    If CInt(icurrentPage) < 0 Then icurrentPage = 0
                        
                    If intRecordCount > 0 Then
                        ObjRS.AbsolutePage = icurrentPage + 1   'ObjRS.AbsolutePage = 1 for first page
                        
                        rownum = 0
                        
                        For n=1 to iRecordperpage
                            rownum = rownum + 1
        
                %>
                      <tr valign='top' bgcolor=<%if (rownum mod 3) > 0 then%>"White"<% else %>"#E5E5E5"<% end if %> >
                        <td width="10%" align="center">
                          <%=objRS("UserLogin")%>
                        </td>
                        <td width="8%" align="center">
                          <a href="<%=HarvestURL%>?ID=<%=objRS("HarvestID")%>"
							target="_new" title="Click to view account information in a new page">
							<%=objRS("HarvestID")%></a>
                        </td>
                        <td width="25%" style="padding-left: 10px;">
                          <%=objRS("ClientName")%>
                        </td>
                        <td width="44%">
                          <table width = "100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="14%" align="right" style="padding-right: 20px;">
                                <%=FormatNumber(objRS("CountLink"),0)%>
                              </td>
                              <td width="14%" align="right" style="padding-right: 20px;">
                                <%=FormatNumber(objRS("CountMobi"),0)%>
                              </td>
                              <td width="14%" align="right" style="padding-right: 20px;">
                                <%=FormatNumber(objRS("CountRequest"),0)%>
                              </td>
                              <td width="14%" align="right" style="padding-right: 20px;">
                                <%=FormatNumber(objRS("CountWeb"),0)%>
                              </td>
                              <td width="14%" align="right" style="padding-right: 20px;">
                                <%=FormatNumber(objRS("CountWidget"),0)%>
                              </td>
                              <td width="16%" align="right" style="padding-right: 20px; background-color: #E5E5E5;">
                            <% If Not (IsNull(objRS("UserLogin")) or objRS("UserLogin") = "") Then %>
                                <a class="linkcell" href="javascript:window.open('PopUps/z2t_SubscriberLookupUsage_Month.asp?startYear=<%=strYear%>&startMonth=<%=strMonth%>&servicetype=<%=strServiceType%>&userlogin=<%=Server.URLEncode(objRS("UserLogin"))%>&forPrinting=<%=cstr(ForPrinting)%>',
                                '','scrollbars=yes,fullscreen=no,resizable=yes, height=500,width=720,left=150,top=50');void(0)">
                                <%=FormatNumber(objRS("MonthTotal"),0)%></a>
                            <% Else %>
                                <%=FormatNumber(objRS("MonthTotal"),0)%>
                            <% End If %>
                              </td>
                              <td width="14%" align="right" style="padding-right: 20px;">
                                <%=FormatNumber(objRS("Limit"),0)%>
                              </td>
                            </tr>
                          </table>
                        </td>
                        <td width="13%" align="right" style="padding-right: 10px;">
<%
						  laDate = objRS("LastActivityDate")
						  If IsDate(laDate) Then 
						    laDate = FormatDateTime(laDate,2)
						  Else
						    laDate = ""
						  End If
						  Response.Write(laDate)
%>
                        </td>
                      </tr>
                <%
                            ObjRS.MoveNext
                            If ObjRS.eof Then Exit For
                        Next
                    End If
                Else
                    noRecords = True
                End If
                %>
                    </table>
                  </td>
                </tr>
        
                <tr>
                  <td width="100%" align="left" height="10" />
                </tr>
        
                <tr valign="top">
                  <td width="100%" align="left">
        
                          <table class="navigationBox" cellspacing='0' cellpadding='0'>
                            <tr>
                              <td align='center'>
								<%
                                Response.write GetHitCountAndPageLinks(Request.ServerVariables("URL"), intRecordCount, nRecordsPerPage, intPageCount, icurrentPage, rData)
                                %>
                              </td>
                            </tr>
                          </table>
        
                  </td>
                </tr>
              </table>  <!--Main Inside-->
	
             </td>
             </tr>
         <tr class="divDeskMiddle">
            	<td width="100%" align="center">
           		 <br>
           		 <%If ForPrinting Then%>
           			 &nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onClick="printable('False');">Regular Version</a><br>
           		<%Else%>
           			 &nbsp;&nbsp;&nbsp;<a class="whitelink" href="javascript:void(0)" onClick="printable('True');">Printable Version</a><br>&nbsp;
            	<%End If%>
            	<br>&nbsp;
           	  </td>
            </tr>
               <tr>
            	<td width="100%" align="left" height="10" class="divDeskBottom">
            </td>
            </tr>
                    
        </table>
      </td>
    </tr>
      
  </table>
  <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->
</body>
</html>
