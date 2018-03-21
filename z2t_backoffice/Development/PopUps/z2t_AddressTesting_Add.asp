                                                                                                     <%
        Response.buffer=true                                                        
        Response.clear

        Title = "Types Class Edit"

		Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
		Dim rs: Set rs=server.createObject("ADODB.Recordset")
		connPhilly01.Open "driver=SQL Server;server=208.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables"
        strSQL = "z2t_Types_Class_read('" & Request("Class") & "')"
        rs.open strSQL, connPhilly01, 3, 3, 4

%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>
                                                                                                                                                                                                                                                                                                                                                                                                                                        
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
	
  <style>
	th	
		{
		border-bottom: 1px solid black;
		text-align: center;
		}
		
  </style>
  
  <script language='JavaScript'>
		
	function clickEdit(Class)
		{
		var URL = 'PopUps/z2t_TypesClass_Edit.asp' +
			'?Class=' + Class;
		//openPopUp(URL);
		}
				
  </script>
</head>


<body onLoad="SetScreen(750,550);">
  <form method="Post" action="z2t_AddressTesting_Add_Post.asp" name="frm">

	  <span class="popupHeading">Add New Address</span>

	  <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

		<tr><td>&nbsp;</td></tr>
						
		<tr>
		  <td Width="35%" align="right" style="font-weight: bold;">
		    Address Line 1:
		  </td>
		  <td width="55%" align="left">
		    <input type="text" width="200" id="addressline1" name="addressline1">
		  </td>
		</tr>
			
		<tr>
		  <td Width="35%" align="right" style="font-weight: bold;">
		    Address Line 2:
		  </td>
		  <td width="55%" align="left">
		    <input type="text" width="200" id="addressline2" name="addressline2">
		  </td>
		</tr>

		<tr>
		  <td Width="35%" align="right" style="font-weight: bold;">
		    City:
		  </td>
		  <td width="55%" align="left">
		    <input type="text" width="100" id="city" name="city">
		  </td>
		</tr>

		<tr>
		  <td Width="35%" align="right" style="font-weight: bold;">
		    State:
		  </td>
		  <td width="55%" align="left">
		    <input type="text" width="100" id="state" name="state">
		  </td>
		</tr>
		<tr>
		  <td Width="35%" align="right" style="font-weight: bold;">
		    ZIP:
		  </td>
		  <td width="55%" align="left">
		    <input type="text" width="200" id="zip" name="zip">
		  </td>
		</tr>
	  </table>
	  
	  

    <div class="center" style="margin-top: 1em; ">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


  </form>
</body>
</html>
