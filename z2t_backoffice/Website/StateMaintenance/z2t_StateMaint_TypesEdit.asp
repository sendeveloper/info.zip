<%response.buffer=true%>

<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
	Dim rs
	Dim SQL
	Dim strClass
	Dim qtClass
	Dim apsClass
	Dim qtDescription
	


    If Request("Class")="" or IsNull(Request("Class")) Then
		Response.Redirect strBasePath & "z2t_login.asp"
	Else
		strClass = Request("Class")
		qtClass = Replace(strClass, """", "&quot;")
		apsClass = Replace(strClass, "'", "''")
    End If
%>

<html>
<head>
    <title>Zip2Tax State Maintenance - Types Edit</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <style type="text/css">
        th {font-family: arial; color: black; font-size: 12}
        td {font-family: arial; color: black; font-size: 12}

		td#gray {color: gray; font-size: 9}
		
		a.button {font-weight: bold; font-size: 10px; 
			font-family: Verdana, Arial, Helvetica, sans-serif;	
			padding: 4px 8px; 
			border-top: 1px solid #E0E0E0;
			border-right: 1px solid black; 
			border-bottom: 1px solid black;
			border-left: 1px solid #E0E0E0; 
			background-color: #BB0000; color: #FFFFFF;
			text-align: center; width: 100px;
			text-decoration: none;}

		a.button:hover {border-color: black white white black;}
		
		a.grayButton {font-weight: bold; 
			font-size: 11px; 
			font-family: Verdana, Arial, Helvetica, sans-serif;	
			color: #FFFFFF;
			padding: 4px 8px; 
			background-color: #999999;
			border-top: 2px solid #C0C0C0;
			border-right: 2px solid black; 
			border-bottom: 2px solid black;
			border-left: 2px solid #C0C0C0; 
			text-align: center; 
			text-decoration: none;
			width: 80px;}

		a.grayButton:hover {font-weight: bold; 
			font-size: 11px;
			font-family: Verdana, Arial, Helvetica, sans-serif;	
			color: #C0C0C0;
			background-color: #999999;	
			border-color: black #C0C0C0 #C0C0C0 black;}
    </style>
	
	<script language="javascript" type="text/javascript">
		function clickAddItem()
			{
			document.frm.task.value = 'Add';
			document.frm.submit();
			}

		function clickDeleteItem(v)
			{
			var ans = window.confirm('Are you sure you want to delete this item?');
			if (ans == true) 
				{
				document.frm.task.value = 'Delete';
				document.frm.deleteKey.value = v;
				document.frm.submit();
				}
			}

		function clickSubmit()
			{
			document.frm.task.value = 'Update';
			document.frm.submit();
			}
	</script>
</head>

<body bgcolor="#FFFFFF">

<form method="post" action="z2t_StateMaint_TypesPost.asp" name="frm">
  <input type="hidden" name="class" id="class" value="<%=qtClass%>">
  <input type="hidden" name="task" id="task" value="">
  <input type="hidden" name="deleteKey" id="deleteKey" value="">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="5" cellpadding="5" align="center">
          <tr>
            <td align="center">
                <font Size="4"><b>State Maintenance</b></font>
				<br>
                <font Size="4"><b>Edit Category: "<%=strClass%>"</b></font>
            </td>
          </tr>
  
          <tr>
            <td style="color: red; font-size: 13px;" align="center">
              <b>CAUTION: Editing or deleting entries here will change the values 
			  <br> in the corresponding records throughout your database.</b>
            </td>
          </tr>

          <tr><td>&nbsp;</td></tr>
        </table>    

        <table width="100%" border="0" cellspacing="5" cellpadding="5" align="center">
          <tr>
            <td width="10%" align="center">
              <b>Sequence</b>
            </td>
            <td width="10%" align="center">
              <b>Value</b>
            </td>
            <td width="65%" align="center">
              <b>Description</b>
            </td>
            <td width="15%">&nbsp;
              
            </td>
          </tr>
<%
      set rs=Server.CreateObject("ADODB.Recordset")
      strSQL = "z2t_StatePageMaintenanceTypesDetails_read 'StatePageVariables_" &strClass & "' " 

      rs.open strSQL, connPhilly01PublishTables, 2, 3

      Do While Not rs.EOF
	    qtDescription = Replace(rs("Description"), """", "&quot;")
%>
          <tr>
            <td class="gray" align="center">
              <%=rs("Sequence")%>
            </td>
            <td class="gray" align="center">
              <%=rs("Value")%>
            </td>
            <td align="left">
              <INPUT type="text" size="70" Name="<%=rs("value")%>" ID="<%=rs("value")%>" Value="<%=qtDescription%>">
            </td>
            <td align="center">
              <a href="javascript:clickDeleteItem(<%=rs("value")%>);" class="grayButton">Delete</a>
            </td>
          </tr>
<%
          rs.MoveNext
      Loop

      rs.Close
      Set rs = Nothing
%>
          <tr><td>&nbsp;</td></tr>
        </table>    


        <table width="100%" border="0" cellspacing="2" cellpadding="2">
          <tr>
            <td width="32%">&nbsp;</td>
            <td width="10%" nowrap align="right">
              <a href="javascript:clickAddItem();" class="button">Add Item</a>
            </td>
            <td width="16%" align="center">
              <a href="javascript:clickSubmit();" class="button">Submit</a>
            </td>
            <td width="10%" align="left">
              <a href="javascript:window.close();" class="button">Cancel</a>
            </td>
            <td width="32%">&nbsp;</td>
          </td>
        </table>

      </td>
    </tr>
  </table>
</form>
</body>
</html>
