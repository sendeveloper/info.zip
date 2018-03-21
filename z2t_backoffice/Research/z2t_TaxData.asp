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

<%

    Dim strSQL
    Dim rs
        Dim strTaxType
        Dim strTaxTypeVariation
        Dim strState
        Dim strCounty
		Dim SQLCounty
		Dim strDistrictname
		Dim SQLDistrictname        
        Dim strDisplayType
        Dim ForPrinting
        
    Set rs = Server.CreateObject("ADODB.Recordset")

    If trim(Request("taxType")) = "" or isnull(Request("taxType")) then
        strTaxType = 1
    Else
        strTaxType = Request("taxType")
    End If

    If trim(Request("taxTypeVariation")) = "" or isnull(Request("taxTypeVariation")) then
                strTaxTypeVariation = 0
    Else
        strTaxTypeVariation = Request("taxTypeVariation")
    End If

    If trim(Request("state")) = "" or isnull(Request("state")) then
                strState = "NY"
    Else
        strState = Request("state")
    End If

    If trim(Request("displayType")) = "" or isnull(Request("displayType")) then
        strDisplayType = "2"
    Else
        strDisplayType = Request("displayType")
    End If
        
    If trim(Request("county")) = "" or isnull(Request("county")) then
        strCounty = ""
    Else
        strCounty = Request("county")
    	End If
        
        SQLCounty = replace(strCounty,"'","''")
	
	 If trim(Request("districtname")) = "" or isnull(Request("districtname")) then
        strDistrictname = ""	
    Else
        strDistrictname = Request("districtname")
    End If
        
        SQLDistrictname = replace(strDistrictname,"'","''")
		
        
        If isnull(Request("forPrinting")) or Request("forPrinting") <> "True" then
                ForPrinting = False
        Else
                ForPrinting = True
        End If
%>

<html>
<head>
    <title>Zip2Tax.info Research Data</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
    <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

<%If ForPrinting Then%>
        <style>
                body, .divDeskTop, .divDeskMiddle, .divDeskBottom
                  { background:url();
                        background-color: white; }
                th {color: black;}
                .white {color: black;}
                a.white {color: black;}
        </style>
<%End If%>

        <script language="javascript" type = "text/javascript">

    function getState()
        {
                document.getElementById('county').value = '';
                document.frm.submit();
        }

        function collapseCounty()
                {
                document.getElementById('county').value = '';
                document.frm.submit();
                }
				
		function expandCounty(strCounty)
                {
                document.getElementById('county').value = strCounty;
                document.frm.submit();
                }
		
		function collapseCountyDist()
				{
				document.getElementById('county').value = '';
				document.getElementById('districtname').value='';
                document.frm.submit();
				}
				
        function expandCountyDist(strCounty,strDistrictName)
                {
                document.getElementById('county').value = strCounty;
				document.getElementById('districtname').value= strDistrictName;
                document.frm.submit();
                }


        

        function printable(v)
                {
                document.getElementById('forPrinting').value = v;
                document.frm.submit();
                }
        </script>

</head>


<%
    PageHeading = "Research Data"
    ColorTab = 3
%>

<body>

  <form Method="Get" Action="z2t_TaxData.asp" Name="frm">
    <input type="hidden" id="county" name="county" value="<%=SQLCounty%>" />
    <input type="hidden" id="districtname" name="districtname" value="<%=SQLDistrictname%>" />
    <input type="hidden" id="forPrinting" name="forPrinting" value="<%=ForPrinting%>" />

  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
        <table width="95%" border="0" cellspacing="1" cellpadding="0" align="center">
          <tr valign="top">
            <td colspan="2" align="center">
              <table width="100%" border="1" cellspacing="5" cellpadding="5" align="center">
                <tr>
                  
                  <td width="15%" align="center">                  
                    <b>Tax Type:</b>
                    <select ID="taxType" name="taxType" onChange="getState();">

<%


                        strSQL = "util_HTML_option_list('z2t_types', 'class', 'TaxType', " & _
                                "'value', 'description', 'sequence', '', '" & strTaxType & "')"
                        rs.open strSQL, connBackoffice, 3, 3, 4

                        If not rs.eof Then
                                While not rs.eof
                                  Response.Write vbCrLf & rs("Result")
                                  rs.movenext
                                Wend
                        End If

                        rs.close
%>

                                        </select>
                                  </td>

                                  <td width="20%" align="center">
                                        <b>Tax Type Variation:</b>
                                        <select ID="taxTypeVariation" name="taxTypeVariation" onChange="getState();">

<%
                        strSQL = "util_HTML_option_list('z2t_types', 'class', 'TaxTypeVariation', " & _
                                "'value', 'description', 'sequence', '', '" & strTaxTypeVariation & "')"


                        rs.open strSQL, connBackoffice, 3, 3, 4

                        If not rs.eof Then
                                While not rs.eof
                                  Response.Write vbCrLf & rs("Result")
                                  rs.movenext
                                Wend
                        End If

                        rs.close
%>

                                        </select>
                                  </td>

                                  <td width="15%" align="center">
                                        <b>State:</b>
                                        <select name="state" id="state" onChange="getState();">

<%
                                        'strSQL = "SELECT Distinct([State]) from z2t_taxdata " & _
                                        '    "WHERE [JurType] = 1 " & _
                                        '    "ORDER BY [State]"
                                        'rs.open strSQL, connUpdateRates, 2, 3

                                        strSQL = "Select Distinct S.[State], S.[Name] " & _
                                                 "From z2t_StateInfo S, " & _
                                                         "     z2t_TaxData T " & _
                                                 "Where S.[State] = T.[State] " & _
                                                         "Order by S.[Name] "

                                        rs.open strSQL, connUpdateRates,2,3

                                        Do Until rs.eof
                                                If rs("State") = strState Then
                                                        selected = " Selected=""Selected"""
                                                Else
                                                        selected = ""
                                                End If

                                                Response.write "<OPTION value=""" & rs("State") & """" & Selected & ">"

                                                If rs("Name") = "APO/FPO" Then
                                                        Response.write rs("Name") & " (" & rs("State") & ")"
                                                Else
                                                        Response.write rs("Name")
                                                End If

                                                Response.write "</OPTION>" & vbCrLf

                                                rs.movenext
                                                Loop
                                        
                                        rs.close
%>
                                        </select>
                                  </td>

                                  <td width="10%" align="center">
                                        <b>Display Type:</b>
                                        <select ID="displayType" name="displayType" onChange="getState();">
                                                <option value="1" <%If strDisplayType = "1" Then%>selected<%End If%>>By City</option> 
                                                <option value="2" <%If strDisplayType = "2" Then%>selected<%End If%>>Mixed</option> 
                                                <option value="3" <%If strDisplayType = "3" Then%>selected<%End If%>>Special Districts</option> 
                                              
                                        </select>
                                  </td>
<%
                                        strSQL = "SELECT [Rate], [EffFrom], [EffTo] from z2t_taxdata " & _
                                                "WHERE [JurType] = 1 " & _
                                                "AND [TaxType] = " & strTaxType & _
                                                "AND [TaxTypeVariation] = " & strTaxTypeVariation & _
                                                "AND [State] = '" & strState & "' " & _
                                            "AND [EffFrom] <= util.dbo.z2t_ResearchDate() " & _
                                            "AND DATEADD(day, 1, EffTo) > util.dbo.z2t_ResearchDate() " & _
                                                "AND DeletedDate is null " & _
                                                "ORDER BY [EffFrom] Desc"
                                        rs.open strSQL,connUpdateRates,2,3

                                        If rs.eof Then

                                        Else
%>
                                  <td width="10%" align="center">
                                        Rate = <%=rs("Rate")%>          
                                  </td>
                                  <td width="10%" align="center">
                                        From = <%=rs("EffFrom")%>          
                                  </td>
                                  <td width="10%" align="center">
                                        To = <%=rs("EffTo")%>          
                                  </td>
                                  <td width="10%" align="center">
                                        <a href="javascript:window.open('z2t_TaxData_Edit.asp?taxType=<%=strTaxType%>&taxTypeVariation=<%=strTaxTypeVariation%>&jurType=1&state=<%=strState%>',
                                          '','scrollbars=yes,fullscreen=no,resizable=yes, 
                                          height=500,width=720,left=150,top=50');void(0)">
                                        View</a>
                                  </td>
<%
                                  End If
                                rs.close
%>
                                </tr>
            			</table>
                  </td>
                </tr>
      </table>
<br/>
      <table width="95%" border="1" cellspacing="1" cellpadding="1" align="center">
        <tr bgColor="white">

<%
            'First get the line count
            strSQL = "z2t_TaxData_County_list (" & _
                strTaxType & ", " & _
                strTaxTypeVariation & ", " & _
                "'" & strState & "', "
                        
            If strDisplayType = "1" Then
              strSQL = strSQL & "1, Null,NULL,NULL, 1)"
			ElseIf strDisplayType ="3" AND SQLCounty > "" Then
			  strSQL = strSQL & "5, '" & SQLCounty & "',NULL,NULL, 1)"
			ElseIf strDisplayType ="3" Then  
			  strSQL = strSQL & "4, Null,NULL,NULL, 1)"
            ElseIf SQLCounty = "(Null)" Then
              strSQL = strSQL & "3, Null,NULL,NULL, 1)"
            ElseIf SQLCounty = "(Blank)" Then
              strSQL = strSQL & "3, '',NULL,NULL, 1)"
            ElseIf SQLCounty > "" Then
              strSQL = strSQL & "3, '" & SQLCounty & "',NULL,NULL, 1)"
            Else
              strSQL = strSQL & "2, '',NULL,NULL, 1)"
            End IF

            
			'Response.Write (strSQL)
            'Response.End

            rs.open strSQL, connUpdateRates, 3, 3, 4

            totCount = rs("Count")
            rs.close


            'Now get the data
            strSQL = "z2t_TaxData_County_list (" & _
                strTaxType & ", " & _
                strTaxTypeVariation & ", " & _
                "'" & strState & "', "

             If strDisplayType = "1" Then
              strSQL = strSQL & "1,NULL, Null,NULL, 0)"
			ElseIf strDisplayType ="3" AND SQLCounty > "" Then
			  strSQL = strSQL & "5, '" & SQLCounty & "',NULL,'NULL', 0)"
			ElseIf strDisplayType ="3" Then  
			  strSQL = strSQL & "4, Null,NULL,NULL, 0)"
            ElseIf SQLCounty = "(Null)" Then
              strSQL = strSQL & "3, Null,NULL,NULL, 0)"
            ElseIf SQLCounty = "(Blank)" Then
              strSQL = strSQL & "3, '',NULL,NULL, 0)"
            ElseIf SQLCounty > "" Then
              strSQL = strSQL & "3, '" & SQLCounty & "',NULL,NULL, 0)"
            Else
              strSQL = strSQL & "2, '',NULL,NULL, 0)"
            End IF
                        
            'strSQL = "z2t_TaxData_County_list (1, 0, '" & strState & "', 2, '" & SQLCounty & "', 0)"
			'response.Write(strSql)
			'response.End()	
            rs.open strSQL, connUpdateRates, 3, 3, 4


            If int(totCount/3) <> totCount/3 Then
                c1 = int(totCount/3) + 1
            Else
                c1 = totCount/3
             End If
            c2 = c1 * 2

            lineCount = 0
            response.write "<td width='390' vAlign='top'>"
            response.write ColumnHeads
            for i = 1 to c1
              call getRow(lineCount)
            next
            response.write "</table>"
            response.write "</td>"

            lineCount = 0
            response.write "<td width='390' vAlign='top'>"
            response.write ColumnHeads
            for i = c1 + 1 to c2
              call getRow(lineCount)
            next
            response.write "</table>"
            response.write "</td>"

            lineCount = 0
            response.write "<td width='390' vAlign='top'>"
            response.write ColumnHeads
            for i = c2 + 1 to totCount
              call getRow(lineCount)
            next
            response.write "</table>"
            response.write "</td>"

            rs.close
%>      
<br/>

        <table width="95%" style="font-weight:bold;text-align:center;padding-top:15px;">
        <tr>
        <td>
                  Count: <%=totCount%> <br>

        </td>
		<td>
              Selected County: <%=strCounty%> <br>
      <%
	  	 If strDisplayType="3" Then 
	  		Response.Write "Selected Special District:"& strDistrictName  & "<br>"

	  End If%>

        </td>
        
        </tr>
        <tr>
        <td>
              State: <%=strState%> <br>
        </td>
        <td>
              TaxType: <%=strTaxType%> <br>
        </td>
        </tr>
        <tr>
        <td>
              TaxTypeVariation: <%=strTaxTypeVariation%> <br>
        </td>
        <td>
           <%If ForPrinting Then%>
                <a href="javascript:void(0)" onClick="printable('False');">Back to Regular Website</a><br>
          <%Else%>
                <a  href="javascript:void(0)" onClick="printable('True');">Printable Version</a><br>
          <%End If%>
        </td>
        </tr>
        </table>

    
  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
</form>
</body>
</html>

<%
    Public Sub getRow(lineCount)
        if not rs.eof then
            lineCount = lineCount + 1
            If lineCount mod 3 = 0 then
                bgColor = "EEEEEE"
            Else
                bgColor = "FFFFFF"
            End If

            'response.write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vbCRLF
            response.write "  <tr bgColor=" & bgColor & ">" & vbCRLF
            
                        Dim rsCity
                        Dim rsCounty
						Dim rsDistrictName
                        Dim abbrCity
                        Dim abbrCounty
						Dim abbrDistrictName
						Dim escDistrictName						
                        Dim escCounty

                        If rs("City") = "" Then
                                rsCity = "(Blank)"  'So the blank city name won't appear to be missing from the URL  
                        ElseIf isNULL(rs("City")) Then
                                rsCity = "(Null)"   'So we can pass a null within a URL parameter
                        Else
                                rsCity = rs("City")
                        End If

                        If rs("County") = "" Then
                                rsCounty = "(Blank)"  'So the blank county name won't appear to be missing from the URL
                        ElseIf isNULL(rs("County")) Then
                                rsCounty = "(Null)"   'So we can pass a null within a URL parameter
                        Else
                                rsCounty = rs("County")
                        End If
						
						If  strDisplayType = "3"  Then
							If rs("DistrictName") = "" Then
    	                        rsDistrictName = "(Blank)"  'So the blank county name won't appear to be missing from the URL
        	                ElseIf isNULL(rs("DistrictName")) Then
                                rsDistrictName = "(Null)"   'So we can pass a null within a URL parameter
            	            Else
                                rsDistrictName = rs("DistrictName")
                	        End If
						End If
						

                        abbrCity = rsCity
                        abbrCounty = rsCounty
						abbrDistrictName = rsDistrictName
                        escCounty = replace(rsCounty, "'", "\'" )
						escDistrictName = replace(rsDistrictName, "'", "\'" )
                        
                        If strDisplayType = "1" Then   'By City
                                If Len(rs("County")) > 10 Then
                                        abbrCounty = Left(rs("County"), 8) & "..."
                                End If
						ElseIf strDisplayType = "3" Then 'By Disitrict 								
								If Len(rs("City")) > 40 Then
                                        abbrCity = Left(rs("City"), 38) & "..."
                                End If
								If Len(rs("DistrictName")) > 11 Then
                                        abbrDistrictName = Left(rs("DistrictName"), 10) & "..."
                                End If
								
                        Else  'Mixed
                                If Len(rs("City")) > 40 Then
                                        abbrCity = Left(rs("City"), 38) & "..."
                                End If
                        End If
                        
                        If strDisplayType = "2" or strDisplayType = "3" Then  'Mixed - show plus/minus icons
                                response.write "    <td align='center'>" & vbCRLF
                                if rs("JurType") = "2" and rs("MaxJurType") = "3" then
                                        if rsCounty = strCounty then   'This county is being expanded
                                                response.write " <img src='" & strPathImages & "minus.png' onClick=""collapseCounty();"">" & vbCRLF
                                        else
                                                response.write " <img src='" & strPathImages & "plus.png' onClick=""expandCounty('" & escCounty & "');"">" & vbCRLF
                                        end if
                                end if
                                response.write "    </td>" & vbCRLF
                        End If
						
						
											
                        If strDisplayType = "1" Then  'By City
                                response.write "    <td nowrap>" & abbrCounty & "</td>" & vbCRLF
                                response.write "    <td nowrap>" & rsCity & "</td>"
                        Else   'Mixed - show county or city row
                                If rs("JurType") = "2" Then
                                        response.write "    <td colspan=2>" & rsCounty & " </td>" & vbCRLF
                                Else
                                        response.write "    <td />" & vbCRLF
                                        response.write "    <td nowrap>" & abbrCity & " </td>" & vbCRLF
                                End If
						
								
                        End If
						
						If strDisplayType = "3"  then
							If  (NOT isNull(rs("DistrictName"))) and len(abbrDistrictName) > 1 Then
							  response.write "    <td title='" & rs("DistrictName") &"' nowrap>" & abbrDistrictName & " </td>" & vbCRLF
						 	Else
							  response.write "    <td >&nbsp;  </td>" & vbCRLF
							End If								 
						End If
                        
            response.write "    <td align=""right"">" & vbCRLF
            response.write "      " & rs("JurRate") & vbCRLF
            response.write "    </td>" & vbCRLF
            response.write "    <td align=""right"">" & vbCRLF
            response.write "      " & rs("Rate") & vbCRLF
            response.write "    </td>" & vbCRLF
            response.write "    <td align=""center"">" & vbCRLF
            response.write "      " & rs("JurCode") & vbCRLF
            response.write "    </td>" & vbCRLF
            response.write "    <td align=""center"">" & vbCRLF
                        
                        'See if this row actually exists on the table and can be edited.
                        'JurType is the current item's hierarchy level (e.g. 2=county).
                        'MinJurType is the same as JurType if the item exists on the database. Otherwise it's the next available level under this one.
						'For example, if the county-level row is missing, but there are city-level rows within this county, then MinJurType will be 3 (city).
                        If rs("JurType") = rs("MinJurType") Then
                                If ForPrinting Then
                                        ButtonClass = ""
                                Else
                                        ButtonClass = "class='buttonEdit'"
                                End If
                                'The county and city need to be URLEncoded twice.  They'll be decoded first by the href when this is clicked, and then again when the javascript requests the ASP page.
								If  strDisplayType = "3" Then
									 If	len(rsDistrictName) > 1  Then
								
								response.write "      <a href=""javascript:window.open('z2t_TaxData_Edit.asp?taxType=" & strTaxType & "&taxTypeVariation=" & strTaxTypeVariation & "&jurType=4&state=" & strState & "&county=" & Server.URLEncode(Server.URLEncode(rsCounty)) & "&city=" & Server.URLEncode(Server.URLEncode(rsCity)) & "&districtname=" & Server.URLEncode(Server.URLEncode(rsDistrictName)) & "', '','scrollbars=yes,fullscreen=no,resizable=yes, height=500,width=720,left=150,top=50');void(0)"" " & ButtonClass & ">Edit</a>" & vbCRLF
								
									Else
								
								
                                response.write "      <a href=""javascript:window.open('z2t_TaxData_Edit.asp?taxType=" & strTaxType & "&taxTypeVariation=" & strTaxTypeVariation & "&jurType=" & rs("JurType") & "&state=" & strState & "&county=" & Server.URLEncode(Server.URLEncode(rsCounty)) & "&city=" & Server.URLEncode(Server.URLEncode(rsCity)) & "', '','scrollbars=yes,fullscreen=no,resizable=yes, height=500,width=720,left=150,top=50');void(0)"" " & ButtonClass & ">Edit</a>" & vbCRLF
									End If
								
								Else
							response.write "      <a href=""javascript:window.open('z2t_TaxData_Edit.asp?taxType=" & strTaxType & "&taxTypeVariation=" & strTaxTypeVariation & "&jurType=" & rs("JurType") & "&state=" & strState & "&county=" & Server.URLEncode(Server.URLEncode(rsCounty)) & "&city=" & Server.URLEncode(Server.URLEncode(rsCity)) & "', '','scrollbars=yes,fullscreen=no,resizable=yes, height=500,width=720,left=150,top=50');void(0)"" " & ButtonClass & ">Edit</a>" & vbCRLF				
								
								End If
                        End If
                        
                        response.write "    </td>" & vbCRLF
            response.write "  </tr>" & vbCRLF
            'response.write "</table>" & vbCRLF
            rs.movenext
        end if
    End Sub

    Public Function ColumnHeads
        c = "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vbCRLF
        
                If ForPrinting Then
                        c = c & "  <tr bgColor='#EEEEEE'>" & vbCRLF
                Else
                        c = c & "  <tr bgColor='#DD0000'>" & vbCRLF
                End If
       
        		if strDisplayType = "3" Then 
					 c = c & "    <th width='2%' align='left'></th>" & vbCRLF
				End If
				
                If strDisplayType = "2" Then  'Mixed - include plus/minus icon column
                        c = c & "    <th width='2%' align='left'></th>" & vbCRLF
                        c = c & "    <th width='10%' align='left'>County</th>" & vbCRLF
                Else
                        c = c & "    <th width='12%' align='left'>County</th>" & vbCRLF
                End If
                
        c = c & "    <th width='12%' align='left'>City</th>" & vbCRLF
		
		 		If strDisplayType = "3" Then					
						c = c & "    <th width='12%' align='left'>Special District</th>" & vbCRLF
				End If
						
        c = c & "    <th width='10%' align='right'>Rate</th>" & vbCRLF
        c = c & "    <th width='14%' align='right'>Total</th>" & vbCRLF
        c = c & "    <th width='15%'>Code</th>" & vbCRLF
        c = c & "    <th width='10%'></th>" & vbCRLF
        c = c & "  <tr>" & vbCRLF
        ColumnHeads = c
    End Function
%>
