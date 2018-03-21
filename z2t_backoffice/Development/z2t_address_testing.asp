<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  PageHeading = "Address Testing"
  ColorTab = 1
%>

<!DOCTYPE html>
<html>
  <head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

<style>
	td.TdEvents{
		border: 1px solid;
    	text-align: left;
	}
</style>
  <script language='JavaScript'>
		
$('.button30').click(function(event) {
    url : 'http://info.zip2tax.com/z2t_Backoffice/Development/z2t_ajax.asp',
    type : 'GET',
    data : {
      //  'numberOfWords' : 10
	  "username": 'angel',
	  "password":  'angel1',
	  "AddressLine1":  '7clyde road',
	  "AddressLine2":   '', 
	  "City" : 'somerset',
	  "State": 'nj', 
	  "Zip":  '08873'
    },
    dataType:'json',
    success : function(data) {              
        alert('Data: '+data);
    },
    error : function(request,error)
    {
        alert("Request: "+JSON.stringify(request));
    }
});
		
		
		
	function clickEdit(AddressID)
		{
		var URL = 'PopUps/z2t_AddressTesting_AddEdit.asp' +
			'?AddressID=' + AddressID;
		openPopUp(URL);
		}
		
		function clickAddAddress()
		{
		var URL = 'PopUps/z2t_AddressTesting_AddEdit.asp';			
		openPopUp(URL);
		}
		
		function clickChangePassword(UserId)
		{
		var URL = 'PopUps/z2t_AddressTesting_ChangePassword.asp' +
			'?UserId=' + UserId;
		openPopUp(URL);
		}
		
		function clickTestAddress(UserId)
		{
		var URL = 'PopUps/z2t_AddressTesting.asp' +
			'?UserId=' + UserId;
			//Will call new form containing all address , service to test and userid
		openPopUp(URL);
		}
		
				
  </script>

  </head>
  
<body>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->
        <%
			Dim connPhilly04: Set connPhilly04=server.CreateObject("ADODB.Connection")
			Dim rs: Set rs=server.createObject("ADODB.Recordset")
			connPhilly04.Open "driver=SQL Server;server=208.88.49.21,8443;uid=davewj2o;pwd=get2it;database=z2t_BackOffice" ' philly04
            strSQL = "z2t_Address_Testing_list"
            rs.open strSQL, connPhilly04, 3, 3, 4

			If Not rs.EOF Then
        %>
            
            
            
              <table width="100%" border="0" cellspacing="5" cellpadding="5" align="center">
                <tbody><tr>
                  
                  <td width="15%" class="TdEvents"  align="center">                  
                    <b>Service to test:</b>
                    <select id="taxType" name="taxType" onchange="getState();">
						<option value="1" selected="">Casper06 API</option>
						<option value="2">Open Source A</option>
						<option value="2">Open Source B</option>
						<option value="2">Google</option>                        
                    </select>
                  </td>

        		<td width="11%" class="TdEvents" align="center">
                     <b>Date Class:</b>
                     <select id="taxTypeVariation" name="taxTypeVariation" onchange="getState();">
						<option value="0" selected="Top 1000">Top 1000</option>
						<option value="2">Top 100</option>
						<option value="3">Top 10</option>
					 </select>
                </td>
                <td width="13%" align="center" class="TdEvents">
					  <b>Login:</b>
                      <input type="text" id="UsrName" width="100">
                 </td>
                 <td width="15%" align="center" class="TdEvents">
					  
						<b>Password:</b>
                      <input type="password" id="UsrPass"> 
                  </td>
                  
                 <td width="6%" align="center" >
                  	 <a style="height: 27px; line-height: 27px; width: 120;" 
                     	
                        class="button30">Test</a>
                  </td>
              </tr>
              
              <tr>
              	<td colspan="4">
                	          Here you can view and edit entries in the z2t_Address_Testing table. Address present here are used to test API.
                </td>
                
                <td align="center">
                			<a style="height: 20px; line-height: 20px; width: 120;" 
					                     	href="javascript:clickAddAddress();"
                    					    class="button30">Add Address</a>
                                            
                                            
                                    	 <a style="height: 20px; line-height: 20px;width: 120;" 
					                     	href="javascript:clickChangePassword('UserIDValtoCome');"
                    					    class="button30">Change Password</a>
                                	
                </td>
			</tbody></table>
                        
                        
                        
                  </td>
                </tr>
                
                
				
                <tr>
                	<td>
                    <div style="height: 500px; overflow-y: scroll;">
                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
								
                      <tr bgcolor="#990000">
                        <th width="20%">
                          Address Line 1
                        </th>
                        <th width="20%">
                          Address Line 2
                        </th>
                        <th width="10%">
                          City
                        </th>
                        <th width="10%">
                          State
                        </th>
                        <th width="10%">
				          ZIP
                        </th>
                        
                        <th width="30%">
				          Actions
                        </th>

                      </tr>
					
      				  
		      			
				         
					
							  
		<%
			Do While not rs.eof
		%>
							  <tr bgcolor="#FFFFFF">
								<td width="20%" align="left">
								  <%=rs("AddressLine1")%>
								</td>
								<td width="20%">
								  <%=rs("AddressLine2")%>
								</td>
								<td width="10%" align="left"> 
								  <%=rs("City")%>
								</td>
								<td width="10%" align="center">
								  <%=rs("State")%>
								</td>
                                <td width="10%" align="center">
								  <%=rs("Zip")%>
								</td>
								<td width="30%" align="center">
								  <a href="javascript:clickEdit('<%=rs("AddressID")%>');" class="button30">Edit</a>
                                  &nbsp; 
                                  <a href="javascript:clickDelete('<%=rs("AddressID")%>');" class="button30">Delete</a>
								</td>
							  </tr>
        <%
              rs.MoveNext
            Loop
        %>
		
						  </table>
						</div>
					    </td>
					  </tr>	  
				
			       
		  
		        
				
					
        <%
            End If
			rs.Close
		%>
		
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/footer.inc"-->
</body>
</html>

<%
  Function DisplayNumber(n)
	If isnull(n) Then
		DisplayNumber = ""
	Else
        DisplayNumber = FormatNumber(n,0)
	End If
  End Function
%>


