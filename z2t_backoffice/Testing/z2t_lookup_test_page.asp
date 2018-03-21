<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <style type="text/css">
        body {background-color:lightgrey}
        #Button1 {
            margin-left: 100px;
        }
         #Button2 {
            margin-left: 180px;
        }
		#brdr1 {
			border-style: inset;
			border-width: 3px;
		}
		#brdr2 {
			border-style: inset;
			border-width: 3px;
		}
    </style>
</head>
<body>

    <h2><center>Direct Connect Test Page</center></h2>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>

<script type="text/javascript">
   
    function OnSubmitForm() {
        var s = document.getElementById('service');
        var item1 = s.options[s.selectedIndex].value;

              if (item1 == 'z2t_lookup') {
                  document.myform.action = 'z2t_lookup_SQL_Server_Philly01.asp';
              }
              else if (item1 == 'z2t_lookup_extended') {
                  document.myform.action = 'z2t_lookup_extended_SQL_Server_Philly01.asp';
              }
              else if (item1 == 'z2t_lookup_multiple') {
                  document.myform.action = 'z2t_lookup_multiple_SQL_Server_Philly01.asp';
              }
              else if (item1 == 'z2t_lookup_extended_multiple') {
                  document.myform.action = 'z2t_lookup_extended_multiple_SQL_Server_Philly01.asp';
              }
			  else if(item1 == 'SELECT')
			  {
					var v_type = document.myform.getElementById("validation");
					v_type.type = "text";
			  }
              document.myform.submit();
          }
		  
	function OnSubmitMySQLForm() {
        var s = document.getElementById('MYSQLservice');
		var zip = document.getElementById('myzCode').value;
		var usr = document.getElementById('myuName').value;
		var pwd = document.getElementById('mypwd').value;
        var item1 = s.options[s.selectedIndex].value;

              if (item1 == 'z2t_lookup') {
                  document.myform.action = 'z2t_lookup_MYSQL_Philly01.php?zCode=' + zip + '&uName=' + usr + '&pwd=' + pwd;
              }
              else if (item1 == 'z2t_lookup_extended') {
                  document.myform.action = 'z2t_lookup_extended_MYSQL_Philly01.php?zCode=' + zip + '&uName=' + usr + '&pwd=' + pwd;
              }
              else if (item1 == 'z2t_lookup_multiple') {
                  document.myform.action = 'z2t_lookup_multiple_MYSQL_Philly01.php?zCode=' + zip + '&uName=' + usr + '&pwd=' + pwd;
              }
              else if (item1 == 'z2t_lookup_extended_multiple') {
                  document.myform.action = 'z2t_lookup_extended_multiple_MYSQL_Philly01.php?zCode=' + zip + '&uName=' + usr + '&pwd=' + pwd;
              }
			  else if(item1 == 'SELECT')
			  {
					var v_type = document.myform.getElementById("validation");
					v_type.type = "text";
			  }
              document.myform.submit();
       }
</script>
<table width="100%">
<tr><td>
<div id ="brdr1" style="float:left; width:100%;">
    <form name="myform" method="post">
        <table>
        
		<h4><center>Philly01 SQL Server</center></h4>
		
         <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;ZipCode:</td><td><input type="text" name="zCode"><br></td></tr>

         <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;User name:</td><td><input type="text" name="uName"><br></td></tr>

        <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;Password:</td><td><input type="password" name="pwd"><br></td></tr>

        <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;Service:</td><td><select id="service"> 
            <option value="SELECT">---SELECT---</option>
            <option value="z2t_lookup">z2t_lookup</option>
            <option value="z2t_lookup_extended">z2t_lookup_extended</option>
            <option value="z2t_lookup_multiple">z2t_lookup_multiple</option>
            <option value="z2t_lookup_extended_multiple">z2t_lookup_extended_multiple</option>
            </select></td></tr>
        <input type="hidden" id="validation" value = "SELECT SERVICE OPTION"></input>
        </table>

		<br><br>
        <input id="Button2"type='reset' value='RESET' name='reset'>
        <input id="Button1" type="button" value="LOOKUP" onclick="OnSubmitForm()" />
		<br><br><br>
</form>

</div>   
</td>
<td>
<div id ="brdr2" style="float:right; width:100%;">
<form name="mySQLform" method="post">
        <table>
        
		<h4><center>Philly01 MYSQL</center></h4>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;ZipCode:</td><td><input type="text" id="myzCode"><br></td></tr>

         <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;User name:</td><td><input type="text" id="myuName"><br></td></tr>

        <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;Password:</td><td><input type="password" id="mypwd"><br></td></tr>

        <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;Service:</td><td><select id="MYSQLservice"> 
            <option value="SELECT">---SELECT---</option>
            <option value="z2t_lookup">z2t_lookup</option>
            <option value="z2t_lookup_extended">z2t_lookup_extended</option>
            <option value="z2t_lookup_multiple">z2t_lookup_multiple</option>
            <option value="z2t_lookup_extended_multiple">z2t_lookup_extended_multiple</option>
            </select></td></tr>
        <input type="hidden" id="validation" value = "SELECT SERVICE OPTION"></input>
        </table>

		<br><br>
        <input id="Button2"type='reset' value='RESET' name='reset'>
        <input id="Button1" type="button" value="LOOKUP" onclick="OnSubmitMySQLForm()"/>
		<br><br><br>
</form>
</div>
</td></tr>
</table>

</body>
</html>
