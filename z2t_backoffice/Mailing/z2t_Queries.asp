<%
Option Explicit
Dim rs
Dim rs2
Dim rs3
Dim PgeURL
Dim URL
Dim PageHeading
Dim ColorTab
%>


<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="z2t_BackOffice/includes/sql.asp"-->
<!--#include virtual="z2t_Backoffice/includes/lib.asp"-->


<%  
  PageHeading = "Queries"
  ColorTab = 2 ' Second menu tab

  ''''' These must be set after sql.asp is included.
 RowMod = 3				'Colorize every third row.
 ShowRowCount = True	'Show total number of states.

  '''''
%>

<!DOCTYPE html>
<html>
  <head>
    <title>Zip2Tax.info - <%=PageHeading%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
    <script type="text/javascript" src="<%=strPathIncludes%>lib.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>dates/ts_picker.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>z2t_Backoffice_functions.js"></script>

    <script type="text/javascript" language="javascript">
      var debug = true;

    </script>

    <style>
      .article {display: block; min-width: 85%; max-width: 100%;}
      .on-desk {margin-left: 2em; width: 100%;}
      

      div.debug {margin-top: 1em; white-space: nowrap; text-align: left;}
      div.debug > input.debug {margin-left: 0; margin-right: 0; display: inline-block; width: auto;}
      div.debug > label {display: inline-block; width: auto;}
      div.debug > label:after {content: ":";}
      div.debug > label.undebug:after {content: normal;}
      textarea.debug {width: 100%; min-height: 10em; visibility: visible; display: block;}

    div.top {text-align: left;}
    form {background-color: #c0c0c0; margin: 1em; display: inline-block;}
    fieldset {margin: .5em; white-space: nowrap; text-align: left;}
    fieldset label {text-align: right; width: 8em; margin-left: auto; margin-right: 2em; display: inline-block;}
    input, select {display: inline-block; margin-right: 1.5em; text-align: left; width: 10em; margin-right: auto; margin-left: 0em;}
    input, input.field {width: 18em;}
    select {width: 18em;}
    select.yesno {width: 4em;}
    input.number {text-align: right; width: 5em;}
    input.date {width: 8em;}
    input.button {width: auto; margin: 1em;}
    #compare {margin-left: 15em;}
    option.disabled {opacity: 20; color: #c0c0c0}
    button.disabled {opacity: 20; color: #c0c0c0; background-color: #808080; border-color: #404040;}
    span.message-area {margin-left: 2em; display: inline-block;}
    span.message {}
    span.error {font-weight: bold; color:darkred;}
    div.status-message {text-align: center; margin: 2em; font-size: 2em;}
    span.sticky-message {display: block;}
    span.sticky-message > label:after {content: ":"; display: inline-block;}
    span.sticky-message > sticky-message-text {display: inline-block;}


    .resultset {width: auto; margin: 1.5em; empty-cells: show; border-collapse: collapse; background-color: white; border-spacing: 1.5em;}
    .resultset th {color: black; font-weight: bold; padding-right: 1.5em; text-align: left;}
    .resultset thead tr:first-child {border-bottom: 1px solid black;}
    .resultset td {font-size: 1em;}
    .resultset tfoot {margin-top: 1em;}

    div.date {display: inline-block; vertical-align: top; margin: 1em;}
    div.date span#current-date {font-size: 2em;}


      textarea {width: 100%; height: auto; visibility: visible;}

    </style>

  </head>

<body>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
        <div class="on-desk">
        <div class="top">
          <form id="form" name="form" method="post" action="z2t_Queries.asp">
            <fieldset id="parameters" name="parameters">
              <legend>Generate a mailing list: </legend>
              All table customers with no updates within 
              <input id="datespan" name="datespan" value="<%=ifnull(Request("datespan"), "3")%>" style="width: 1.5em; margin: 1em;" /> months from <input id="datefrom" name="datefrom" value="<%=ifnull(Request("datefrom"), Date())%>" style="width: 7em; margin: 1em;" />.<br>
              <label for="state">State: </label>
              <%=SelectDefaultedOption("state", "select * from (values ('', '(All States)', -3), ('US', 'Entire US', 0)) as ignore(value, description, sequence) union select value, description = case when len(value) > 0 then value + ' - ' + description else '(blank -' + value + ')' end, sequence from z2t_BackOffice.dbo.z2t_Types where class = 'States' and sequence > 0 order by sequence", Request("State"))%>
              <input type="submit" value="Go" id="go" name="go" style="width: auto; margin-left: 2em;" />
              <input type="submit" value="Save" id="save" name="save" style="visibility: hidden; width: auto; margin-left: 2em;" />
            </fieldset>
          </form>
          <div class="date">
            <span style="border-bottom: 1px solid black;">Current Date: </span><br>
            <span id="current-date"><%=Now()%></span>
          </div><!-- date -->
        </div><!-- top -->
        <div class="resultset">
<%
		 Dim sqlText2
          sqlText2 = "z2t_BackOffice.dbo.z2t_mailings_postcards '" & Request("datespan") & "', '" & Request("datefrom") & "', " & nulledq(Request("state"))
		 ' response.Write(sqlText2)
%>
          <%=iif(Request("go") = "Go", Replace(sqlTable(sqlText2), " / ", "<br>"), "") %> 	<!-- sqlTable is a function included from sql.asp
																								This function "returns an HTML table as text."-->
        </div>
      </div>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/footer.inc"-->
  </body>
</html>
