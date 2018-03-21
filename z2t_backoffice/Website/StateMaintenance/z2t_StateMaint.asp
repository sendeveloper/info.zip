<%response.buffer=true%>

<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_BackOffice/includes/sql.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  dim strColor
  dim PageHeading
  dim recordCount
  dim StateAbbr(100)
  dim StateName(100)

  PageHeading = "State Maintenance"
  ColorTab = 6



  sqlText="SELECT * " & _
    "FROM z2t_Webpage_Duplication_States " & _
    "ORDER BY StateFullName"

  set RS=server.createObject("ADODB.Recordset")
  RS.open sqlText, connBackoffice, 2, 3

  if not RS.EOF then
    do while not rs.eof
      recordCount = recordCount + 1
      StateAbbr(recordCount) = rs("State")
      if rs("State") = "DC" and rs("StateFullName") = "Columbia"  then
        StateName(recordCount) = "District of Columbia"
      else
        StateName(recordCount) = rs("StateFullName")
      end if
      rs.MoveNext
    loop
  end if
        
  rs.close
  set rs = nothing
%>

<html>
<head>
  <title><%=PageHeading%></title>

  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  
  <link rel="stylesheet" type="text/css" href="/z2t_Backoffice/includes/z2t_backoffice.css">
  <link rel="stylesheet" type="text/css" href="/z2t_Backoffice/includes/menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script language="JavaScript" type="text/javascript" src="/z2t_Backoffice/includes/menu/dropdowntabfiles/dropdowntabs.js"></script>
  <script language="JavaScript" type="text/javascript" src="/z2t_Backoffice/Includes/lib.js"></script>
  <script language="JavaScript" type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
  
  
  <script type="text/javascript">
	
    window.onerror = function(message, url, line) {
      alert(url + ":" + line + "\n\n" + message)
      document.getElementById("loading_animation").innerHTML = "";
      return true;}
	  
    function clickEditOptions(st)
        {
        var URL = 'z2t_StateMaintenanceOptions_Edit.asp' +
            '?State=' + st;
        openPopUpSize(URL,500,500);
        }		
		
	function clickEditText(st)
        {
        var URL = 'z2t_StateMaintenanceText_Edit.asp' +
            '?State=' + st;
        openPopUpSize(URL,500,500);
        }


//function fmap(fn, list) {return forPairs.call(list, fn);}
function fmap(fn /*, list ... */) {
  var lists = [].slice.call(arguments, 1);
  var firsts = [];
  var rests = [];
  for (var index in lists) {
    if (lists[index].length == 0) {return [];}
    else {
      firsts.push(lists[index][0]);
      rests.push([].slice.call(lists[index], 1));}}
  return [fn.apply(null, firsts)].concat(fmap.apply(null, [fn].concat(rests)));}
//alert(fmap(function(a, b, c) {return a + b + c;}, [1, 2, 3], [4, 5, 6], [7, 8, 9])); // expected-result: [12, 15, 18]


// apply a function FN that combines 1+n elements until it reduces LISTs to one value (ragged ends are discarded)
function freduce(fn /*, defaultValue, list ... */) {
  var defaultValue = arguments[1];
  var lists = [].slice.call(arguments, 2);
  var firsts = [];
  var rests = [];
  for (var index in lists) {
    if (lists[index].length == 0) {return defaultValue;}
    else {
      firsts.push(lists[index][0]);
      rests.push([].slice.call(lists[index], 1));}}
  return freduce.apply(null, [fn, fn.apply(null, [defaultValue].concat(firsts))].concat(rests));}
//alert(freduce(function(a, b, c){return a + "[" + b + "," + c + "]";}, "list:", ["1", "2", "3"], ["a", "b", "c", "d"])); // expected-result: [list:[1,a][2,b][3,c]]


// apply a function FN that combines two element until it reduces a LIST to one value
function reduce(list, fn /*, defalutValue */) {
  var defaultValue = arguments[2];
  if (list.length == 0) {return defaultValue;}
  else if (!undef(defaultValue)) {
    return reduce(list.slice(1), fn, fn(defaultValue, list[0]));}
  else return reduce(list.slice(1), fn, list[0]);}


// apply PREDICATE to n-arguments at a time from LISTS, returning all the results for which PREDICATE is true
function ffilter(predicate, list) {return list.filter(predicate);}


    var $ = get;
    $.map = fmap;
    $.reduce = freduce;
    // $.apply = fapply;
    $.filter = ffilter;

    // ensure the value is specified
    function ok(e, defaultValue) {
      if (typeof(e) == "undefined") {
        return defaultValue;}
      //// careful here -- all sorts of things get coerced to NaN -- unless they are coerced to zero
      //        else if (isNaN(e)) {
      //          return defaultValue;}
      else if (e == null) {
        return defaultValue;}
      else {
        return e;}}


    // add a class to an element (classSpecifier can be space-separated string of multiple classes to add)
    function classify (e, classSpecifier) {
      e.className = ok(e.className, "");
      $.map(function(eachClass) {
        if (e.className.split(" ").indexOf(eachClass) == -1) {
          e.className += " " + eachClass};},
            classSpecifier.split(" "));
      return e.className;}


    // remove a class from an element (classSpecifier can be space-separated string of multiple classes to remove)
    function declassify(e, classSpecifier) {
      var classesBeingRemoved = classSpecifier.split(" ");
      return e.className = $.filter(function(eachClass){return (classesBeingRemoved.indexOf(eachClass) == -1);},
                                    e.className.split(" ")).
        join(" ");}

  </script>

  
  <style type="text/css">

    button.disabled {background-color: darkgrey; color: lightgrey;}
  </style>

</head>

<body>

  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
      
      <table width="100%" border="0" cellspacing="5" cellpadding="5">
        <tr valign="top">
          <td style="font-size:12pt">
			The State Pages on the Zip2Tax website are editable for individuality. The editing is performed here.
             Once complete you must distribute the recently edited z2t_StateInfo_Website table for the changes to take effect.
            <br><br>
            Use this page to edit the custom data.
          </td>
        </tr>
	
	
        <tr>
          <td colspan="3">
            <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
				<%
                  For row = 1 to 13
                %>
                              <tr>
                <%
                    For col = 0 to 3
                      sName = StateName(row + (col * 13))
                      sAbbr = StateAbbr(row + (col * 13))
                %>
                                <td width="22%" bgColor="White">
                <%
                      If sName = "" Then
                        Response.write "&nbsp;"
                      Else
                %>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left">
                        <a href="http://dev.Zip2Tax.com/Website/pagesCountries/US/States/<%=replace(replace(sName,"District of ", "")," ","-")%>-State-Rates/index.html"
                           target="_StateEditView"
                           Title="View Finished Page for <%=sName%>">
                          <FONT Size="2"><%=sName%></FONT></a>
                      </td>
                      <td align="right">
                        <a href="javascript:clickEditOptions('<%=sAbbr%>')",
                                 class="buttonEdit" Title="Edit Option Variables for <%=sName%>">Edit Options</a>
						   
                        <a href="javascript:clickEditText('<%=sAbbr%>')",
                                 class="buttonEdit" Title="Edit Text Variables for <%=sName%>">Edit Text</a>
                      </td>
                    </tr>
                  </table>
                </td>
				<%
                      End If
                      If col <> 3 then
                        Response.write "<td width='3%'>&nbsp;</td>"
                      End If
                    Next
                %>
                              </tr>
                <%
                  Next
                %>
            </table>
          </td>
        </tr>
        
      </table>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
</body>
</html>
