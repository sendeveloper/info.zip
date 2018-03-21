<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_Backoffice/Research/includes/z2t_StateInfoColumnHeading.inc"-->


<%
  PageHeading = "State Information"
  ColorTab = 3
  
  Dim pageviewtype
  Dim efilterby
  Dim eCheckedDateInitial
  Dim eCheckedDateFinal
  Dim OrderBy
  Dim AscDesc
  Dim AscDescSQL
  If request("pageviewtype") <> "" Then 
  	pageviewtype = trim(request("pageviewtype"))
  Else
  	pageviewtype = 1
  End If 
  
  If request("filterbyval") <> "" Then
  		efilterby = request("filterbyval")
	Else
		efilterby=1
  End If

	If isnull(Request("orderBy")) or Request("OrderBy") = "" then
		OrderBy = "StateID"
	Else
		OrderBy = Request("OrderBy")

	End If
	
		AscDesc = request("ascDesc")
		If LCase(request("ascDesc")) = "a" Then
			AscDescSQL = " Asc"
			AscDesc="a"

	   ElseIf LCase(request("ascDesc")) = "d" Then
			AscDescSQL = " Desc"
			AscDesc = "d"
	   Else
	   			AscDesc = "a"
	   
		End If
		

'  response.Write(AscDesc)
 ' response.End()
  Function fixAps2(s)
    fixAps2 = replace(s, "'", "\'")
End Function
%>

<html>
<head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  
  <script language='JavaScript'>
  
  /*********************All Views Functins *************************/
  	function pageLoad(pt,fb)
  		{ 
			var tabsObj;
			var filtersObj;
			
			if (pt==1) 
				{
				tabsObj=document.getElementById('overview');
				}
			else if (pt==2) 
				{
				tabsObj=document.getElementById('rates');
				}
				
			else if (pt==3) 
				{				
				tabsObj=document.getElementById('automobiles');
				}
			else if (pt==4) 
				{				
				tabsObj=document.getElementById('alcohol');
				}
				
			tabsObj.style.backgroundColor = "#000";
			
			
			if (fb=='99') 
				filtersObj=document.getElementById('showall');
			else if (fb=='1') 
				filtersObj=document.getElementById('showstate1');
			else if (fb=='2') 
				filtersObj=document.getElementById('showstate2');
			else if (fb=='3') 
				filtersObj=document.getElementById('showpossessions');
			
			filtersObj.style.backgroundColor = "#000";
	  
		}
		
		
		function filterby(fb)
		{
			document.frm.filterbyval.value = fb;
			document.frm.submit();
		}
		
		function clickPageView(pt)
		{
			
			document.frm.pageviewtype.value = pt;
			document.frm.submit();
			
		}
		
		function sortFrm(fld, ascDesc)
			{
			document.getElementById('orderBy').value = fld;
			document.getElementById('ascDesc').value = ascDesc;

			document.frm.submit();
			}
			
			
			function clickPrint(pv,fb,ob,ad)
		{
			var URL
			if (pv=='1')
			{
				URL = 'z2t_StateInformation_Overview_print.asp' +
				'?filterby=' + fb + '&orderBy=' + ob + '&AscDesc=' + ad;
			}
			else if (pv=='2')
			{
				URL = 'z2t_StateInformation_Rates_print.asp' +
				'?filterby=' + fb + '&orderBy=' + ob + '&AscDesc=' + ad;
			}
			else if (pv=='3')
			{
				URL = 'z2t_StateInformation_Automobiles_print.asp' +
				'?filterby=' + fb + '&orderBy=' + ob + '&AscDesc=' + ad;
			}
			else if (pv=='4')
			{
				URL = 'z2t_StateInformation_Alcohal_print.asp' +
				'?filterby=' + fb + '&orderBy=' + ob + '&AscDesc=' + ad;
			}
		openPopUp(URL);
		}
		
		
	/****************************All Views Functions End *************************/
	
	
	
	/**************************Overview Functions Start***************************/
		
	function editInitialChecked(st)
		{
		var URL = 'z2t_StateInformationInitialChecked_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+';
		openPopUp(URL);
		}
		
		function editFinalChecked(st)
		{
		var URL = 'z2t_StateInformationFinalChecked_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+';
		openPopUp(URL);
		}
				
	
	
		
	function editFrequency(st)
		{
		var URL = 'z2t_StateInformationFrequency_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+';
		openPopUp(URL);
		}
	function editSourcing(st)
		{
		var URL = 'z2t_StateInformationSourcing_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+';
		openPopUp(URL);
		}
		
	
		/////////////////Overview Action Functions Start////////////////////
		function clickProcedure(st)
		{
		var URL = 'z2t_StateInformationProcedure_edit.asp' +
			'?State=' + st ;
		openPopUp(URL);
		}
		
		function clickStateDataPage(rs)
		{
		window.open(rs, "", "width=800, height=700");

		}
		
		function clickEditLinks(st)
		{
			var URL = 'z2t_StateInformationEditLinks_edit.asp' +
			'?State=' + st + 			
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+';
		openPopUp(URL);
		}
		
		function clickHomePage(rs)
		{
		window.open(rs, "", "width=800, height=700");

		}
		
		/////////////////Overview Action Functions End//////////////////////
		
	/**************************Overview Functions End***************************/		
	
	
	/*************************Rates Functions Start****************************/
	
		function editUseTax(st)
		{
		var URL = 'z2t_StateInformationUseTax_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype= + <%=pageviewtype%>+';
		openPopUp(URL);
		}
		
		function editHasUnincorporatedAreas(st)
		{
		var URL = 'z2t_StateInformationHasUnincorporatedAreas_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		  
        function editShippingTaxable(st)
		{
		var URL = 'z2t_StateInformationShippingTaxable_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		  
        function editLaborTaxable(st)
		{
		var URL = 'z2t_StateInformationLaborTaxable_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		
        function editStateRate(st)
		{
		var URL = 'z2t_StateInformationStateRate_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype= + <%=pageviewtype%>+';
		openPopUp(URL);
		}
	
	/************************Rates Functions End******************************/
	
	
	/*************************Automobiles Functions Start****************************/
	
		function editNew(st)
		{
		var URL = 'z2t_StateInformationNew_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype= + <%=pageviewtype%>+';
		openPopUp(URL);
		}
		
		function editUsed(st)
		{
		var URL = 'z2t_StateInformationUsed_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		  
        function editRental(st)
		{
		var URL = 'z2t_StateInformationRental_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		  
        function editLease(st)
		{
		var URL = 'z2t_StateInformationLease_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		
       function clickNotes(st)
		{
		var URL = 'z2t_StateInformationNotes_edit.asp' +
			'?State=' + st ;
		openPopUp(URL);
		}
	
	/************************Automobiles Functions End******************************/
		
	
	/************************Alcohal Functions Start*******************************/
	
	
	  function editBeerNote(st)
		{
		var URL = 'z2t_StateInformationBeerNote_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		
		function editTaxPerGallonBeer(st)
		{
		var URL = 'z2t_StateInformationBeerTaxPerGallon_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
			
		
		function editWineNote(st)
		{
		var URL = 'z2t_StateInformationWineNote_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		
		function editTaxPerGallonWine(st)
		{
		var URL = 'z2t_StateInformationWineTaxPerGallon_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
			
		
		
		function editLiquorNote(st)
		{
		var URL = 'z2t_StateInformationLiquorNote_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
		
		function editTaxPerGallonLiquor(st)
		{
		var URL = 'z2t_StateInformationLiquorTaxPerGallon_edit.asp' +
			'?State=' + st + 
			'&filterbyval= + <%=efilterby%> +'+
			'&orderBy= + <%=OrderBy%> +'+
			'&AscDesc= + <%=AscDesc%>+'+
			'&pageviewtype=<%=pageviewtype%>+';
		openPopUp(URL);
		}
			
			
	
	/************************Alcohal Functions End*******************************/
	
	
	
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
	a.checkdatecss{
		text-decoration: none;
		color:black;
		}
	a.checkdatecss:hover{
		 color:#990000;
		 font-weight:700;
		}
	.button90{
			    padding: 2px 2px !important;
		}
		

	.tdwidth240
		{
		width:240px !important;	
		}
	.tdwidth220
		{
		width:220px !important;	
		}

	.tdwidth220
		{
		width:220px !important;	
		}
	.tdwidth150
		{
		width:150px !import	
		}
	.tdwidth30
		{
		width:30px !important;	
		}
	.tdwidth120
		{
		width:120px !important;	
		}
	.tdwidth100
		{
		width:100px !important;	
		}
	.tdwidth97{
		width:97px !important;
		}	
	.tdwidth50{
		width:50px !important;
		}
	

  </style>
  
</head>

<body onLoad="pageLoad('<%=pageviewtype%>','<%=efilterby%>');">
<form name="frm" action="z2t_StateInformation.asp" method="post"  style="margin-bottom:0px !important;" >

  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->

    			<table width="92%" border="0" cellspacing="0" cellpadding="2" align="center">
				  <tr valign="top">
                   
                   	<td width="5%">
                   		<b>Display:</b>
                   	</td>
                 
				  	<td align="left" width="10%" >
                    	<a href="javascript:clickPageView(1);" 
                           class="button90"
                           id="overview">
                          Overview
                         </a>
						&nbsp;<br><br>
				  	</td>
                  	<td align="left" width="10%">
	                	<a href="javascript:clickPageView(2);"                         
                           class="button90"
                           id="rates">
                          Rates
                         </a>
        	        </td>
    	            <td align="left" width="10%">
		                <a href="javascript:clickPageView(3);"
                           class="button90"
                           id="automobiles">
                          Automobiles 
                         </a>
                  	</td>
	              	<td align="left" width="10%">
	                	<a href="javascript:clickPageView(4);" 
                        	class="button90" 
                            id="alcohol">
                          Alcohol 
                        </a>
                  	</td>
                    
                    <td width="40%" >&nbsp;</td>
                   
                    <td align="right" width="10%">
	                	<a href="javascript:clickPrint('<%=pageviewtype%>',<%=efilterby%>,'<%=OrderBy%>','<%=AscDesc%>');" 
                        	class="button90">Print Version</a>
                  	</td>
				  </tr>
			  	</table>
               </td>
         	 </tr>
             
             
             
          <tr>
            <td width="90%" align="center">
             <div style="height: 593px; width:92%; overflow-y: scroll;">

			  <table width="100%" align="center" border="0" cellspacing="2" cellpadding="2" class="stateList">
					
              <tbody> 
              
               <tr>
				  <th colspan="2" class="tdwidth150" >
                   <%=ColumnHeading("State", "StateID")%> 
				  </th>
                  
                  <%If pageviewtype = 1 Then '''''''''Overview Page Heading Start%>
                  
				  <th  class="tdwidth150">
                  	<%=ColumnHeading("Summary", "summary")%> 
				  </th>
                  <th class="tdwidth100">
                  		<%=ColumnHeading("Initial Checked", "CheckedDateInitialSort")%> 
				  </th>
                  <th class="tdwidth100">
                  <%=ColumnHeading("Final Checked", "CheckedDateFinalSort")%> 
                  	
				  </th>
                  <th class="tdwidth100">
                  	 <%=ColumnHeading("Frequency", "Frequency")%> 
				  </th>
                  <th class="tdwidth100">
                   <%=ColumnHeading("Sourcing", "SalesTaxSourcing")%> 
                  </th>
                  <th  style="white-space:nowrap !important;" >
                  	Actions
				  </th>
                  
                  <% End If'''''''''Overview Page Heading End%>
                  
                  <%If pageviewtype = 2 Then '''''''''Rates Page Heading Start%>
                  
                   <th class="tdwidth150">
                  		<%=ColumnHeading("UseTax", "UseTax")%> 
				  </th>
                  <th class="tdwidth150">
                  <%=ColumnHeading("Has Unincorporated Areas", "HasUnincorporatedAreas")%> 
                  	
				  </th>
                  <th class="tdwidth150">
                  	 <%=ColumnHeading("Shipping Taxable", "ShippingTaxable")%> 
				  </th>
                  <th class="tdwidth150">
                   <%=ColumnHeading("Labor Taxable", "LaborTaxable")%> 
                  </th>
                  <th   >
                  	Actions
				  </th>
                  
                  <% End If'''''''''Rates Page Heading End%>
                  
                  
                  
                   <%If pageviewtype = 3 Then '''''''''Automobiles Page Heading Start%>
                  
                   <th class="tdwidth150">
                  		<%=ColumnHeading("New", "New")%> 
				  </th>
                  <th class="tdwidth150">
                  <%=ColumnHeading("Used", "Used")%> 
                  	
				  </th>
                  <th class="tdwidth220">
                  	 <%=ColumnHeading("Rental", "Rental")%> 
				  </th>
                  <th class="tdwidth150">
                   <%=ColumnHeading("Lease", "Lease")%> 
                  </th>
                  <th   >
                  	Actions
				  </th>
                  
                  <% End If'''''''''Automobiles Page Heading End%>
                  
                  
                  <%If pageviewtype = 4 Then '''''''''Alcohol Page Heading Start%>
                  
                  <th colspan="2" class="tdwidth150">
                  		Beer
				  </th>
                  <th colspan="2" class="tdwidth150">
						Wine
                  	</th>
                  <th colspan="2" class="tdwidth220">
                  	 Liquor
				  </th>
                  <% End If'''''''''Alcohol Page Heading End%>
                  
    			</tr>
                
               
                
                

<%			  
	Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
	Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
	Dim rs: Set rs=server.createObject("ADODB.Recordset")
	
	
'response.Write(pageviewtype)
'response.end()

If pageviewtype = 4 Then '''''''''Automobile Connection on Philly05

		connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
        strSQL = "z2t_StateInfo_Alcohol_list('" & OrderBy & "','"& AscDescSQL & "'," &  efilterby & ")"		
        rs.open strSQL, connPhilly05, 3, 3, 4
		
ElseIf pageviewtype = 3 Then '''''''''Automobile Connection on Philly05

		connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
        strSQL = "z2t_StateInfo_Automobiles_list('" & OrderBy & "','"& AscDescSQL & "'," &  efilterby & ")"		
        rs.open strSQL, connPhilly05, 3, 3, 4
	
Else
	connPhilly01.Open "driver=SQL Server;server=10.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables" ' philly01
    strSQL = "z2t_StateInfo_list ('" & OrderBy & "','"& AscDescSQL & "'," &  efilterby & ")"
	rs.open strSQL, connPhilly01, 3, 3, 4
End If

		If Not rs.EOF Then
			Do While Not rs.EOF
			
  	 'Prepare Initial Checked Date 
     
	  
	  
%>
			  
                <tr>
                  <td class="tdwidth30" align='center' >                  
		          <%=rs("StateID")%>             
                  </td>
                   <td class="tdwidth120" style="white-space: nowrap;" align='left' >                  
		          <%=rs("StateName")%>      
                  </td>    
                <%If pageviewtype = 1 Then '''''''''Overview Page Rows Start%>
                         
                 
                  <td class="tdwidth150" style="white-space: nowrap; text-align: left;" >
					   <%=rs("Summary")%>  
                  </td>
				  
                  <td  class="tdwidth100" align='center'>
		            <a 	href="javascript:editInitialChecked('<%=rs("StateID")%>');"
                    	class="checkdatecss">
						<%=rs("CheckedDateInitial")%>
                    </a>
		          </td>
                  
                  <td  class="tdwidth100" align='center'> 
		            <a 	href="javascript:editFinalChecked('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("CheckedDateFinal")%>
                    </a>
		          </td>
                  
                  <td class="tdwidth100"  align='left' onDblClick="editFrequency('<%=rs("StateID")%>');">
                   <a 	href="javascript:editFrequency('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("Frequency")%>
                    </a>   
          		  </td>
                  
                    <td class="tdwidth100" align='left' onDblClick="editSourcing('<%=rs("StateID")%>');">
                     <a 	href="javascript:editSourcing('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("SalesTaxSourcing")%>
                    </a>  
          		  </td>
                                    
                  <td   style="text-align:center; font-size:8pt; white-space:nowrap">
				  		<a href="javascript:clickProcedure('<%=rs("StateID")%>');"
                           id="procedure">
                      	   Procedure 
                     	</a>&nbsp;
					  <a href="javascript:clickStateDataPage('<%=rs("Link")%>')"
                           id="StateDataPage">
                         State's Data Page
                       </a>&nbsp;
 
                        <a href="javascript:clickHomePage('<%=rs("LinkHomePage")%>')"
                           id="HomePage">
                         Home Page
                       </a>&nbsp;
                      
					   <a href="javascript:clickEditLinks('<%=rs("StateID")%>','<%=rs("Link")%>')"
                           id="StateDataPage">
                         Edit Links
                       </a>
                  </td>
                  
                  <%End If '''''''''Overview Page Rows End%>
                  
                  
                    
                  <%If pageviewtype = 2 Then '''''''''Rates Page Rows Start%>
                  
                  	<td  class="tdwidth120" align='center'
                    		onDblClick="editUseTax('<%=rs("StateID")%>');">
		            <a 	href="javascript:editUseTax('<%=rs("StateID")%>');"
                    	class="checkdatecss">
						<%=rs("UseTax")%>
                    </a>
		          </td>
                
                   <td  class="tdwidth120" align='center'
                   		onDblClick="editHasUnincorporatedAreas('<%=rs("StateID")%>');">
                   		<a href="javascript:editHasUnincorporatedAreas('<%=rs("StateID")%>');"
                        class="checkdatecss">
                      	  <%=rs("HasUnincorporatedAreas")%>
                     	</a>
		          </td>  
                              
                  <td class="tdwidth120"  align='center' 
                  		onDblClick="editShippingTaxable('<%=rs("StateID")%>');">
                   <a 	href="javascript:editShippingTaxable('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("ShippingTaxable")%>
                    </a>   
          		  </td>
                  
                    <td class="tdwidth120" align='center' 
                    		onDblClick="editLaborTaxable('<%=rs("StateID")%>');">
                     <a 	href="javascript:editLaborTaxable('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("LaborTaxable")%>
                    </a>  
          		  </td>
                   
                
                                   
                  <td   style="text-align: center; font-size: 8pt; white-space:nowrap"
                  		onDblClick="editStateRate('<%=rs("StateID")%>');">
					  <a href="javascript:editStateRate('<%=rs("StateID")%>')"
                           id="StateRate">
                         Edit State Rate
                       </a>
                  </td>
                  
                  
                  <% End If'''''''''Rates Page Rows End%>
                  
                  
                   <%If pageviewtype = 3 Then '''''''''Automobiles Page Rows Start%>
                  
                  	<td  class="tdwidth150" align='left'  
                    		onDblClick="editNew('<%=rs("StateID")%>');">
		            <a 	href="javascript:editNew('<%=rs("StateID")%>');"
                    	class="checkdatecss">
						<%=rs("New")%>
                    </a>
		          </td>
                
                   <td  class="tdwidth150" align='left'
                   			onDblClick="editUsed('<%=rs("StateID")%>');">
                   		<a href="javascript:editUsed('<%=rs("StateID")%>');"
                        class="checkdatecss">
                      	  <%=rs("Used")%>
                     	</a>
		          </td>  
                              
                  <td class="tdwidth220"  align='left' 
                  			onDblClick="editRental('<%=rs("StateID")%>');">
                   <a 	href="javascript:editRental('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("Rental")%>
                    </a>   
          		  </td>
                  
                    <td class="tdwidth150" align='left' 
                    		onDblClick="editLease('<%=rs("StateID")%>');">
                     <a 	href="javascript:editLease('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("Lease")%>
                    </a>  
          		  </td>
                   
                
                                   
                  <td   style="text-align: center; font-size: 8pt; white-space:nowrap"
                  			onDblClick="clickNotes('<%=rs("StateID")%>');">
					  <a href="javascript:clickNotes('<%=rs("StateID")%>')"
                           id="StateRate">
                        Notes
                       </a>
                  </td>
           
                  
                  <% End If'''''''''Automobiles Page Rows End%>
                  
                   <%If pageviewtype = 4 Then '''''''''Alcohol Page Rows Start%>
                  
                  	<td  class="tdwidth50" align='right' 
                    		onDblClick="editTaxPerGallonBeer('<%=rs("StateID")%>');">
		            <a 	href="javascript:editTaxPerGallonBeer('<%=rs("StateID")%>');"
                    	class="checkdatecss">
                        <span style="text-align:left !important;">$</span>
						<%=rs("TaxPerGallonBeer")%>
                    </a>
		          </td>
                
                   <td  class="tdwidth240" align='left'
                   		onDblClick="editBeerNote('<%=rs("StateID")%>');">
                   		<a href="javascript:editBeerNote('<%=rs("StateID")%>');"
                        class="checkdatecss">
                      	  <%=rs("NoteBeer")%>
                     	</a>
		          </td>  
                              
                  <td class="tdwidth50"  align='right' 
                  		onDblClick="editTaxPerGallonWine('<%=rs("StateID")%>');">

                   <a 	href="javascript:editTaxPerGallonWine('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
                        <span style="text-align:left !important;">$</span>
						<%=rs("TaxPerGallonWine")%>
                    </a>   
          		  </td>
                  
                    <td class="tdwidth240" align='left' 
                    		onDblClick="editWineNote('<%=rs("StateID")%>');">
                     <a 	href="javascript:editWineNote('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("NoteWine")%>
                    </a>  
          		  </td>
                                   
                  <td   class="tdwidth50" align='right'
                  		onDblClick="editTaxPerGallonLiquor('<%=rs("StateID")%>');">
					  <a href="javascript:editTaxPerGallonLiquor('<%=rs("StateID")%>')"
                           class="checkdatecss">
                           <span style="text-align:left !important;">$</span>
                           <%=rs("TaxPerGallonLiquor")%>
                       </a>
                  </td>
                  
                   <td class="tdwidth240" align='left' 
                   			onDblClick="editLiquorNote('<%=rs("StateID")%>');">
                     <a 	href="javascript:editLiquorNote('<%=rs("StateID")%>');" 
                    	class="checkdatecss">
						<%=rs("NoteLiquor")%>
                    </a>  
          		  </td>
             
                  
                  <% End If'''''''''Alcohol Page Rows End%>
                  
		          
                </tr>
				
<%
				rs.MoveNext
			Loop
		End If
		rs.Close
%>
				
               
              </tbody>  
             
              </table>
                </div>
 			  
            </td>
          </tr>
          
          <!------------- Pagination for State 1, Stat 2, Possession ---->
          
          <tr>
            <td width="90%" align="left" >
			  <table width="92%" border="0" cellspacing="0" cellpadding="2" align="center">
				
					  <tr><td >&nbsp;</td></tr>
                      
            	       <tr valign="top">
                      		
                            <td align="left" width="5%">
                            	 <b>Page:&nbsp;</b>
                             </td>
                             
                       		<td align="center" width="10%" >
                    			<a href="javascript:filterby('99');"
                        	   	    class="button90"
                                    id="showall">
                          			All
                         		</a>							
				  			</td>
                 
					  		<td align="center" width="10%">
                    			<a href="javascript:filterby('1');"
                        	   		class="button90"
                                    id="showstate1">
                          			State 1
                         		</a>
							
				  			</td>
                  			<td align="center" width="10%">
	                			<a href="javascript:filterby('2');"
                           			class="button90"
                                    id="showstate2">
                          			State 2
                         		</a>
        	        		</td>
                    
    	            		<td align="center" width="10%">
		                		<a href="javascript:filterby('3');"
                           			class="button90"
                                    id="showpossessions">
                          			Possessions
                         		</a>
                  			</td>
                            
                            <td width="40%">&nbsp;</td> 
                            <td width="10%" >&nbsp;</td> 
                   		</tr>
                 	</table>
               	</td>
               </tr> 
          
          <!-------------- End Pagination ------------------------------->
          
          
  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
  
  	<input type='hidden' id='pageviewtype' name='pageviewtype' value='<%=pageviewtype%>'>
  	<input type='hidden' id='orderBy' name='orderBy' value='<%=OrderBy%>'>
	<input type='hidden' id='ascDesc' name='ascDesc' value='<%=AscDesc%>'>
	<input type='hidden' id='filterbyval' name='filterbyval' value='<%=efilterby%>'  />
  </form>
  

</body>
</html>
