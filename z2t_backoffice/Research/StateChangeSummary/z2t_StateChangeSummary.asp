<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<%
    PageHeading = "State Change Summary"
	ColorTab = 3
%>
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual='z2t_Backoffice/includes/DBConstants.inc'-->
<!--#include virtual='z2t_Backoffice/includes/DBFunctions.asp'-->

<html>
<head>
    <title>Zip2Tax.info - State Change Summary</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />

	<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

	<script language='JavaScript'>
		function sortFrm(fld)
			{
			document.getElementById('orderBy').value = fld;
			
			document.frm.submit();
			}

		function clickSearch()
			{
			document.getElementById('state').value    = document.getElementById('stateSrch').value;
			document.getElementById('county').value   = document.getElementById('countySrch').value;
			document.getElementById('city').value     = document.getElementById('citySrch').value;
			document.getElementById('zip').value      = document.getElementById('zipSrch').value;
			document.getElementById('category').value = document.getElementById('categorySrch').value;
			document.getElementById('note').value     = document.getElementById('noteSrch').value;

			document.getElementById('orderBy').value  = "";

			document.frm.submit();
			}

		function clickAdd()
			{
			document.editform.ID.value  = '';
			document.editform.action.value  = 'Add';
			document.editform.submit();
			}

		function clickEdit(NoteID)
			{
			document.editform.ID.value  = NoteID;
			document.editform.action.value  = 'Edit';
			document.editform.submit();
			}
	
		function clickDelete(NoteID)
			{
			document.deleteform.ID.value  = NoteID;
			document.deleteform.action.value  = 'Delete';
			document.deleteform.submit();
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
		rData = ""
		
		'If first time at this page, search all rows
		if request("state")="" and request("county")="" and request("city")="" and request("zip")="" and request("category")="" and request("note")="" then
			strSQL = ""
			strSubHead = ""
		else
			if request("state")<>"" then
				strSQL=" AND [state] LIKE '" & Request("state") & "%'"
				strSubHead = "States starting with '" & Request("state") & "'"
				rData = rData & "&state=" & Request("state")
			end if
			if request("county")<>"" then
				strSQL = strSQL & " AND [county] LIKE '" & Request("county") & "%'"
				if strSubHead <> "" then
					strSubHead = strSubHead & ", "
				end if
				strSubHead = strSubHead & "Counties starting with '" & Request("county") & "'"
				rData = rData & "&county=" & Request("county")
			end if
			if request("city")<>"" then
				strSQL = strSQL & " AND [city] LIKE '" & Request("city") & "%'"
				if strSubHead <> "" then
					strSubHead = strSubHead & ", "
				end if
				strSubHead = strSubHead & "Cities starting with '" & Request("city") & "'"
				rData = rData & "&city=" & Request("city")
			end if
			if request("zip")<>"" then
				strSQL = strSQL & " AND [zip] LIKE '" & Request("zip") & "%'"
				if strSubHead <> "" then
					strSubHead = strSubHead & ", "
				end if
				strSubHead = strSubHead & "Zips starting with '" & Request("zip") & "'"
				rData = rData & "&zip=" & Request("zip")
			end if
			if request("category")<>"" then
				strSQL = strSQL & " AND [category] LIKE '" & Request("category") & "%'"
				if strSubHead <> "" then
					strSubHead = strSubHead & ", "
				end if
				strSubHead = strSubHead & "Categories starting with '" & Request("category") & "'"
				rData = rData & "&category=" & Request("category")
			end if
			if request("note")<>"" then
				strSQL = strSQL & " AND [note] LIKE '" & Request("note") & "%'"
				if strSubHead <> "" then
					strSubHead = strSubHead & ", "
				end if
				strSubHead = strSubHead & "Notes starting with '" & Request("note") & "'"
				rData = rData & "&note=" & Request("note")
			end if
		end if

		if isnull(Request("orderBy")) or Request("OrderBy") = "" then
			OrderBy = ""
			strSQL = strSQL & " Order by state, county, city, zip, category, note"
		else
			OrderBy = Request("OrderBy")
			rData = rData & "&orderBy=" & OrderBy

			select case OrderBy 
			  case "state"
				strSQL = strSQL & " Order by " & OrderBy & ", county, city, zip, category, note"
			  case "county"
				strSQL = strSQL & " Order by " & OrderBy & ", state, city, zip, category, note"
			  case "city"
				strSQL = strSQL & " Order by " & OrderBy & ", state, county, zip, category, note"
			  case "zip"
				strSQL = strSQL & " Order by " & OrderBy & ", state, county, city, category, note"
			  case "category"
				strSQL = strSQL & " Order by " & OrderBy & ", state, county, city, zip, note"
			  case "note"
				strSQL = strSQL & " Order by " & OrderBy & ", state, county, city, zip, category"
			end select

			if strSubHead <> "" then
				strSubHead = strSubHead & ", "
			end if
			strSubHead = strSubHead & "Sort by " & OrderBy
		end If
	%>
</head>

<body onKeyPress="keytest(event);">

  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->
  		<form name='frm' action='z2t_SpecialRules.asp' method='Post'>
	 
			<table width="100%" border="0" cellspacing="1" cellpadding="0" align="center" bgcolor="white">
			
<%
	Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
	Dim rs: Set rs=server.createObject("ADODB.Recordset")
	
	connPhilly01.Open "driver=SQL Server;server=10.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables" ' philly01

    'strSQL = "z2t_StateInfo_Phones_list"
    'rs.open strSQL, connPhilly01, 3, 3, 4

		set objRS=Server.CreateObject("ADODB.Recordset")
		objRS.CursorLocation = 3
		
		strSQL = ""

		strSQL = replace(strSQL,"'","''")

		strSQL = "z2t_StateChangeSummary_list ('" & strSQL & "')"

		objRS.open strSQL, connPhilly01, 3, 3, 4

		noRecords = False
		if not objRS.eof then
			'------------------------------------Starting Paging from Here-----------------------------------
			iRecordperpage = 35
			ObjRS.PageSize = iRecordperpage
			nRecordsPerPage = ObjRS.PageSize
			ObjRS.CacheSize = ObjRS.PageSize
			intPageCount = ObjRS.PageCount 
			intRecordCount = ObjRS.RecordCount

			icurrentPage = TRIM(REQUEST("page"))  'icurrentPage = 0 for first page

			if icurrentPage = "" then 
				icurrentPage = 0
			else
				icurrentPage = CInt(request("page"))
			end if

			If CInt(icurrentPage) > CInt(intPageCount)-1 Then icurrentPage = intPageCount-1
			If CInt(icurrentPage) < 0 Then icurrentPage = 0
				
			If intRecordCount > 0 Then
				ObjRS.AbsolutePage = icurrentPage + 1   'ObjRS.AbsolutePage = 1 for first page
				
				rownum = 0
				
				for n=1 to iRecordperpage
					rownum = rownum + 1
%>

			  <tr valign='top' bgcolor=<%if (rownum mod 3) > 0 then%>"White"<% else %>"#DDDDDD"<% end if %> >
				<td width="4%" align="center"><%=objRS("State")%></td>
				<td width="12%"><%=objRS("EffectiveDate")%></td>
				<td width="79%"><%=objRS("ChangeDescription")%></td>
				<td width="5%" valign='center' align='center'>
				  <a href="javascript:clickEdit(<%=objRS("ID")%>);" class="button40">Edit</a>
				</td>				
			  </tr>
<%
					ObjRS.MoveNext
					if ObjRS.eof then exit for
				next
			end if
		else
			noRecords = True
		end if
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

		</form>

		<form name='editform' action='z2t_SpecialRules_Edit.asp' method='Post'>
			<input type="hidden" name="ID"      id="ID">
			<input type="hidden" name="action"  id="action"  value="">
			<input type="hidden" name="retPage" id="retPage" value="z2t_SpecialRules.asp?page=<%if Request("page")="" then%>0<%else Response.Write Request("page") end if%><%=rData%>">
		</form>

		<form name='deleteform' action='z2t_SpecialRules_Post.asp' method='Post'>
			<input type="hidden" name="ID"      id="ID">
			<input type="hidden" name="action"  id="action"  value="Delete">
			<input type="hidden" name="retPage" id="retPage" value="z2t_SpecialRules.asp?page=<%if Request("page")="" then%>0<%else Response.Write Request("page") end if%><%=rData%>">
		</form>
  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
  </body>
</html>
