<%
''''' Changelog
' Modified: <2012-03-22 Thu nathan>
' Description: We want to see the changes effective on util.dbo.z2t_ResearchDate; not just those effective on getdate()
'
' Modified: <2012-04-20 Fri nathan>
' Description: Prevent &nbsp; characters from making their way into the database. (Especially the JurCode field.)
'
%>
<%response.buffer=true%>


<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackOfficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/functions.asp"-->


<%


    dim JurTypeLabel
    dim JurSizeLabel
    dim JurTypeName(9)
    dim reqTaxType
    dim reqTaxTypeVariation
    dim reqJurType
    dim reqState
    dim reqCounty
    dim reqCity
	dim reqDistrict
    dim reqMainRowCnt
    dim reqSubRowCnt
    dim apsReqCounty
    dim apsReqCity
    dim escReqCounty
    dim escReqCity
	dim apsReqDistrict
    dim rateRow: rateRow = 0

    if Request("taxtype")="" OR isnull(Request("taxtype")) then
	  Response.Redirect "z2t_taxdata.asp"
    else
      reqTaxType = request("taxtype")
    end if

    if Request("taxTypeVariation")="" OR isnull(Request("taxTypeVariation")) then
	  Response.Redirect "z2t_taxdata.asp"
    else
      reqTaxTypeVariation = request("taxTypeVariation")
    end if

    if Request("jurtype")="" OR isnull(Request("jurtype")) then
	  Response.Redirect "z2t_taxdata.asp"
    else
      reqJurType = request("jurtype")
    end if

    if Request("state")="" OR isnull(Request("state")) then
	  Response.Redirect "z2t_taxdata.asp"
    else
      reqState = request("state")
    end if

    if Request("county")="" OR isnull(Request("county")) then
      reqCounty = ""
    else
      reqCounty = request("county")
    end if

    if Request("city")="" OR isnull(Request("city")) then
      reqCity = ""
    else
      reqCity = request("city")
    end if
	
	if Request("districtname")="" OR isnull(Request("districtname")) then
      reqDistrict = ""
    else
      reqDistrict = request("districtname")
    end if

    if Request("mainRowCnt")="" OR isnull(Request("mainRowCnt")) then
      reqMainRowCnt = ""
    else
      reqMainRowCnt = request("mainRowCnt")
    end if

    if Request("subRowCnt")="" OR isnull(Request("subRowCnt")) then
      reqSubRowCnt = ""
    else
      reqSubRowCnt = request("subRowCnt")
    end if

	apsReqCounty = replace(reqCounty,"'","''")
	apsReqCity = replace(reqCity,"'","''")
	apsReqDistrict =Replace(reqDistrict,"'","''")

	escReqCounty = Replace(reqCounty, "'", "&#39;")
	escReqCity = Replace(reqCity, "'", "&#39;")
	escReqDistrict =Replace(reqDistrict, "'", "&#39;")

    Dim rs
    Dim SQL
    Dim SQLHist
    Dim SQLCurr

    set rs = server.createObject("ADODB.Recordset")

    SQL="SELECT * FROM z2t_StateInfo " & _
        "WHERE [State] = '" & reqState & "' "

    rs.open SQL, connUpdateRates, 2, 3
        JurTypeName(1) = rs("JurType1")
        JurTypeName(2) = rs("JurType2")
        JurTypeName(3) = rs("JurType3")
        JurTypeName(4) = rs("JurType4")
        JurTypeName(5) = rs("JurType5")
        JurTypeName(6) = rs("JurType6")
        JurTypeName(7) = rs("JurType7")
        JurTypeName(8) = rs("JurType8")
        JurTypeName(9) = rs("JurType9")
    rs.close

    SQL="SELECT * FROM z2t_TaxData " & _
        "WHERE [TaxType] = " & reqTaxType & " " & _
        "AND [TaxTypeVariation] = " & reqTaxTypeVariation & " " & _
        "AND [JurType] = " & reqJurType & " " & _
        "AND [State] = '" & reqState & "' " & _
		"AND DeletedDate is null "

    if reqJurType > 1 then
        If reqCounty = "(Null)" Then
			SQL = SQL & "AND [County] is Null "
        ElseIf reqCounty = "(Blank)" Then
			SQL = SQL & "AND [County] = '' "
        Else
			SQL = SQL & "AND [County] = '" & apsReqCounty & "' "
        End If
    end if

    if reqJurType > 2 then
        If reqCity = "(Null)" Then
			SQL = SQL & "AND [City] is Null "
        ElseIf reqCity = "(Blank)" Then
			SQL = SQL & "AND [City] = '' "
        Else
			SQL = SQL & "AND [City] = '" & apsReqCity & "' "
        End If
    end if
	
	 if reqJurType > 3 then
        If reqDistrict = "(Null)" Then
			SQL = SQL & "AND [DistrictName] is Null "
        ElseIf reqDistrict = "(Blank)" Then
			SQL = SQL & "AND [DistrictName] = '' "
        Else
			SQL = SQL & "AND [DistrictName] = '" & apsReqDistrict & "' "
        End If
    end if

    SQLCurr = SQL & "AND datediff(day, [EffFrom], util.dbo.z2t_ResearchDate()) >= 0 " & _
	                "AND datediff(day, util.dbo.z2t_ResearchDate(), EffTo) >= 0" & _
                    "ORDER BY [EffTo] Desc"

	SQLHist = SQL & "ORDER BY [EffTo]"
	
    rs.open SQLCurr,connUpdateRates,2,3   'Get the most recent row

	select case reqJurType
    case 1
        JurTypeLabel = "State"
    case 2
        JurTypeLabel = "County"
    case 3
        JurTypeLabel = "City"
	case 4
		JurTypeLabel = "Specail District"
    end select

	if not rs.eof Then
		select case rs("JurSize")
		case 1
			JurSizeLabel = "State"
		case 2
			JurSizeLabel = "County"
		case 3
			JurSizeLabel = "City"
		case 4
			JurSizeLabel = "Special District"
		end select
	end if
	
	rs.close

%>

<html>
<head>
    <title>Zip2Tax.info Edit Tax Rates</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <style type="text/css">
        th {font-family: arial; color: black; font-size: 12}
        td {font-family: arial; color: black; font-size: 12}

	a.button {font-weight: bold; font-size: 9px; 
		font-family: Verdana, Arial, Helvetica, sans-serif;	
		padding: 4px 8px; 
		border-top: 1px solid #E0E0E0;
		border-right: 1px solid black; 
		border-bottom: 1px solid black;
		border-left: 1px solid #E0E0E0; 
		background-color: #FF0000; color: #FFFFFF;
		text-align: center; width: 100px;
		text-decoration: none;}

	a.button:hover {border-color: black white white black;}
    </style>

    <script language="JavaScript" src="<%=strPathDates%>checkDate.js" type="text/javascript"></script>
    <script language="JavaScript" src="<%=strPathDates%>ts_picker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

	var rid = '';
	var rcode = '';
	var rrate = '';
	var rtotal = '';
	var rfrom = '';
	var rto = '';
	var lastCode = '';
	var dirDates = '<%=strPathDates%>';
	var subFolder = '<%=strPathDates%>';  // used by the date picker

	//alert('hello');
	//var test = '<a href="javascript:show_calendar(' + document.getElementById('eTo') + 
	//        ', ' + document.getElementById('eTo').value + ');">' +
	//        '<img src="' + dirDates + 'cal.gif" width="16" height="16" border="0" alt="Calendar"></a>';

	//alert(test);


	function clickAdd(rr)
		{
		clickEdit(rr, 'Add');
		}

	function clickDelete(rr)
		{
		var id = document.getElementById('rID[' + rr + ']').innerHTML;

		document.getElementById('id').value = id;
		document.getElementById('action').value = 'Delete';
		document.frm.submit();
		}

	function clickEdit(rr, action)
		{
		getRowValues(rr);
		setMenus('');

		var initcode;
		
		//When adding a new row, carry forward the Code from the last row
		if (action == 'Add')
			initcode = lastCode;
		else
			initcode = rcode;
		
		//Set up active row
		document.getElementById('Code[' + rr + ']').innerHTML = 
			'<INPUT TYPE="Text" NAME="eCode" ID="eCode" ' +
			'Value="' + initcode + '" Size="8">';
		document.getElementById('Rate[' + rr + ']').innerHTML = 
			'<INPUT TYPE="Text" NAME="eRate" ID="eRate" ' +
			'Value="' + rrate + '" Size="4">';
		document.getElementById('Total[' + rr + ']').innerHTML = 
			'<INPUT TYPE="Text" NAME="eTotal" ID="eTotal" ' +
			'Value="' + rtotal + '" Size="4">';

		var initFrom;
		var initTo;
		
		if (rr > rateRows) {
			var d = new Date();
			var curr_day = d.getDate();
			var curr_month = d.getMonth() + 1;  //months are zero based
			var curr_year = d.getFullYear();
			initFrom = curr_month + "/" + curr_day + "/" + curr_year; 
			}
		else
			initFrom = rfrom;
			
		if (rr > rateRows)
			initTo = '12/31/2050';
		else
			initTo = rto;
			
		document.getElementById('From[' + rr + ']').innerHTML = 
			'<INPUT TYPE="Text" NAME="eFrom" ID="eFrom" ' +
			'Value="' + initFrom + '" Size="8"> ' +
			'<a href="javascript:show_calendar(\'frm.eFrom\', frm.eFrom.value);">' +
			'<img src="' + dirDates + 'cal.gif" width="16" height="16" border="0" alt="Calendar"></a>';
		document.getElementById('To[' + rr + ']').innerHTML = 
			'<INPUT TYPE="Text" NAME="eTo" ID="eTo" ' +
			'Value="' + initTo + '" Size="8"> ' +
			'<a href="javascript:show_calendar(\'frm.eTo\', frm.eTo.value);">' +
			'<img src="' + dirDates + 'cal.gif" width="16" height="16" border="0" alt="Calendar"></a>';
		document.getElementById('Menu[' + rr + ']').innerHTML = 
			'<a href="javascript:clickEditCancel(' + rr + ');">Cancel</a> ' +
			'<a href="javascript:clickEditSave(' + rr + ');">Save</a>';

		document.getElementById('eCode').focus();
		}

	//        '<a href="javascript:show_calendar(' + document.getElementById('eTo') + 
	//        ', ' + document.getElementById('eTo').value + ');">' +

	function clickEditCancel(rr)
		{
		returnRowValues(rr);
		setMenus('Edit');
		}

	function clickEditSave(rr)
		{
		if (checkStartDate() && checkEndDate())
			{
			var action;
			var id = document.getElementById('rID[' + rr + ']').innerHTML;
			
			if (id == '')
				{
				id = 0;
				action = "Add";
				}
			else
				action = "Update";

			document.getElementById('id').value = id;
			document.getElementById('action').value = action;
			document.frm.submit();
			}
		}

	function getRowValues(rr)
		{
		rid = document.getElementById('rID[' + rr + ']').innerHTML;
		rcode = document.getElementById('Code[' + rr + ']').innerHTML;
		rrate = document.getElementById('Rate[' + rr + ']').innerHTML;
		rtotal = document.getElementById('Total[' + rr + ']').innerHTML;
		rfrom = document.getElementById('From[' + rr + ']').innerHTML;
		rto = document.getElementById('To[' + rr + ']').innerHTML;
		}

	function returnRowValues(rr)
		{
		document.getElementById('rID[' + rr + ']').innerHTML = rid;
		document.getElementById('Code[' + rr + ']').innerHTML = rcode;
		document.getElementById('Rate[' + rr + ']').innerHTML = rrate;
		document.getElementById('Total[' + rr + ']').innerHTML = rtotal;
		document.getElementById('From[' + rr + ']').innerHTML = rfrom;
		document.getElementById('To[' + rr + ']').innerHTML = rto;
		}

	function setMenus(s)
		{
		if (s == 'Edit')
			{
			for (var i = 1; i <= rateRows; i++)
				{ 
				document.getElementById('Menu[' + i + ']').innerHTML =
					'<a href="javascript:clickEdit(' + i + ', \'Edit\');">Edit</a>' + ' ' +
					'<a href="javascript:clickDelete(' + i + ');" onClick="return confirm(\'Are you sure you want to delete this row?\');">Delete</a>';
				}
			document.getElementById('Menu[' + (rateRows + 1) + ']').innerHTML =
				'<a href="javascript:clickAdd(' + (rateRows + 1) + ');">Add</a>';
			}
		else
			{
			for (var i = 1; i <= rateRows + 1; i++)
				{ 
				document.getElementById('Menu[' + i + ']').innerHTML = '';
				}
			}
		}

		function checkStartDate()
		  {
		  var d = document.getElementById('eFrom');
		  if (d.value.length != 0) 
			{
			if (isDate(d.value)==false)
			  {
				d.focus()
				return false
			  }
			return true
			}
			alert('Please enter a start date');
			d.focus()
			return false
		  }    

		function checkEndDate()
		  {
		  var d = document.getElementById('eTo');
		  if (d.value.length != 0) 
			{
			if (isDate(d.value)==false)
			  {
				d.focus()
				return false
			  }
			return true
			}
			alert('Please enter an end date');
			d.focus()
			return false
		  }    
	</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" 
	marginwidth="0" marginheight="0" 
	link="#333366" vlink="#333366" alink="#3399FF">
    <%
	'response.Write(SQLHist)
	'response.End()
	%>

<form method="post" action="z2t_TaxData_Post.asp" name="frm">

<input type='hidden' id='taxType'    name='taxType'    value='<%=reqTaxType%>'>
<input type='hidden' id='taxTypeVariation' name='taxTypeVariation' value='<%=reqTaxTypeVariation%>'>
<input type='hidden' id='jurType'    name='jurType'    value='<%=reqJurType%>'>
<input type='hidden' id='state'      name='state'      value='<%=reqState%>'>
<input type='hidden' id='county'     name='county'     value='<%=escReqCounty%>'>
<input type='hidden' id='city'       name='city'       value='<%=escReqCity%>'>
<input type='hidden' id='districtname'       name='districtname'       value='<%=escReqDistrict%>'>
<input type='hidden' id='id'         name='id'         value=''>
<input type='hidden' id='action'     name='action'     value=''>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td align="center">
            <table width="100%" border="0" cellspacing="10" cellpadding="0" align="center">

              <tr>
                <th>
                  <font size="4">
                    Edit Tax Rates 
					<br>for 
					<%
					'response.write(reqDistrict) 
					if reqJurType="3" then 
						response.write(reqCity) & ", "
					end if
					
					if reqJurType >= "2" then 
						response.write(reqCounty) & " County, "
					end if
					if reqJurType="4" then 
						response.write(reqCity & ", " & reqDistrict &", ")
					end if

					response.write(reqState)
					
					if reqMainRowCnt > "" then
						if reqMainRowCnt = "0" then
							response.write("<p style='color:red'><font size='3'>")
						else
							response.write("<p style='color:blue'><font size='3'>")
						end if
						
						if cint(reqMainRowCnt) = 1 then
							response.write("1 row was processed for this " & LCase(JurTypeLabel) & ".")
						else
							response.write(reqMainRowCnt & " rows were processed for this " & LCase(JurTypeLabel) & ".")
						end if

						if reqSubRowCnt > "0" then
							response.write("<br>")
							
							if cint(reqSubRowCnt) = 1 then
								response.write("The Total rate on 1 underlying row was also adjusted.")
							else
								response.write("The Total rates on " & reqSubRowCnt & " underlying rows were also adjusted.")
							end if
						end if

						response.write("</font></p>")
					end if
					%>
                  </font>
                </th>
              </tr>

            </table>	

            <table width="90%" border="1" cellspacing="2" cellpadding="0" align="center">
              <tr>
                <th>
                  Tax Type
                </th>
                <th>
                  Jurisdiction
                </th>
                <th>
                  Size
                </th>
              </tr>

              <tr>
                <td width="33%" align="center">
					<%If reqTaxType = "1" Then%>
						Sales Tax
					<%ElseIf reqTaxType = "2" Then%>
						Use Tax
					<%ElseIf reqTaxType = "3" Then%>
						Automobile Tax
					<%ElseIf reqTaxType = "4" Then%>
						Auto Rental Tax
					<%ElseIf reqTaxType = "5" Then%>
						Alcohol Tax
					<%End If%>
				</td>
                <td width="33%" align="center">
                  <%=JurTypeLabel%>
                </td>
                <td width="33%" align="center">
                  <%=JurSizeLabel%>
                </td>
              </tr>
            </table>	

            <br><br>

            <table width="90%" border="1" cellspacing="2" cellpadding="0" align="center">
              <tr>
                <th></th>
                <th>
                  Name
                </th>
                <th>
                  Jurisdiction Rate
                </th>
              </tr>

<%
    for i=1 to 9
        if i <= cInt(reqJurType) then
%>           
              <tr>
                <td width="33%" align="center">
                  Jurisdiction # <%=i%>  
                </td>
                <td width="33%" align="center">
                  <%=JurTypeName(i)%>
                </td>
                <td width="33%" align="center">
<%
                SQL = "Select JurRate from z2t_TaxData " & _
				      "WHERE [TaxType] = " & reqTaxType & " " & _
				      "AND [TaxTypeVariation] = " & reqTaxTypeVariation & " " & _
				      "AND [JurType] = " & i & " " & _
				      "AND [EffFrom] <= util.dbo.z2t_ResearchDate() " & _
					  "AND datediff(day, util.dbo.z2t_ResearchDate(), EffTo) > 1" & _
					  "AND DeletedDate is null " & _
				      "AND [State] = '" & reqState & "' "
				
				If i > 1 Then
					If reqCounty = "(Null)" Then
						SQL = SQL & "AND [County] is Null "
					ElseIf reqCounty = "(Blank)" Then
						SQL = SQL & "AND [County] = '' "
					Else
						SQL = SQL & "AND [County] = '" & apsReqCounty & "' "
					End If
				End If

				If i > 2 Then
					If reqCity = "(Null)" Then
						SQL = SQL & "AND [City] is Null "
					ElseIf reqCity = "(Blank)" Then
						SQL = SQL & "AND [City] = '' "
					Else
						SQL = SQL & "AND [City] = '" & apsReqCity & "' "
					End If
				End If
				
				 if reqJurType > 3 then
			        If reqDistrict = "(Null)" Then
						SQL = SQL & "AND [DistrictName] is Null "
			        ElseIf reqDistrict = "(Blank)" Then
						SQL = SQL & "AND [DistrictName] = '' "
			        Else
						SQL = SQL & "AND [DistrictName] = '" & apsReqDistrict & "' "
			        End If
			    end if

				rs.open SQL, connUpdateRates, 2, 3

				If rs.eof Then 
					Response.write "--"
				Else
					Response.write rs("JurRate")
				End If

				rs.close
%>
                </td>
              </tr>
<%
        end if
    next
%>
            </table>	

            <br><br>

            <table width="90%" border="1" cellspacing="2" cellpadding="0" align="center">
              <tr>
                <th width="10%">
                  ID
                </th>
                <th width="11%">
                  Code
                </th>
                <th width="11%">
                  Rate
                </th>
                <th width="11%">
                  Total
                </th>
                <th width="19%">
                  From
                </th>
                <th width="19%">
                  To
                </th>
                <th width="19%">
                  Menu
                </th>
              </tr>

<%
    rs.open SQLHist,connUpdateRates,2,3   'Get all rows in ascending order

    while not rs.eof
        rateRow = rateRow + 1
		
		'If FromDate > ToDate, the row is typically ignored by queries. It may be preferable to mark it as deleted.
		If cDate(iisNull(rs("EffFrom"))) > cDate(iisNull(rs("EffTo"))) Then
			DateColor = "red"
		Else
			DateColor = "black"
		End If
%>
              <tr>
                <td align="center">
                  <span id="rID[<%=rateRow%>]"><%=iisNull(rs("ID"))%></span>
                </td>
                <td align="center">
                  <span id="Code[<%=rateRow%>]"><%=iisNull(rs("JurCode"))%></span>
                </td>
                <td align="center">
                  <span id="Rate[<%=rateRow%>]"><%=iisNull(rs("JurRate"))%></span>
                </td>
                <td align="center">
                  <span id="Total[<%=rateRow%>]"><%=iisNull(rs("Rate"))%></span>
                </td>
                <td align="center">
                  <span id="From[<%=rateRow%>]" style="color:<%=DateColor%>"><%=iisNull(rs("EffFrom"))%></span>
                </td>
                <td align="center">
                  <span id="To[<%=rateRow%>]" style="color:<%=DateColor%>"><%=iisNull(rs("EffTo"))%></span>
                </td>
                <td align="center">
                  <span id="Menu[<%=rateRow%>]">
                    <a href="javascript:clickEdit(<%=rateRow%>, 'Edit');">Edit</a>
                    <a href="javascript:clickDelete(<%=rateRow%>);" onClick="return confirm('Are you sure you want to delete this row?');">Delete</a>
                  </span>
                </td>
              </tr>

			  <script language="javascript" type="text/javascript">
				lastCode = '<%=replace(iisNull(rs("JurCode")), "'", "\'")%>';
			  </script>
<%
        rs.movenext
    wend
	
	rs.close
    rRow = rateRow + 1
%>
              <tr>
                <td align="center">
                  <span id="rID[<%=rRow%>]"></span>
                </td>
                <td align="center">
                  <span id="Code[<%=rRow%>]"></span>
                </td>
                <td align="center">
                  <span id="Rate[<%=rRow%>]"></span>
                </td>
                <td align="center">
                  <span id="Total[<%=rRow%>]"></span>
                </td>
                <td align="center">
                  <span id="From[<%=rRow%>]"></span>
                </td>
                <td align="center">
                  <span id="To[<%=rRow%>]"></span>
                </td>
                <td align="center">
                  <span id="Menu[<%=rRow%>]">
                    <a href="javascript:clickAdd(<%=rRow%>);">Add</a>
                  </span>
                </td>
              </tr>

            </table>	

            <br><br>

            <table width="90%" border="0" cellspacing="2" cellpadding="0" align="center">
              <tr>
                <td Align="center">
                  <a href="javascript:window.close();">Close Window</a>
                </td>
              </tr>
            </table>

          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>

<script language="javascript" type="text/javascript">
	var rateRows = <%=rateRow%>;
</script>

</body>
</html>
