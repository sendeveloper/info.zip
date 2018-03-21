<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<%
    PageHeading = "Special Rules"
	ColorTab = 3
%>
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual='z2t_Backoffice/includes/DBConstants.inc'-->
<!--#include virtual='z2t_Backoffice/includes/DBFunctions.asp'-->

<html>
<head>
    <title>Zip2Tax.info - Special Rules</title>

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
			<thead>
			  <tr valign='top' bgcolor="#990000">
				<th align="center"><a href="#" class="white" onClick="sortFrm('state');">State</a></th>
				<th align="center">&nbsp;<a href="#" class="white" onClick="sortFrm('county');">County</a></th>
				<th align="center">&nbsp;<a href="#" class="white" onClick="sortFrm('city');">City</a></th>
				<th align="center">&nbsp;<a href="#" class="white" onClick="sortFrm('zip');">Zip</a></th>
				<th align="center">&nbsp;<a href="#" class="white" onClick="sortFrm('category');">Category</a></th>
				<th align="center" colspan="3">&nbsp;<a href="#" class="white" onClick="sortFrm('note');">Note</a></th>
			  </tr>
			  <tr valign='center' bgcolor="#990000">
				<th align="left" colspan="8">&nbsp;<b>SEARCH:</b>&nbsp;<font size='1'><%=strSubHead%></font></th>
			  </tr>
			  <tr height="27" valign='center' bgcolor="#990000">
				<th align="center" valign="middle"><input type="text" id="stateSrch"    style="width:30px"></th>
				<th align="left"   valign="middle"><input type="text" id="countySrch"   style="width:100px"></th>
				<th align="left"   valign="middle"><input type="text" id="citySrch"     style="width:100px"></th>
				<th align="left"   valign="middle"><input type="text" id="zipSrch"      style="width:60px"></th>
				<th align="left"   valign="middle"><input type="text" id="categorySrch" style="width:125px"></th>
				<th align="left"   valign="middle">
				  <input type="text" id="noteSrch" style="width:175px">
				  &nbsp;
				  <a href='javascript:clickSearch();' class='button'>Search</a>
				</th>
				<th colspan="2" align='center' valign='middle'>
				  <a href="javascript:clickAdd();" class="button40">Add</a>
				</th>

				<input type="hidden" name="ID"       id="ID">
				<input type="hidden" name="orderBy"  id="orderBy"  value="<%=request("orderBy")%>">
				<input type="hidden" name="state"    id="state"    value="<%=request("state")%>">
				<input type="hidden" name="county"   id="county"   value="<%=request("county")%>">
				<input type="hidden" name="city"     id="city"     value="<%=request("city")%>">
				<input type="hidden" name="zip"      id="zip"      value="<%=request("zip")%>">
				<input type="hidden" name="category" id="category" value="<%=request("category")%>">
				<input type="hidden" name="note"     id="note"     value="<%=request("note")%>">
				<input type="hidden" name="action"   id="action"   value="">
				<input type="hidden" name="retPage"  id="retPage"  value="z2t_SpecialRules.asp?page=<%if Request("page")="" then%>0<%else Response.Write Request("page") end if%><%=rData%>">
			  </tr>
			</thead>
		<%
		set objRS=Server.CreateObject("ADODB.Recordset")
		objRS.CursorLocation = 3

		strSQL = replace(strSQL,"'","''")

		strSQL = "z2t_SpecialRules_list ('" & strSQL & "')"

		objRS.open strSQL, connBackoffice, 3, 3, 4

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

				if isnull(ObjRS("Category")) then
					Category = ""
				else
					Category = ObjRS("Category")
				end if
				
				eNote = objRS("Note")
				If Len(eNote) > 60 Then
					eNote = left(eNote, 60) & "<font color='#C0C0C0'> . . . [more]</font>"
				End If
		%>
			  <tr valign='top' bgcolor=<%if (rownum mod 3) > 0 then%>"White"<% else %>"#DDDDDD"<% end if %> >
				<td width="4%" align="center"><%=objRS("State")%></td>
				<td width="12%"><%=objRS("County")%></td>
				<td width="12%"><%=objRS("City")%></td>
				<td width="7%"><%=objRS("Zip")%></td>
				<td width="15%"><%=objRS("Category")%></td>
				<td width="40%" id="note<%=objRS("ID")%>"><%=eNote%></td>
				<td width="5%" valign='center' align='center'>
				  <a href="javascript:clickEdit(<%=objRS("ID")%>);" class="button40">Edit</a>
				</td>
				
				<td width="5%" valign='center' align='center'>
			<% if LCase(Category) <> "tax on shipping" then %>
				  <a href="javascript:clickDelete(<%=objRS("ID")%>);" 
				    class="button40" onClick="return confirm('Are you sure you want to mark this rule as deleted?');">Delete</a>
			<% end if %>
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
