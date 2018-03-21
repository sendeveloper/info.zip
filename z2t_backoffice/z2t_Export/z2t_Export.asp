<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_Backoffice/Research/includes/z2t_StateInfoColumnHeading.inc"-->
<%
 PageHeading = "Sales Tax Export"
 ColorTab = 2
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Harvest American Zip 2 Tax Utilities</title>

  	<link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  	<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  	<script type="text/javascript" src="<%=strPathIncludes%>z2t_ExportAJAXHandler.js"></script>
  
	<script language="javascript" type="text/javascript" >
    function Startup(){
    
    
    
      CheckFileStatus(0);
      CountRecordsInTable();
      CountFilesInFolder();
    }
    
    function CountRecordsInTable(){
        var spnlRecordCount= document.getElementById("spnlRecordCount");
        CallAjaxPage('ajax/z2t_Export_RecordCount.asp?tableName='+document.getElementById("spnfilename").innerText,spnlRecordCount );
    }
    
    function CheckFileStatus(checkstatusclick){		
    
        var ddlMonth = document.getElementById("cmbMonth");
        var ddlYear=document.getElementById("cmbYear");
        document.getElementById("spnfilename").innerText= "z2t_zipcodes_" + 
                                                          ddlYear.options[ddlYear.selectedIndex].value + "_"+
                                                          ddlMonth.options[ddlMonth.selectedIndex].value.split(" - ")[0];	
        var BaseDir = 'c:\\zip2tax\\Export';
        document.getElementById("txtExportDirectory").value=BaseDir +
                                                            "\\"+ddlYear.options[ddlYear.selectedIndex].value+
                                                            "\\"+ddlMonth.options[ddlMonth.selectedIndex].value +" - unchecked";								
                                                        
        var PostStr = "";
        var PostStr1= "checkstatusclick="+checkstatusclick+"&createdirectory=<%=request("createdirectory")%>&txtExportDirectory="+
                        document.getElementById("txtExportDirectory").value+
                        "&cmbMonthval="+ddlMonth.options[ddlMonth.selectedIndex].value .split(' - ')[0]+
                        "&cmbYearval="+ddlYear.options[ddlYear.selectedIndex].value;
                                                            
        doAJAXCall('ajax/z2t_Export_CreateFolderStructure.asp?'+PostStr1, 'POST','' + PostStr + '', showConfirmBox );															
    
    }
    function CountFilesInFolder()
    {		
        var fileCount=document.getElementById("fileCount");
        CallAjaxPageForFileCount('ajax/z2t_Export_filesCount.asp?ExportDirectory=' + document.getElementById("txtExportDirectory").value,
                        fileCount );
    
    }
    
    function RunThemAll() {
        
        // build up the post string when passing variables to the server side page
        var PostStr = "";
        
        // use the generic function to make the request
        doAJAXCall('ajax/z2t_Export_files.asp?ExportDirectory=' + document.getElementById("txtExportDirectory").value+
                                '&RunThemAll=True', 'POST', '' + PostStr + '', showMessageResponse );
    
        CountFilesInFolder();
    }
    // The function for handling the response from the server
    function RunFunctions(ExportType, FormatType, TaxType)
    {
        var ddlMonth = document.getElementById("cmbMonth");
        var ddlYear=document.getElementById("cmbYear");
        var PostStr = "";
        doAJAXCall('ajax/z2t_Export_files.asp?exportType='+ExportType+
                        '&ExportDirectory=' + document.getElementById("txtExportDirectory").value+					
                        '&TaxType='+TaxType +
                        '&FormatType='+FormatType, 
                        'POST', '' + PostStr + '',showMessageResponse );
    
		
        var spnFileCount;
		if (FormatType=="Magento Enterprise")
		{
		spnFileCount= document.getElementById("spnMagentoEnterpriseFileCount"+TaxType)
		}else
		{spnFileCount= document.getElementById("spn"+FormatType+"FileCount"+TaxType)}
        CallAjaxPage('ajax/z2t_Export_filesCount.asp?exportType='+ExportType+
                        '&ExportDirectory=' + document.getElementById("txtExportDirectory").value+					
                        '&TaxType='+TaxType +
                        '&FormatType='+FormatType, spnFileCount );
    }
    </script>

	<style type="text/css">
        #fade {display: none;position:absolute; top: 0%; left: 0%; width: 100%;height: 125%;
                 background-color: #ababab; z-index: 1001;-moz-opacity: 0.8;opacity: .70;filter: alpha(opacity=80);}
        #modal {display: none;position: absolute;top: 45%;left: 45%;width: 64px;height: 64px; padding:30px 15px 0px;
                border: 3px solid #ababab;box-shadow:1px 1px 10px #ababab;border-radius:20px;background-color: white;
                z-index: 1002;text-align:center;overflow: auto;}
        .dvGray{border: solid 1px #aaa; background-color:#d6d3de;padding-bottom:20px;}
        .dvHeading{	padding:2px;font-size:14px; font-weight:600;color:#AF2729;}
        .major-head{border-bottom:1px solid #000;	text-align:center;	font-weight:600; 		}	
        .format-heading{border-bottom:2px solid;}
        .run-button{width:75px}
    </style>
  
</head>

<body onLoad="javascript:Startup();">
 <form name="frm" action="z2t_Export.asp" method="post"  style="margin-bottom:0px !important;">
 <input type="hidden" name="runtype" id="runtype" />

 

  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->

                 <!--Div Desk Content Goes Here-->

                    <tr>
                        <td>
                        <!--Start Import Files -->  
                      <!--#include virtual="/z2t_Backoffice/z2t_export/z2t_ImportFilters.inc"-->
         				</td>
		        	</tr> 
        			<tr>
            
         				<td class="" >
                          <!-- Bottom Table Start Here -->                                      
                              <!--#include virtual="/z2t_Backoffice/z2t_export/z2t_FileFormats.inc"-->
                        <!-- Bottom table Ends here -->
		                </td>
        	        </tr>
  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/footer.inc"-->
   <div id="dvFolderResponse" style="display:none"></div>
 <div id="fileCount" style="display:none"></div>
 
 <div id="fade"></div>
 <div id="modal">
     <img id="loader" src="images/fhhrx.gif" />
     <div id="modal-content"></div>
 </div>
<div id="dvFileExists" style="display:none"></div>
</form>
</body>
</html>
