<%                        
  Dim strPath: strPath                       = "https://info.zip2tax.com/"
  Dim strBasePath: strBasePath               = strPath & "z2t_Backoffice/"

  Dim strPathIncludes: strPathIncludes       = strBasePath & "includes/"
  Dim strPathImages: strPathImages           = strBasePath & "images/"
  Dim strPathDates: strPathDates             = strBasePath & "includes/dates/"

  Dim strPathHome: strPathHome               = strBasePath & "Home/"
  Dim strPathResearch: strPathResearch       = strBasePath & "Research/"
  Dim strPathMailing: strPathMailing         = strBasePath & "Mailing/"
  Dim strPathActivity: strPathActivity       = strBasePath & "Activity/"
  Dim strPathWebsite: strPathWebsite         = strBasePath & "Website/"
  Dim strPathStatistics: strPathStatistics   = strBasePath & "Statistics/"
  Dim strPathDevelopment: strPathDevelopment = strBasePath & "Development/"
  Dim strPathSubscribers: strPathSubscribers = strBasePath & "Subscribers/"

  Session.Timeout = 1440
%>

<script language="javascript" type="text/javascript">
    var strBasePath = '<%=strBasePath%>';
    var strPathIncludes = '<%=strPathIncludes%>';
    var strPathImages = '<%=strPathImages%>';
</script>
