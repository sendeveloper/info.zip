<%
        Title = "State Information: Automobiles"
		
		Dim efilterby
		Dim OrderBy
		Dim AscDesc
		Dim AscDescSQL
		If request("filterby") <> "" Then
  				efilterby = request("filterby")
		Else
				efilterby=1
		End If		 

	  	Dim efilterbyval
	  	If 	   efilterby = 1 then
				efilterbyval="State 1"
		Elseif efilterby = 2 then
				efilterbyval="State 2"
		Elseif efilterby = 3 then
				efilterbyval="Possessions"
		Elseif efilterby = 99 then
				efilterbyval="All"
		End If
	  		
	   If isnull(Request("orderBy")) or Request("OrderBy") = "" then
			OrderBy = ""
		Else
			OrderBy = Request("OrderBy")


			AscDesc = request("ascDesc")
			
			If LCase(request("ascDesc")) = "a" Then
				AscDescSQL = " Asc"

		    ElseIf LCase(request("ascDesc")) = "d" Then
				AscDescSQL = " Desc"
			End If
		
		End If


%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="/z2t_BackOffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
	
	<style type="text/css">   
		.separatorLine
			{
			}
									
		.separatorLine hr
			{
			margin: 0;
			}
			
		.separatorLine td
			{
			//border: 1px solid green;
			line-height: 2px;
			}
		.filterBy
			{
			text-align:center; 
			font-size:10pt; 
			font-weight:bold;
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


<body onLoad="SetScreen(900,850);">
  

	  <span class="popupHeading"><%=Title%></span>
      <span class="filterBy">
      		Filtered By: <%=efilterbyval%>
       </span>

	  <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
                <tr>
				   <th colspan="2" width="150" >
				    State
				  </th>
				 <th colspan ='2'>
					Beer
				  </th>
                  <th colspan ='2'>
                  	Wine
				  </th>
                  <th  colspan ='2'>
                  	Liquor
               	  </th>   
             </tr>
                 
<%			  
	Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
	Dim rs: Set rs=server.createObject("ADODB.Recordset")

	connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
    strSQL = "z2t_StateInfo_Alcohol_list('" & OrderBy & "','"& AscDescSQL & "'," &  efilterby & ")"

	
    rs.open strSQL, connPhilly05, 3, 3, 4

		If Not rs.EOF Then
			Do While Not rs.EOF
			
			Linecount = Linecount + 1
				If LineCount > 3 Then
			
  	 'Prepare Initial Checked Date 
%>                 

				<div><tr Class="separatorLine"><td colspan="8"><hr></td></tr></div>
<%
					LineCount = 1
				End If 
%>
			  
            <tr>
                  <td width='30px' align='left' >                  
		          <%=rs("StateID")%>   
                  </td>
                   <td width='120px' style="white-space: nowrap;" align='left' >                  
		          <%=rs("StateName")%>      
                  </td>
                  <td style="white-space: nowrap; text-align: left;" >
						<%=rs("TaxPerGallonBeer")%>
                  </td>				  
                  <td  align='left'>		            
						  <%=rs("NoteBeer")%>               
		          </td>
                  
                  <td  align='left'> 		           
						<%=rs("TaxPerGallonWine")%>                    
		          </td>
                  <td  align='left'>		            
						  <%=rs("NoteWine")%>               
		          </td>                  
                  <td  align='left' >
		            <%=rs("TaxPerGallonLiquor")%>
          		  </td>
                  <td  align='left'>		            
						  <%=rs("NoteLiquor")%>               
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
