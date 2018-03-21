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


<body onLoad="SetScreen(1050,750);">
  <form method="Post" action="z2t_TypesClass_Post.asp" name="frm">

	  <span class="popupHeading"><%=Title%></span>

	  <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

		<tr><td>&nbsp;</td></tr>
						
		<tr>
		  <td Width="35%" align="right" style="font-weight: bold;">
		    Class Name:
		  </td>
		  <td width="55%" align="left">
		    <%=rs("Class")%>
		  </td>
		</tr>
			
		<tr>
		  <td Width="35%" align="right" style="font-weight: bold;">
		    Purpose:
		  </td>
		  <td width="55%" align="left">
		    <%=rs("ClassPurpose")%>
		  </td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>

	  </table>
	  
	  <table width="95%" border="0" cellspacing="2" cellpadding="2">
        <tr>
          <th width="5%">
            Row
          </th>
          <th width="10%">
            Sequence
          </th>
          <th width="20%">
            Value
          </th>
          <th width="25%">
            Description
          </th>
          <th width="15%">
            Is Default
          </th>
          <th width="15%">
            Last Edited
          </th>
          <th width="10%">
            &nbsp;
          </th>
		</tr>
		<tr><td>&nbsp;</td></tr>
	  </table>
	  
	  <div style="height: 400px; overflow-y: scroll;">
	  <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
		
<%			
		If Not rs.EOF Then
			Do While not rs.eof
				LineCount = LineCount + 1
%>
			
	  <tr>
		<td width="5%" align="center">
		  <%=LineCount%>
		</td>
		<td width="10%" align="center">
		  <%=rs("Sequence")%>
		</td>
		<td width="20%" align="left">
		  <%=rs("Value")%>
		</td>
		<td width="25%" align="left">
		  <%=rs("Description")%>
		</td>
		<td width="15%" align="center">
		  <%=rs("IsDefault")%>
		</td>
		<td width="15%" align="center">
		  <%=rs("EditedDate")%>
		</td>
		<td width="10%" align="center">
		  <a href="javascript:clickEdit('<%=rs("Class")%>');" class="bo_Button30">Edit</a>
		</td>
	  </tr>
<%
              rs.MoveNext
            Loop
		End If
        rs.close
%>		

	</table>
	</div>

    <div class="center" style="margin-top: 2em;">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


  </form>
</body>
</html>
