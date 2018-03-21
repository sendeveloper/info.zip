<%
        Response.buffer=true
        Response.clear
%>

<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/DBConstants.inc"-->

<%  
    Title = "Subscriber Lookup Usage"

	Dim strStartYear
	Dim strStartMonth
	Dim strStartDate
	Dim strEndYear
	Dim strEndMonth
	Dim strEndDate
	Dim MaxYear
	Dim MaxMonth
	Dim MaxDate

	Dim strServiceType
	Dim strUserLogin
	Dim apsUserLogin
	Dim strClientName
	Dim strHarvestID
	Dim ForPrinting
	Dim ExportExcel
	
	Dim ActivityYear(120), ActivityMonth(120), NameDevice(120), NameService(120), DailyTotal(120), MonthTotal(120)
	Dim DayTotal(120,40)   ' Day (Activity subscript#, Day#) 
	Dim ActivitySub, DaySub
	Dim ActivityMaxSub
	
	Const ExcelOutFile = "z2t_database_interface_report.csv"
	
	If Request("startYear") = "" OR isnull(Request("startYear")) Then
		Response.Redirect "z2t_DatabaseInterfaceReport.asp"
	Else
		strStartYear = Request("startYear")
	End If

	If Request("startMonth") = "" OR isnull(Request("startMonth")) Then
		Response.Redirect "z2t_DatabaseInterfaceReport.asp"
	Else
		strStartMonth = Request("startMonth")
	End If

	If Request("endYear") = "" OR isnull(Request("endYear")) Then
		strEndYear = ""
	Else
		strEndYear = Request("endYear")
	End If

	If Request("endMonth") = "" OR isnull(Request("endMonth")) Then
		strEndMonth = ""
	Else
		strEndMonth = Request("endMonth")
	End If

	If Request("servicetype") = "" OR isnull(Request("servicetype")) Then
		strServiceType = "8"
	Else
		strServiceType = Request("servicetype")
	End If

	If isnull(Request("forPrinting")) OR Request("forPrinting") <> "True" Then
		ForPrinting = False
	Else
		ForPrinting = True
	End If

	If isnull(Request("exportExcel")) OR Request("exportExcel") <> "True" Then
		ExportExcel = False
	Else
		ExportExcel = True
	End If

	If Request("userlogin") = "" OR isnull(Request("userlogin")) Then
		Response.Redirect "z2t_DatabaseInterfaceReport.asp"
	Else
		strUserLogin = Request("userlogin")
	End If
	
	apsUserLogin = Replace(strUserLogin, "'", "''")
	escUserLogin = Replace(strUserLogin, "'", "&#39;")
	
    dim connPhilly05
    set connPhilly05=server.CreateObject("ADODB.Connection")
    connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Backoffice;"
	
	set objRS = Server.CreateObject("ADODB.Recordset")
	objRS.CursorLocation = 3

	strSQL = "SELECT Top 1 ActivityYear, ActivityMonth " & _
	         "FROM z2t_AggregateActivityLookupsBy_All " & _
			 "WHERE UserLogin = '" & apsUserLogin & "' " & _
	         "ORDER BY ActivityYear desc, ActivityMonth desc "
			 
	objRS.open strSQL, connPhilly05, 2, 3

	MaxYear = objRS("ActivityYear")
	MaxMonth = objRS("ActivityMonth")

	objRS.close
	
	strStartDate = strStartMonth & "/1/" & strStartYear
	strEndDate   = strEndMonth   & "/1/" & strEndYear
	MaxDate = MaxMonth & "/1/" & MaxYear
	
	
	'Open the SQL data
	set objRS=Server.CreateObject("ADODB.Recordset")
	objRS.CursorLocation = 3

	If IsNumeric(strEndMonth) and IsNumeric(strEndYear) Then
		strSQL = strStartYear & ", " & strStartMonth & ", '" & apsUserLogin & "', " & strEndYear & ", " & strEndMonth
	Else
		strSQL = strStartYear & ", " & strStartMonth & ", '" & apsUserLogin & "'"
	End If

	strSQL = "z2t_Reporting_DailyLookupUsageForUser(" & strSQL & ")"

	objRS.open strSQL, connPhilly05, 3, 3, 4

	If objRS.eof Then
		strClientName = ""
		strHarvestID = ""
	Else
		strClientName = objRS("ClientName")
		strHarvestID = objRS("HarvestID")
	End If

	
	'Save everything in arrays so we can pivot the results
	
	ActivitySub = 0
	
	Do Until objRS.eof
		ActivitySub = ActivitySub + 1

		ActivityYear  (ActivitySub) = objRS("ActivityYear")
		ActivityMonth (ActivitySub) = objRS("ActivityMonth")
		NameDevice    (ActivitySub) = objRS("NameDevice")
		NameService   (ActivitySub) = objRS("NameService")
		MonthTotal    (ActivitySub) = objRS("MonthTotal")

		For DaySub = 1 to 31
			countLookups = objRS("Day" & Cstr(DaySub) & "Total")
			DailyTotal(DaySub) = DailyTotal(DaySub)  + countLookups
			DayTotal(ActivitySub, DaySub) = countLookups
			totalLookups = totalLookups + countLookups
		Next

		ObjRS.MoveNext
	Loop
	
	ActivityMaxSub = ActivitySub
	
	objRS.Close

	
	'Export to Excel if requested
	
	If ExportExcel and ActivityMaxSub > 0 Then
		Response.Clear
		Response.AddHeader "Content-Disposition", "attachment; filename=" & ExcelOutFile
		Response.ContentType = "application/octet-stream"
		Response.CharSet = "UTF-8"

		
		'Header - Months
		Response.Write(",")

		For ActivitySub = 1 to ActivityMaxSub
			Response.Write("=""" & MonthName(ActivityMonth(ActivitySub)) & " " & ActivityYear(ActivitySub) & """")

			If ActivitySub < ActivityMaxSub Then
				Response.Write(",")
			End If
		Next

		Response.Write(chr(13) + chr(10))


		'Header - Activity Label
		Response.Write(",")

		For ActivitySub = 1 to ActivityMaxSub
			Response.Write(NameDevice(ActivitySub))

			If ActivitySub < ActivityMaxSub Then
				Response.Write(",")
			End If
		Next

		Response.Write(chr(13) + chr(10))


		'Month Totals
		Response.Write("Month Total,")

		For ActivitySub = 1 to ActivityMaxSub
			Response.Write(MonthTotal(ActivitySub))

			If ActivitySub < ActivityMaxSub Then
				Response.Write(",")
			End If
		Next

		Response.Write(chr(13) + chr(10))

		
		'Day Totals
		For DaySub = 1 to 31
			Response.Write("Day " & DaySub & ",")

			For ActivitySub = 1 to ActivityMaxSub
				Response.Write(DayTotal(ActivitySub, DaySub))

				If ActivitySub < ActivityMaxSub Then
					Response.Write(",")
				End If
			Next
			
			Response.Write(chr(13) + chr(10))
		Next
  Else
%>

<!DOCTYPE html>
<html>

<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	

    <style type="text/css">
        th {font-family: arial; color: black; font-size: 12}
        td {font-family: arial; color: black; font-size: 12}
		
		a.button {font-weight: bold; 
			font-size: 11px; 
			font-family: Verdana, Arial, Helvetica, sans-serif;	
			color: #FFFFFF;
			padding: 4px 8px; 
			background-color: #990000;
			border-top: 2px solid #C0C0C0;
			border-right: 2px solid black; 
			border-bottom: 2px solid black;
			border-left: 2px solid #C0C0C0; 
			text-align: center; 
			text-decoration: none;
			width: 80px;}

		a.button:hover {font-weight: bold; 
			font-size: 11px;
			font-family: Verdana, Arial, Helvetica, sans-serif;	
			color: #C0C0C0;
			background-color: #990000;	
			border-color: black #C0C0C0 #C0C0C0 black;}
    </style>

    <script language="JavaScript" src="<%=strPathDates%>checkDate.js" type="text/javascript"></script>
    <script language="JavaScript" src="<%=strPathDates%>ts_picker.js" type="text/javascript"></script>

	<script language='JavaScript'>
		function changeDates(d)
			{
			dt = new Date(d);
			document.frm.startMonth.value = dt.getMonth() + 1;
			document.frm.startYear.value  = dt.getFullYear();
			document.frm.endMonth.value   = "";
			document.frm.endYear.value    = "";

			document.frm.submit();
			}

		function clickSubmit()
			{
			document.frm.startMonth.value = document.frm.searchStartMonth.value;
			document.frm.startYear.value  = document.frm.searchStartYear.value;
			document.frm.endMonth.value   = document.frm.searchEndMonth.value;
			document.frm.endYear.value    = document.frm.searchEndYear.value;

			document.frm.submit();
			}

		function printable(v)
			{
			document.getElementById('forPrinting').value = v;
			document.frm.submit();
			}

		function clickExcel()
			{
			document.getElementById('exportExcel').value = 'True';
			document.frm.submit();
			document.getElementById('exportExcel').value = 'False';
			}

		function chgEndMonth()
			{
			if (document.getElementById('searchEndMonth').value == '')
				document.getElementById('searchEndYear').value = '';
			}

		function chgEndYear()
			{
			if (document.getElementById('searchEndYear').value == '')
				document.getElementById('searchEndMonth').value = '';
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
</head>

<body onLoad="SetScreen(750,900);" onKeyPress="keytest(event);>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	  <tr>
		<td>
		  <span class="popupHeading"><%=Title%></span><br>
		  <form name='frm' action='z2t_SubscriberLookupUsage_Month.asp' method='Post'>
		  <input type='hidden' id='startYear'   name='startYear'   value='<%=strStartYear%>'>
		  <input type='hidden' id='startMonth'  name='startMonth'  value='<%=strStartMonth%>'>
		  <input type='hidden' id='endYear'     name='endYear'     value='<%=strEndYear%>'>
		  <input type='hidden' id='endMonth'    name='endMonth'    value='<%=strEndMonth%>'>
		  <input type='hidden' id='serviceType' name='serviceType' value='<%=strServiceType%>'>
		  <input type='hidden' id='userLogin'   name='userLogin'   value='<%=escUserLogin%>'>
		  <input type='hidden' id='forPrinting' name='forPrinting' value='<%=ForPrinting%>'>
		  <input type='hidden' id='exportExcel' name='exportExcel' value='False'>

		  <table width="250" border="01" cellspacing="2" cellpadding="4" align="center">
			<tr valign="top">
			  <td nowrap><b>User Login:</b></td>
			  <td><%=strUserLogin%></td>
			</tr>
			<tr>
			  <td nowrap><b>Client Name:</b></td>
			  <td><%=strClientName%></td>
			</tr>
			<tr>
			  <td nowrap><b>Harvest ID:</b></td>
			  <td><%=strHarvestID%></td>
			</tr>
		  </table>

		  <table width="500" border="0" cellspacing="3" cellpadding="3" align="center">
			<tr valign="top">
			  <td height="10" />
			</tr>
			<tr>
				<td width="30%" align="right">
					<b>Start Year:</b>
				</td>
				<td width="10%" align="left">
					<select name="searchStartYear" id="searchStartYear">
						<% For yr = Year(Now) to 2008 Step -1 %>					
							<option value="<%=yr%>" <% If yr = cint(strStartYear) Then %>Selected<%End If%>>
							<%=yr%>
							</option>
						<% Next %>				
					</select>
				</td>

				<td width="20%" align="right">
					<b>Start Month:</b>
				</td>
				<td width="15%" align="left">
					<select name="searchStartMonth" id="searchStartMonth">
						<% For mo = 1 to 12 %>					
							<option value="<%=mo%>" <% If mo = cint(strStartMonth) Then %>Selected<%End If%>>
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
				<td width="25%" align="center" valign="middle">
					<a href='javascript:clickSubmit();' <%=ButtonClass%>>Submit</a>
				</td>
			</tr>
			<tr>
				<td align="right">
					<b>End Year:</b>
				</td>
				<td align="left">
					<select name="searchEndYear" id="searchEndYear" onchange="chgEndYear();">
						<option value="" <% If Not IsNumeric(strEndYear) Then %>Selected<%End If%>>
						<% For yr = Year(Now) to 2008 Step -1 %>					
							<option value="<%=yr%>" 
								<% If IsNumeric(strEndYear) Then 
									If yr = cint(strEndYear) Then %>
										Selected
								<%  End If
								End If %> >
								
								<%=yr%>
							</option>
						<% Next %>
					</select>
				</td>

				<td align="right">
					<b>End Month:</b>
				</td>
				<td align="left">
					<select name="searchEndMonth" id="searchEndMonth" onchange="chgEndMonth();">
						<option value="" <% If Not IsNumeric(strEndMonth) Then %>Selected<%End If%>>
						<% For mo = 1 to 12 %>					
							<option value="<%=mo%>" 
								<% If IsNumeric(strEndMonth) Then 
									If mo = cint(strEndMonth) Then %>
										Selected
								<%  End If
								End If %> >
								
								<%=MonthName(mo)%>
							</option>
						<% Next %>					
					</select>
				</td>

				<td />
			</tr>
			<tr>
				<td colspan="5" height="3" />
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center" nowrap>
					<a href="javascript:changeDates('<%=DateAdd("m",-1,cDate(strStartDate))%>');" <%=ButtonClass%>>&lt; Previous</a>
					&nbsp;
					<a href="javascript:changeDates('<%=MaxDate%>');" <%=ButtonClass%>>Current</a>
					&nbsp;
					<a href="javascript:changeDates('
					<% If IsNumeric(strEndMonth) and IsNumeric(strEndYear) Then %>
						<%=DateAdd("m",1,cDate(strEndDate))%>
					<% Else %>
						<%=DateAdd("m",1,cDate(strStartDate))%>
					<% End If %>
						');" 
					<%=ButtonClass%>>Next &gt;</a>
				</td>
			</tr>
			<tr>
				<td colspan="5" height="3" />
			</tr>
		  </table>
		  <table width="350" border="0" cellspacing="3" cellpadding="3" align="center">
			<tr>
				<td align="center" valign="middle">
					<a href='javascript:clickExcel();' <%=ButtonClass%>>Export to Excel</a>
				</td>
			</tr>
			</tr>
				<td colspan="5" height="3" />
				</td>
			<tr>
		  </table>

		  <table width="<% =90+90*ActivityMaxSub %>" border="1" cellspacing="0" cellpadding="3" align="center" bgcolor="white">
			<tr>
				<th width="90" bgcolor="#C0C0C0" align="right" valign="middle">Device</th>
				<th width="90" bgcolor="#C0C0C0" align="center" valign="middle"></th>

				<%
					For ActivitySub = 1 to ActivityMaxSub
						If ActivitySub > 1 Then
							If (Cstr(ActivityYear(ActivitySub)) & Cstr(ActivityMonth(ActivitySub))) <> (Cstr(ActivityYear(ActivitySub - 1)) & Cstr(ActivityMonth(ActivitySub - 1))) Then 
								BGSub = 3 - BGSub 
							End If
						End If
				%>
						<td width="90" bgcolor="#C0C0C0" align="center" valign="middle">
						  <b>
						    <%=NameDevice(ActivitySub)%>
						  </b>
						</td>
				<%  Next %>
			</tr>
			<tr>
				<th bgcolor="#C0C0C0" align="right" valign="middle">Service</th>
				<th bgcolor="#C0C0C0" align="center" valign="middle">Total</th>

				<%
					For ActivitySub = 1 to ActivityMaxSub
						If ActivitySub > 1 Then
							If (Cstr(ActivityYear(ActivitySub)) & Cstr(ActivityMonth(ActivitySub))) <> (Cstr(ActivityYear(ActivitySub - 1)) & Cstr(ActivityMonth(ActivitySub - 1))) Then 
								BGSub = 3 - BGSub 
							End If
						End If
				%>
						<td bgcolor="#C0C0C0" align="center" valign="middle">
						  <b>
						    <%=NameService(ActivitySub)%>
						  </b>
						</td>
				<%  Next %>
			</tr>

			<tr>
				<th bgcolor="#C0C0C0" align="center" valign="middle">Month Total</th>
				<th bgcolor="#E5E5E5" align="right" valign="middle"><%=FormatNumber(totalLookups,0)%></th>
				<%					
					For ActivitySub = 1 to ActivityMaxSub
						If ActivitySub > 1 Then
							If (Cstr(ActivityYear(ActivitySub)) & Cstr(ActivityMonth(ActivitySub))) <> (Cstr(ActivityYear(ActivitySub - 1)) & Cstr(ActivityMonth(ActivitySub - 1))) Then 
								BGSub = 3 - BGSub 
							End If
						End If
				%>
						<th bgcolor="#E5E5E5" height="40" align="right" valign="middle"><%=FormatNumber(MonthTotal(ActivitySub),0)%></hd>
				<%  Next %>
			</tr>

			<% 
			'Determine Number of days in this month
			DaysOfMonth = cstr(ActivityMonth(1)) & "/01/" & cstr(ActivityYear(1))
			DaysOfMonth = DateAdd("m",1,DaysOfMonth)
			DaysOfMonth = DateAdd("d",-1,DaysOfMonth)
			DaysOfMonth = DatePart("d",DaysOfMonth)
			
			For DaySub = 1 to DaysOfMonth
			  ActivityDay = cstr(ActivityMonth(1)) & "/" & cstr(DaySub) & "/" & cstr(ActivityYear(1))
			%>
				<tr>
					<th bgcolor="#C0C0C0" align="center" valign="middle"><%=ActivityDay%></th>			
					<th bgcolor="#E5E5E5" align="right" valign="middle"><%=FormatNumber(DailyTotal(DaySub),0)%></th>
					
					<%
						For ActivitySub = 1 to ActivityMaxSub
							If ActivitySub > 1 Then
								If (Cstr(ActivityYear(ActivitySub)) & Cstr(ActivityMonth(ActivitySub))) <> (Cstr(ActivityYear(ActivitySub - 1)) & Cstr(ActivityMonth(ActivitySub - 1))) Then 
									BGSub = 3 - BGSub 
								End If
							End If
							If Weekday(ActivityDay) = 1 or Weekday(ActivityDay) = 7 Then
								bColor = "#E5E5E5"
							Else
								bColor = "#FFFFFF"
							End If
					%>
							<td bgcolor="<%=bColor%>" align="right" valign="middle"><%=FormatNumber(DayTotal(ActivitySub, DaySub),0)%></td>
					<%  Next %>
				</tr>
			<% Next %>
		  </table>
		  </form>
		</td>
	  </tr>
	  <tr>
		<td width="100%" align="center">
		<br>
	<%If ForPrinting Then%>
		&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onClick="printable('False');">Regular Version</a><br>
	<%Else%>
		&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onClick="printable('True');">Printable Version</a><br>&nbsp;
	<%End If%>
		<br>&nbsp;
		</td>
	  </tr>
	</table>
</body>
</html>

<%
     Response.End
   End If
%>
