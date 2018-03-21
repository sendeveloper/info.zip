<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/Subscribers/PopUps/includes/z2t_TableDownloadReportHeading.inc"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->



<%
  PageHeading = "Table Download Report"
  ColorTab = 3
  
  OrderBy = Request("orderBy")
  If isnull(Request("orderBy")) or Request("OrderBy") = "" then
		OrderBy = "DownloadDate"
	Else
		OrderBy = Request("orderBy")

	End If
	
		AscDesc = request("ascDesc")
		If LCase(request("ascDesc")) = "a" Then
			AscDescSQL = " Asc"
			AscDesc="a"
			
			ElseIf LCase(request("ascDesc")) = "d" Then
			AscDescSQL = " Desc"
			AscDesc = "d"
	   Else
	   			AscDesc = "d"
	   
		End If
  
'  response.Write(AscDesc)
 ' response.End()

%>

<html>
<head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  
  <script language='JavaScript'>
  
  
	function generateReport(){
		
			//alert(DateFrom.value);
		if (document.frm.DateFrom.value.length < 1 || document.frm.DateTo.value.length < 1) 
			{
				alert("Please provide date range to generate report.");
				return false;
			}
		else
		{
			
		document.frm.submit();
		}
	}
	
		function sortFrm(fld, ascDesc)
			{
				//alert(fld);
			document.getElementById('orderBy').value = fld;
			document.getElementById('ascDesc').value = ascDesc;
			document.frm.submit();
			}
		
		function printversion(DateFrom,DateTo,statusval,OrderBy,AscDescSQL)
		{
			//alert(DateFrom);
			if (DateFrom.length < 1 || DateTo.length < 1) 
			{
				alert("Please first generate report to view its print version.");
				return false;
			}
			else{
				var URL
				URL = 'z2t_TableDownloadReport_print.asp' +
				'?DateFrom=' + DateFrom + '&DateTo=' + DateTo +
				 '&statusval=' + statusval + '&OrderBy=' +
				  OrderBy + '&AscDescSQL=' + AscDescSQL;			
				openPopUp(URL);
				}
		}
		
  </script>
  
  <style type="text/css">   
    .stateList td 
		{
		font-size: 10pt;
		background-color: white;
		}
    .stateList th
		{
		color: white;
		font-weight: bold;
		font-size: 10pt;
		text-align: center;
		background-color:  #990000;
		}
	.tdwidth30
		{
		width:30px !important;	
		}
	.tdwidth100
		{
		width:100px !important;	
		}
  </style>
  
</head>

<body>

<form name="frm" action="z2t_TableDownloadReport.asp" method="post"  style="margin-bottom:0px !important;" >
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->				
				  <tr><td>&nbsp;</td></tr>
                  <tr valign="top">
                   
                   	<td width="4%" style="vertical-align: middle;">
                   		<b>Date:</b>
                   	</td>
                 
				  	<td align="left" width="2%" style="vertical-align: middle;" >
                    	From                    	
				  	</td>
                  	<td align="left" width="10%">
	                	<input class="field date" type="date" size="20" name="DateFrom" id="DateFrom" value="<%=request("DateFrom")%>">
        	        </td>
    	            <td align="left" width="1%">&nbsp;
		                
                  	</td>
	              	<td align="left" width="2%" style="vertical-align: middle;">
                    	To
                  	</td>
                    
                    <td width="12%"  align="left">
                    <input class="field date" type="date" size="20" name="DateTo" id="DateTo" value="<%=Request("DateTo")%>">
                    </td>
                    
                    <td align="left" width="3%">&nbsp;
		                
                  	</td>
                    
                    <td width="4%" align="left" style="vertical-align: middle; text-align:left;" >
                    <b>Status:</b>
                    </td>
                    <td  width="10%" align="left" style="text-align:left; vertical-align: middle;" >
                    <select id="statusopt" name="statusopt">
                    <option value="All"> All </option>
                   
                    	<%
						
	Dim connPhilly05
	Set connPhilly05=server.CreateObject("ADODB.Connection")
	connPhilly05.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_WebPublic" ' philly05
	
	Dim rs
	Set rs=server.createObject("ADODB.Recordset")
	
	Dim DateFrom
	Dim DateTo	
	Set DateFrom = Request("DateFrom")
	Set DateTo = Request("DateTo")
	

		
		statusval = request("statusopt")
							
		If statusval="" then
			statusval = "Successful Download"
		End If
	
	strSQL1 = "SELECT DISTINCT [Status] as StatusVal  " &_
				" FROM dbo.z2t_TableDownload_Log  with(noLock)    " &_
				" Order by [Status] Desc "
	


        rs.open strSQL1, connPhilly05,2,3

		Do Until rs.eof
			
			SelectedVal = ""
			If ucase(rs("StatusVal")) =  ucase(statusval) Then
				SelectedVal= "selected=""selected"""
			Else
				SelectedVal = ""
			End If

		Response.write "<OPTION value=""" & rs("StatusVal") & """" & SelectedVal & ">" & rs("StatusVal")
		 
			'End If

				 Response.write "</OPTION>" & vbCrLf
				rs.MoveNext
		Loop
		rs.Close
		'End If
						
%>
                        
                        </select>
                        
                        <%'=statusval%>

                    </td>
                   <td align="left" style="text-align:left; vertical-align: middle;" >
                   <input type="button"  value="Generate Report" onClick="javascript:generateReport();"/></td>
                   
                   <td align="right" style="vertical-align: middle;">
                   		<input type="button" value="Export"
                        		onClick="window.open('TableDownloadReport.csv')"/></td>
                     <td align="right" width="100" style="vertical-align: middle;">
                     
                   		<input type="button" width="100" value="Print Version"
                        		onClick="javascript:printversion('<%=DateFrom%>','<%=DateTo%>','<%=statusval%>','<%=OrderBy%>','<%=AscDescSQL%>');"/></td>
                                
				  </tr>
			  	</table>
               </td>
         	 </tr>
    
             <tr>
            <td width="90%" align="center" class="divDeskMiddle">
             <div style="height: 593px; width:92%; overflow-y: scroll;">

			  <table width="100%" align="center" border="0" cellspacing="2" cellpadding="2" class="stateList">
					
              <tbody> 
              
               <tr>
				  <th  class="tdwidth100" >
                   <%=ColumnHeading("HarvestID", "HarvestID")%> 
				  </th>
				  <th  class="tdwidth100">
                  	<%=ColumnHeading("Organization", "Organization")%> 
				  </th>
                  <th class="tdwidth100">
                  		<%=ColumnHeading("Email", "Email")%> 
				  </th>
                  <th class="tdwidth100">
                  <%=ColumnHeading("Table Name", "TableName")%> 
                  	
				  </th>
                  <th class="tdwidth100">
                  	 <%=ColumnHeading("Download Date", "DownloadDate")%> 
				  </th>
                  <th class="tdwidth100">
                   <%=ColumnHeading("Download Time", "DownloadTime")%> 
                  </th>
                  <th class="tdwidth100">
                   <%=ColumnHeading("Status", "Status")%> 
                  </th>
                  
    			</tr>
 
<%			  
	If len(DateTo) < 1  or len(DateFrom) < 1 Then
		DateTo= ""
		DateFrom = ""
	End If
	'response.write("<br/>Here1: <br/>")
                
	
		
		''''''''''''''''''Variables for Create File to Export'''''''''''''''''

	
file_tobe_created= "TableDownloadReport.csv"

set fso = createobject("scripting.filesystemobject")
Set act = fso.CreateTextFile(server.mappath(file_tobe_created), true)
'''''''''''''''''' End Variables for Create file to export'''''''''''

	  'response.write (server.mappath(file_tobe_created)) 
	'response.end()
''''''''Export File Heading'''''''''''''''''''''''
act.WriteLine ("HarvestID,Organization,Email,TableName,DownloadDate,DownloadTime,Status")

        strSQL = "z2t_TableDownloadReport('"& DateFrom &"','"& DateTo &"','"& statusval &"','" & OrderBy & "','"& AscDescSQL & "')"		
		Dim connCasper06
		
	Set connCasper06=server.CreateObject("ADODB.Connection")
	connCasper06.Open "driver=SQL Server; server=66.119.50.226,7643; uid=davewj2o; pwd=get2it; database=z2t_WebPublic" ' philly05
	
        'response.Write(strSQL)
		'response.End()
		rs.open strSQL, connCasper06, 3, 3, 4
		'response.Write(strSQL)
		'response.End()
		If Not rs.EOF Then
			Do While Not rs.EOF
			
  	 'Prepare Initial Checked Date 
  
%>
			  
                <tr>
                  <td class="tdwidth30" align='center' >                  
		          <%=rs("HarvestID")%>             
                  </td>
                   <td class="tdwidth100" style="white-space: nowrap;" align='left' >                  
		          <%=rs("Organization")%>      
                  </td>    

                  <td class="tdwidth100" style="white-space: nowrap; text-align: left;" >
					   <%=rs("Email")%>  
                  </td>
				  
                  <td  class="tdwidth100" align='center'>
						<%=rs("TableName")%>

		          </td>
                  
                  <td  class="tdwidth100" align='center'> 
						<%=rs("DownloadDate")%>

		          </td>
                  
                  <td class="tdwidth100"  align='center' >
						<%=left(rs("DownloadTime"),5)%>
          		  </td>
                  
                  <td class="tdwidth100"  align='left' >
						<%=rs("Status")%>
          		  </td>
                  
		          
                </tr>
				
<%

		act.Writeline(rs("HarvestID")&","& replace(rs("Organization"),","," ") &","& rs("Email") & "," & rs("TableName") & "," & rs("DownloadDate") & "," & left(rs("DownloadTime"),5) & ","& rs("Status") )
		
				rs.MoveNext
			Loop
		End If
		rs.Close
%>
				
               
              </tbody>  
             
			 			  
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/footer.inc"-->
    <input type='hidden' id='orderBy' name='orderBy' value='<%=OrderBy%>'>
	<input type='hidden' id='ascDesc' name='ascDesc' value='<%=AscDesc%>'>

  </form>
  
</body>
</html>
