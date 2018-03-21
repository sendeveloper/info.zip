<!-- http  -->


function getHTTPObject() {
  var xmlhttp;
  if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
    try {
      xmlhttp = new XMLHttpRequest();
    } catch (e) {
      xmlhttp = false;
    }
  }
  return xmlhttp;
}

    function getInnerText(node) {
        if (typeof node.textContent != 'undefined') {
            return node.textContent;
            }
        else if (typeof node.innerText != 'undefined') {
            return node.innerText;
            }
        else if (typeof node.text != 'undefined') {
            return node.text;
            }
        else {
            switch (node.nodeType) {
            case 3:
            case 4:
                return node.nodeValue;
                break;
            case 1:
            case 11:
                var innerText = '';
                for (var i = 0; i < node.childNodes.length; i++) {
                    innerText += getInnerText(node.childNodes[i]);
                    }
                return innerText;
                break;
            default:
                return '';
                }
            }
        }

var http = getHTTPObject();
<!-- ---------------------------------------------------------------------- -->


<!-- activitypost -->
    function ActivityPost(actType, data1, data2)
        {
            uTrack.open("GET", "https://www.filecollegeinfo.com/includes/Activity/ActivityPost.asp?ActType=" + actType +
                "&Data1=" + data1 +
                "&Data2=" + data2 +
                "&Now=" + escape(Date()), true);
            uTrack.send(null);
        }

function getHTTPObjectActivityPost() {
  var xmlhttp;
  /*@cc_on
  @if (@_jscript_version >= 5)
    try {
      xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      try {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (E) {
        xmlhttp = false;
      }
    }
  @else
  xmlhttp = false;
  @end @*/
  if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
    try {
      xmlhttp = new XMLHttpRequest();
    } catch (e) {
      xmlhttp = false;
    }
  }
  return xmlhttp;
}

var uTrack = getHTTPObjectActivityPost();
<!-- ---------------------------------------------------------------------- -->



<!--#include virtual='includes/PageStart.asp'-->


<%
    Dim tbl(10)

    tbl(1) = "StudentBasicData"
    tbl(2) = "StudentAnnualData"
    tbl(3) = "StudentFinancialData"
    tbl(4) = "ParentData"
    tbl(5) = "ParentFinancialData"
    tbl(6) = "Siblings"
    tbl(7) = "NonCustodialParents"
    tbl(8) = "SchoolChoices"
    tbl(9) = "ActionListItems"
    tbl(10) = "Planners"

    Dim rs
    Dim SQL
    set rs = server.createObject("ADODB.Recordset")
%>

<html>
<head>
    <title>cts Update Access Databases</title>

    <link rel="stylesheet" href="<%=strBasePath%>includes/cts.css" type="text/css">

    <script language="JavaScript1.2" src="<%=strBasePath%>includes/httpobject.js"></script>
    <script language="JavaScript1.2" src="<%=strBasePath%>includes/Activity/ActivityPost.js"></script>

<script language="javascript1.2">

    var level = 1;
    var ErrorMsg = '';

    function formLoad()
        {
        runUpdate();
        }

    function runUpdate() 
        {
        //alert('at runUpdate: level=' + level);
        http.open('GET', '<%=strBasePath%>includes/ajax/UpdateAccessTable.asp?level=' + escape(level) +
           '&Now=' + escape(Date()), true);
        http.onreadystatechange = getUpdateResponse;
        http.send(null);
        }

    function getUpdateResponse() 
        {
        //alert ('at getUpdateResponse');
        if (http.readyState == 4) 
            {
            var results = http.responseText
            if (results == 'ok')
                {
                document.getElementById('updateStatus' + level).innerHTML = 'Done'
                }
            else
                {
                document.getElementById('updateStatus' + level).innerHTML = 'Error'
                ActivityPost(12, 'Error', 'Level ' + level);
                ErrorMsg = 'With Error(s)'
                }
            level = level + 1
            if (level < 11)
                {
                runUpdate();
                }
            else
                {
                ActivityPost(12, 'Complete', ErrorMsg);
                }
            }
        }

</script>

</head>

<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" onLoad='formLoad();'>

<table width='900' align='center' cellspacing='0' cellpadding='0' valign='top'>
  <!--#include virtual='includes/top.asp'-->
  
  <tr>
    <td width='160' valign='top'>
      <!--#include virtual='includes/left.asp'-->
    </td>

    <td width='740' valign='top'>
      <table width='100%' height='460' align='center' cellspacing='0' cellpadding='0'>
        <tr valign='top'>
          <td>

            <%=createSubheadBar("Update Access Database", "", "" , "", "", "", "", "")%>

            <table width='100%' cellspacing='10' cellpadding='10' bgcolor='#ffffff'>
              <tr valign='top'>
                <td>
                  <table width='100%' cellspacing='2' cellpadding='5' bgcolor='#dddddd'>

<%
    for tLoop = 1 to 10
%>

                    <tr valign='top'>
                      <td width='50%'>
                        Update <%=tbl(tLoop)%> Table
                      </td>

                      <td align='center'>
                        <span id='updateStatus<%=tLoop%>'>----</span>
                      </td>
                    </tr>

<%
    Next
%>

                  </table>

                </td>
              </tr>
            </table>

          </td>
        </tr>
      </table>
    </td>
  </tr>
  <!--#include virtual='includes/bottom.asp'-->

</table>
</body>
</html>
