<%
        Title = "Table Download Report"
		
		Dim statusval
		Dim DateFrom
		Dim DateTo
		Dim OrderBy
		Dim AscDesc
		Dim AscDescSQL
		
		
	'	https://info.zip2tax.com/z2t_Backoffice/Subscribers/z2t_TableDownloadReport_print.asp?DateFrom=2015-12-01&DateTo=2015-12-03&OrderBy=DownloadDate&AscDescSQL=%20Desc
		DateFrom = Request("DateFrom")
		DateTo 	= Request("DateTo")
		
		If request("statusval") = "All" Then
  				statusval = ""
		Else
				statusval=request("statusval")
		End If		 

	  		
	   If isnull(Request("orderBy")) or Request("OrderBy") = "" then
			OrderBy = "Downloaddate"
		Else
			OrderBy = Request("OrderBy")			
		
		End If
		
		AscDescSQL = request("AscDescSQL")
		



%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="/z2t_BackOffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
	
	<style type="text/css">   
		
		.filterBy
			{
			text-align:center; 
			font-size:10pt; 			
			display: block;
				
			}
		td 
			{
			font-size: 9pt;
			}
			
		th
			{
			font-weight: bold;
			font-size: 10pt;
			text-align: center;
			border-bottom: 1px solid black;
			}
		
	</style>

</head>


<body onLoad="SetScreen(1000,1050);">
  

	  <span class="popupHeading"><%=Title%></span>
      <span class="filterBy">
      		<b>Date</b> &nbsp; From: <%=DateFrom%> &nbsp; To: <%=DateTo%> &nbsp;&nbsp; <b> Filtered By:</b>  <%=statusval%><br/>
            
       </span>

	  <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
                 <tr>
				  <th  class="tdwidth100" >
                  HarvestID
				  </th>
				  <th  class="tdwidth100">
                  	Organization
				  </th>
                  <th class="tdwidth100">
                  		Email
				  </th>
                  <th class="tdwidth100">
                  Table Name
                  </th>
                  <th class="tdwidth100">
                  	 Download Date
				  </th>
                  <th class="tdwidth100">
                   Download Time
                  </th>
                  <th class="tdwidth100">
                   Status
                  </th>
                  
    			</tr>
                
                
                <%
				Dim connPhilly05
				Set connPhilly05=server.CreateObject("ADODB.Connection")
				connPhilly05.Open "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_WebPublic" ' philly05
				Dim rs
				Set rs=server.createObject("ADODB.Recordset")
	
            	strSQL = "z2t_TableDownloadReport('"& DateFrom &"','"& DateTo &"','"& statusval &"','" & OrderBy & "','"& AscDescSQL & "')"		
				'response.Write(strSQL)
				'response.End()
			    rs.open strSQL, connPhilly05, 3, 3, 4
		
				If Not rs.EOF Then
					Do While Not rs.EOF
			
			  	 'Prepare Initial Checked Date 
     
%>
			  
                <tr>
                  <td class="tdwidth30" align='center' >                  
		          <%=rs("HarvestID")%>             
                  </td>
                   <td class="tdwidth120" style="white-space: nowrap;" align='left' >                  
		          <%=rs("Organization")%>      
                  </td>    

                         
                 
                  <td class="tdwidth150" style="white-space: nowrap; text-align: left;" >
					   <%=rs("Email")%>  
                  </td>
				  
                  <td  class="tdwidth100" align='center'>
						<%=rs("TableName")%>

		          </td>
                  
                  <td  class="tdwidth100" align='center'> 
						<%=rs("DownloadDate")%>

		          </td>
                  
                  <td class="tdwidth100"  align='left' >
						<%=left(rs("DownloadTime"),5)%>
          		  </td>
                  
                  <td class="tdwidth100"  align='left' >
						<%=rs("Status")%>
          		  </td>
                  
		          
                </tr>
				
<%
				rs.MoveNext
			Loop
		End If
		rs.Close
%>
						
			<tr><td>&nbsp;</td></tr>
						
	  </table>
 
</body>
</html>
