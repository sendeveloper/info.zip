<%
  ''''' Changelog
  '
  ' <2011-03-21 nathan> Added Automobile fields to StateEditData
  '
  ' <2011-03-22 nathan> Added "All Auto" button link to Excel spreadsheet
  '
%>

<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<html>
<head>
    <title>Zip2Tax.com - z2t_Zipcodes Data</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="/Backoffice/Includes/z2t_backoffice.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="/Backoffice/Includes/menu/dropdowntabfiles/ddcolortabs.css" />

    <script language="javascript" src="/Includes/z2t.js" type="text/javascript"></script>
    <script type="text/javascript" src="/Backoffice/Includes/menu/dropdowntabfiles/dropdowntabs.js"></script>
    <style>
      table {empty-cells: show; border-collapse: collapse;}
      th, td {border: 1px solid black;}
    </style>

</script>
</head>
<body>
  <% SqlTableInsert "SELECT * FROM dallas01.z2t_Export.dbo.z2t_ZipCodes WHERE State = '" & Request("state") & "'" %>
</body>
</html>

<!--#include virtual="/BackOffice/includes/sql.asp"-->
