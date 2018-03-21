<script type="text/javascript">
  if (document.images) {  //pre-load the tab's hover images
    var img1 = new Image();
    var img2 = new Image();
    img1.src = "<%=strPathIncludes%>menu/dropdowntabfiles/media/TabHoverLeft.png";
    img2.src = "<%=strPathIncludes%>menu/dropdowntabfiles/media/TabHoverRight.png";}
</script>

<!-- allow some menu items to pop up pages -->
<script type="text/javascript" src="/z2t_Backoffice/Includes/z2t_backoffice_functions.js"></script>

<tr align="center" valign="middle">
  <td colspan="3" class="nowrap">

    <div id="colortab" class="ddcolortabs"> 
      <ul>
	    <li><a href="<%=strPathHome%>z2t_home.asp" 								rel="dropmenuHome">			<span>Home</span></a></li>
        <li><a href="<%=strPathDevelopment%>z2t_bugtracker.asp" 				rel="dropmenuDev">			<span>Development</span></a></li>
        <li><a href="<%=strPathProcesses%>Overview/z2t_Zip2Tax Data Maintenance.asp" 	rel="dropmenuProcesses">	<span>Processes</span></a></li>
	    <li><a href="<%=strPathResearch%>z2t_SpecialRules.asp" 					rel="dropmenuResearch">		<span>Research</span></a></li>
	    <li><a href="<%=strPathStatistics%>z2t_Statistics.asp"					rel="dropmenuStatistics">	<span>Statistics</span></a></li>
        <li><a href="<%=strPathSubscribers%>z2t_SubscriberSummary.asp"	 		rel="dropmenuSub">			<span>Subscribers</span></a></li>
    	<li><a href="<%=strPathWebsite%>z2t_PromotionProcess.asp" 				rel="dropmenuWebsite">		<span>Website</span></a></li>
      </ul>
    </div>

<!--
    <div class="ddcolortabsline">&nbsp;</div>
-->

    <!--0th drop down menu - Home-->
    <div id="dropmenuHome" class="dropmenudiv_a" style="width: 250px;">
      <a href="http://www.harvestamerican.info/menu/index.asp">Dashboard</a>
	  <a href="http://crm.harvestamerican.info/index.asp">CRM</a>
      <a href="http://www.harvestamerican.info/ha_Backoffice/ha_home.asp">Harvest Backoffice</a>
      <a href="https://info.zip2tax.com/z2t_Backoffice/index.asp">Zip2tax Backoffice</a>
      <a href="http://www.number-it.com/Home/BackOffice/boAccounts.asp">Number-it Backoffice</a>
	  <a href="http://legacy.zip2tax.com/Backoffice/z2t_BackofficeSummary.asp">Old Zip2tax Backoffice</a>
    </div>

    <!--1st drop down menu - Development-->
    <div id="dropmenuDev" class="dropmenudiv_a" style="width: 250px;">
      <a href="<%=strPathDevelopment%>z2t_bugtracker.asp">Bug Tracking</a>
      <a href="<%=strPathDevelopment%>z2t_add_bug.asp">Add/Edit Bug</a>
      <a href="<%=strPathDevelopment%>z2t_address_bugtracker.asp">Address Tracking</a>
      <a href="<%=strPathDevelopment%>z2t_add_address_bug.asp">Add/Edit Address</a>
      <a href="<%=strPathDevelopment%>z2t_TypesTableEditor.asp">Types Table Editor</a>
	  <a href="<%=strPathDevelopment%>z2t_address_testing.asp">Address Testing</a>
    </div>


    <!--2nd drop down menu - Processes -->
    <div id="dropmenuProcesses" class="dropmenudiv_a" style="width: 250px;">
	  <a href="/z2t_Backoffice/Processes/Overview/z2t_APIOverview.asp">API Overview</a>
      <a href="/z2t_Backoffice/Processes/Overview/z2t_Zip2Tax Data Maintenance.asp">Zip2Tax Data Maintenance</a>
	  <a href="/z2t_Backoffice/Processes/z2t_ResearchLinks.asp">Research Links</a>
      <a href="/z2t_Backoffice/Processes/Overview/z2t_ResearchOperations.asp">Overview (Nathan's Version)</a>
	  <a href="/z2t_Backoffice/Processes/z2t_EffectiveDateEditor.asp">Effective Date Editor</a>
	  <a href="/z2t_Backoffice/z2t_Export/z2t_Export.asp">Tax Table Export</a>
    </div>

    <!--3rd drop down menu - Research-->
    <div id="dropmenuResearch" class="dropmenudiv_a" style="width: 250px;">
      <a href="<%=strPathResearch%>StateInformation/z2t_StateInformation.asp">State Information</a>
	  <a href="<%=strPathResearch%>z2t_SpecialRules.asp">Special Rules</a>
      <a href="<%=strPathResearch%>StateChangeSummary/z2t_StateChangeSummary.asp">State Change Summary</a>
      <a href="<%=strPathResearch%>StatePhoneNumbers/z2t_StatePhoneNumbers.asp">State Phone Numbers</a>
      <a href="<%=strPathResearch%>z2t_TableDiff.asp?newdate=<%=dateadd("m", +1, Date())%>&olddate=<%=Date()%>&format=FullBreakout&state=US&taxtype=1">Table Differences</a>
      <a href="<%=strPathResearch%>z2t_IntegrityChecks.asp">Integrity Checks</a>
      <a href="<%=strPathResearch%>z2t_TaxData.asp">Tax Data Edit</a>
      <a href="<%=strPathResearch%>z2t_ResearchOperations_addjur.asp">Create Jurisdiction</a>
      <a href="javascript:void(openPopUp('http://info.zip2tax.com/z2t_Backoffice/subscribers/popups/z2t_LinkTest.asp?usr=davesqllinktest&pwd=goodacct2test7'))">
		Database Link Test</a>
		<a href="javascript:void(window.open('http://info.zip2tax.com/z2t_Backoffice/Testing/z2t_lookup_test_page.asp'))">
		Legacy Direct Connect</a>
		<a href="http://csvtester.zip2tax.com" onclick="javascript:void window.open('http://csvtester.zip2tax.com','1396888698268','width=700,height=500,left=0,top=0');return false;">CSV Geocoder</a>
    </div>

    <!--4th drop down menu - Statistics-->
    <div id="dropmenuStatistics" class="dropmenudiv_a" style="width: 250px;">
      <a href="<%=strPathStatistics%>z2t_Statistics.asp">Activity Statistics</a>
	  <a href="<%=strPathStatistics%>z2t_StatisticsLookupHistory_new.asp">Activity Statistics Graphs</a>
      <!--<a href="http://statistics.zip2tax.info/">Philly API Activity Statistics</a>-->
    </div>

    <!--5th drop down menu - Subscribers-->
    <div id="dropmenuSub" class="dropmenudiv_a" style="width: 250px">
      <a href="<%=strPathSubscribers%>z2t_SubscriberSummary.asp">Summary</a>
      <a href="<%=strPathSubscribers%>z2t_SubscriberLookupUsage.asp">Subscriber Lookup Usage</a>
      <a href="<%=strPathSubscribers%>z2t_TableSubscribers.asp">Table Types</a>
	  <a href="<%=strPathSubscribers%>z2t_TableDownloadReport.asp">Table Download Report</a>
      <!--<a href="<%=strPathActivity%>z2t_DatabaseInterfaceReport.asp">Database Interface Usage</a>-->
      <!--<a href="<%=strPathActivity%>z2t_OnlineLookupReport.asp">Online Lookup Usage</a>-->
      <a href="<%=strPathMailing%>z2t_Queries.asp">Table Subscribers Post Card Mailing</a>
    </div>

    <!--6th drop down menu - Website-->
    <div id="dropmenuWebsite" class="dropmenudiv_a" style="width: 300px;">
      <a href="<%=strPathWebsite%>z2t_PromotionProcess.asp">Promotion Process</a>
      <a href="<%=strPathWebsite%>z2t_Services.asp">Zip2Tax Services</a>
      <a href="<%=strPathWebsite%>z2t_OnlineLookupResetCode.asp">Online Look-up Reset Code</a>
      <a href="<%=strPathWebsite%>StateMaintenance/z2t_StateMaint.asp">State Maintenance</a>
      <a href="<%=strPathWebsite%>StateMaintenance/z2t_StateMaint_Types.asp">State Maintenance - Types</a>
      <a href="<%=strPathWebsite%>z2t_What-State-Do-You-Do-Business-In.asp">"What State Do You Do Business In?" section</a>
    </div>
    
    <script type="text/javascript">
      //SYNTAX: tabdropdown.init("menu_id", [integer OR "auto"])
      tabdropdown.init("colortab", <%=ColorTab%>)
    </script>

  </td>
</tr>
