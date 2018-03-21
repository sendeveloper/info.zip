<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
	PageHeading = "Distribute Basic Zipcodes Tables (z2t_ZipCodes)"
	ColorTab = 2
%>

<html>
    <head>
	<title><%=PageHeading%></title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
   
  
	
<script>

	var http = new XMLHttpRequest();
	var msgbox;

	function clickDistribute(s, db) {
		var id = s + db;
		msgbox = this[id];
		msgbox.innerHTML = 'RUNNING . . .';
		var url = 'z2t_BasicTable_distribute_AJAX.asp' +
			'?s=' +s +
			'&db=' + db +
			'&Now=' + escape(Date());
			
        http.open('GET', url, true);
        http.onreadystatechange = getResponse;
        http.send();
        }

    function getResponse() 
        {
        if (http.readyState == 4) 
			{
			if (http.status == 200) 
				{
				var r = http.response;
				msgbox.innerHTML = r
				}
			}
		}
				    	
</script>

    <style type="text/css">
        body {background-color:lightgrey}
		
		input[type=button] {
			width: 20em;  height: 2em;
		}
		
		.btn_BasicTable {
		
		background-color: maroon;
	    color: white;	  
	  }
	  
	  .stateList th {
    color: white;
    font-weight: bold;
    font-size: 10pt;
    text-align: center;
    background-color: #990000;
}

.stateList td {
    text-align: center;

}
    </style>

    </head>
	
    <body>
		<!--h3><center>Distribute Basic Zipcodes Tables (z2t_ZipCodes)</center></h3-->
		<table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">
        
		<!--#include virtual="z2t_Backoffice/includes/heading.inc"-->
        
        
        
        <tr>
    <td width="100%" align="left" height="10" class="divDeskTop">
    </td>
  </tr>
		<tr> <td width="100%" align= "center" height="550" class="divDeskMiddle" style="padding: 0 25px;">
		
			 <!--table width="100%" border="0" cellspacing="5" cellpadding="5"-->
             <table width="100%" align="center" border="0" cellspacing="2" cellpadding="2" class="stateList">
             
             <tr>
             	<th width="80">Server</th>
             	<th width="80">Purpose</th>
             	<th width="140">Approx. Proc. Time</th>
                <th width="300">Action</th>
                <th width="150">Status</th>
             </tr>
        	
            	
                	
				<tr>
					<td><b>Barley2</b></td>
					<td><b>Production</b></td>
					<td><i>1 minute</i></td>
					<td><input class="btn_BasicTable" type="button" value="Distribute Barley2 z2t_WebPublic" onClick="clickDistribute('Barley2', 'z2t_WebPublic')" /></td>
					<td><span id="Barley2z2t_WebPublic"></span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Barley2 Zip2Tax" onClick="clickDistribute('Barley2', 'Zip2Tax')" /></td>
					<td><span id="Barley2Zip2Tax"></span></td>
				</tr>
								
				
				<tr>
					<td><b>Casper06</b></td>
					<td><b>Production</b></td>
					<td><i>1-1/2 minutes</i></td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Casper06 z2t_WebPublic" onClick="clickDistribute('Casper06', 'z2t_WebPublic')" /></td>
					<td><span id="Casper06z2t_WebPublic"></span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Casper06 z2t_Zip4" onClick="clickDistribute('Casper06', 'z2t_Zip4')" /></td>
					<td><span id="Casper06z2t_Zip4"></span></td>
				</tr>

				<tr>
					<td><b>Casper09</b></td>
					<td><b>Development</b></td>
					<td><i>1-1/2 minutes</i></td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Casper09 z2t_WebPublic" onClick="clickDistribute('Casper09', 'z2t_WebPublic')" /></td>
					<td><span id="Casper09z2t_WebPublic"></span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Casper09 z2t_Zip4" onClick="clickDistribute('Casper09', 'z2t_Zip4')" /></td>
					<td><span id="Casper09z2t_Zip4"></span></td>
				</tr>
				
				
				<tr>
					<td><b>Frank02</b></td>
					<td><b>Production</b></td>
					<td><i>3-1/2 minutes</i></td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Frank02 z2t_WebPublic" onClick="clickDistribute('Frank02', 'z2t_WebPublic')" /></td>
					<td><span id="Frank02z2t_WebPublic"></span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Frank02 z2t_Zip4" onClick="clickDistribute('Frank02', 'z2t_Zip4')" /></td>
					<td><span id="Frank02z2t_Zip4"></span></td>
				</tr>

				
				<tr>
					<td><b>Philly02</b></td>
					<td><b>Production</b></td>
					<td><i>A few seconds</i></td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Philly02 z2t_Zip4" onClick="clickDistribute('Philly02', 'z2t_Zip4')" /></td>
					<td><span id="Philly02z2t_Zip4"></span></td>
				</tr>
				
				<tr>
					<td><b>Philly03</b></td>
					<td><b>Production</b></td>
					<td><i>A few seconds</i></td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Philly03 z2t_WebPublic" onClick="clickDistribute('Philly03', 'z2t_WebPublic')" /></td>
					<td><span id="Philly03z2t_WebPublic"></span></td>
				</tr>
				
				<tr>
					<td><b>Philly04</b></td>
					<td><b>Production</b></td>
					<td><i>A few seconds</i></td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Philly04 z2t_Zip4" onClick="clickDistribute('Philly04', 'z2t_Zip4')" /></td>
					<td><span id="Philly04z2t_Zip4"></span></td>
				</tr>
					
				<tr>
					<td><b>Philly05</b></td>
					<td><b>Staging</b></td>
					<td><i>A few seconds</i></td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Philly05 z2t_WebPublic" onClick="clickDistribute('Philly05', 'z2t_WebPublic')" /></td>
					<td><span id="Philly05z2t_WebPublic"></span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="button" class="btn_BasicTable" value="Distribute Philly05 z2t_Zip4" onClick="clickDistribute('Philly05', 'z2t_Zip4')" /></td>
					<td><span id="Philly05z2t_Zip4"></span></td>
				</tr>
												
			</table>
			
			</td>
            </tr>
            
            <tr>
            <td width="100%" align="left" height="10" class="divDeskBottom">
            </td>
          </tr>
          
		</table>
		  <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->

    </body>
</html>

