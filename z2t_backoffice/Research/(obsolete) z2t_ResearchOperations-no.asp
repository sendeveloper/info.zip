<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/Secure.asp">
<!--#include file="../../z2t_BackOffice/includes/sql.asp"-->
<!--#include file="../../z2t_Backoffice/includes/lib.asp"-->


<%  
  PageHeading = "Research Operations"
  ColorTab = 1 ' Second menu tab

  ''''' These must be set after sql.asp is included.
  RowMod = 3            ' Colorize every third row.
  ShowRowCount = True   ' Show total number of states
  '''''
%>

<!DOCTYPE html>
<html>
  <head>
    <title>Zip2Tax.info - <%=PageHeading%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice-sensible.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
    <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>sensible.css" />
    <script type="text/javascript" src="<%=strPathIncludes%>lib.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>dates/ts_picker.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>z2t_Backoffice_functions.js"></script>

    <script type="text/javascript" language="javascript">
      var debug = true;

      function doFn(self, fn) {
        call(this, fn);}

      Object.prototype.do = doFn;

      var tasks = [
        ["zipcode-import", "Import ZIP Codes", "http://zip-codes.com"],
        [],
        ["edit-rates", "Change rates", "z2t_TaxData.asp"],
        ["generate-tables", "Generate Zip2Tax Tables", "javascript:inlinePopUp('Remote login to dallas01.harvestamerican.net, and run the program.'); void(0);",
          ["rename-export-table", "Clear the way", "javascript:inlinePopUp('Dz2t_export.dbo.sp_rename Qz2t_ZipCodesQ, Qz2t_ZipCodes_QD & date()'); void(0);"],
          ["apply-taxdata", "Run updateAll_NEW {Date}", "#", ["finish-update", "UpdateFinish {Stuff at end}", "#"]],
          ["patchup", "Patches: TX, Atlanta, St. Paul", "#"],
          ["check-rates", "Check for Mismatched Rates", "#"]],
        ["check-integrity", "Perform Integrity Checks", "https://www.zip2tax.info/z2t_Backoffice/Research/z2t_IntegrityChecks.asp"],
        ["check-differences", "Generate Table Differences", "https://www.zip2tax.info/z2t_Backoffice/Research/z2t_TableDiff.asp?newdate=2/13/2012&olddate=1/13/2012&format=FullBreakout&state=US&taxtype=1"],
        [],
        ["release-tables", "Make downloads live", "javascript:inlinePopUp('Not implemented'); void(0);"],
        ["release-web/link", "Make web/link live", "javascript:inlinePopUp('Not implemented'); void(0);"]];
      var helps = {
<%
   Dim rs
   Set rs = Sql("select * from z2t_BackOffice.dbo.z2t_ResearchOperations_operations")
   Do While Not rs.eof
     Response.Write """" & rs("Description") & """: """ & rs("Help") & """"
     If Not rs.eof Then Response.Write "," & chr(13) & chr(10)
     rs.MoveNext
   Loop 
%>
        };
      

      function populateTasks(id, tasks) {
      try {
        var element = get(id);
        var classes = [""];
        var padding = [0];
        function nodify(task) {
        inlinePopUp(task);
        try {
          var result = document.createDocumentFragment();
          alert(result);
          if (task.length == 0) {
            result.appendChild(node("li", ["class","separator"], node("hr", ["class","separator"])));}
          else {
            var taskStart, checkbox;
            result.appendChild(node("li", ["class","task"],
                                  checkbox = node("input", ["type","checkbox", "id",tasks.indexOf(task).toString(), "name",tasks.indexOf(task).toString()]),
                                  taskStart = node("a", ["href",task[2], "class","task-start", "style","{margin-right: 0em; padding-left: 0em;}", "task",task[0]], text(task[1])),
                                  node("a", ["href","javascript:help(\"" + helps[task[0]] + "\"); void(0);", "style","{margin-left: 0em; padding-left: 0em;}"], node("img", ["src","<%=strPathIncludes%>help/questionmark.gif", "height","14px", "width","10px", "alt","Help"]))),
                                  node("span", ["id","status-" + task[0]], text("---")));
            listen(taskStart, "click", startTask);
            taskStart.task = task[0];
            checkbox.task = taskStart;
            task.slice(3).forEach(function(e){result.appendChildconcat(nodify(e))});}
          return result;
        } catch(error) {inlinePopUp("? " + id + "/" + element + "/" + tasks + ":" + error); return false;}
          return undefined;}
        tasks.forEach(function(e){element.appendChild(nodify(e));});
        return element;
      } catch(error) {inlinePopUp("! " + error);}
        return undefined;}

/*
      function populateTasks(id, tasks) {
      try {
        var element = get(id);
        var classes = [""];
        var padding = [0];
        function nodify(task) {
        try {
          var result;
          if (task.length == 0) {
            result = node("li", ["class","separator"], node("hr", ["class","separator"]));}
          else {
            var taskStart, checkbox;
            result = node("li", ["class","task"],
              checkbox = node("input", ["type","checkbox", "id",tasks.indexOf(task).toString(), "name",tasks.indexOf(task).toString()]),
              taskStart = node("a", ["href",task[2], "class","task-start", "style","margin-right: 0em; padding-left: 0em;", "task",task[0]], text(task[1])),
              node("a", ["href","javascript:help(\"" + helps[task[0]] + "\"); void(0);", "style","{margin-left: 0em; padding-left: 0em;}"], node("img", ["src","<%=strPathIncludes%>help/questionmark.gif", "height","14px", "width","10px", "alt","Help"])),
              node("span", ["id","status-" + task[0]], text("---")),
                (task.length >= 4) ? node("div", [], node.apply(this, ["ul", ["class","sublist"]].concat(task.slice(3).forEach(nodify)))) : text(""));
            listen(taskStart, "click", startTask);
            taskStart.task = task[0];
            checkbox.task = taskStart;}
          return result;
        } catch(error) {inlinePopUp("? " + id + "/" + element + "/" + tasks + ":" + error); return false;}
          return undefined;}
        tasks.forEach(function(e){element.appendChild(nodify(e));});
        return element;
      } catch(error) {inlinePopUp("! " + error);}
        return undefined;}
*/
      function startTask(event) {
        event.preventDefault();
        get("#status-" + this.task).innerHTML = "Started...";
        var task = ajax("https://www.zip2tax.info/z2t_BackOffice/Research/z2t_ResearchOperations_operate.asp?op=" + this.task, receiveAjax);
        task.result = inlinePopUp("");
        task.send();
        return false;}


      function init(event){
        // put help on the page title
        var title = get(".title")[0];
        title.insertBefore(node("a", ["href","javascript:help(\"" + "research-operations" + "\"); void(0);", "style","margin-left: 0em; padding-left: 0em;"], node("img", ["src","<%=strPathIncludes%>help/questionmark.gif", "alt","Help"])), title.childNodes[3]);

        // the debug box
        if (debug) get(".on-desk")[0].appendChild(
          node("div", ["class","debug"], 
            node("input", ["type","checkbox", "id","undebug"]),
            node("label", ["for","debug"], text("Debug")), 
            node("textarea", ["class","debug", "id","debug"], 
              text(get(".on-desk")[0].innerHTML))));
        get("#undebug").checked = false;
        listen(get("#undebug"), "change", function(e){
          var debugbox = get("textarea")[0];
          debugbox.style.visibility = this.checked ? "visible" : "hidden";
          return true;})

        populateTasks("#operations", tasks);
        listen(get("#go"), "click", operate);
        
        get("#debug").innerHTML = get(".on-desk")[0].innerHTML;
        get("input").filter(function(e){return e.className.match(/heading/);}).forEach(function(e){e.checked = false;})
        return;}
     
      function operate(event) {
        get("input").filter(function(e){return (!e.className.match(/heading/)) && (e.id != "undebug") && e.checked;}).forEach(function(e){e.task.click();});
        return;}
     

      function clickAll(target) {
        target.checked = target.checked;
        //inlinePopUp("Clicking all... (" + target + ":" + target.checked + ")");
        //inlinePopUp(get('input').length);
        get('input').filter(function(e){return (e.id != 'undebug') && (e != target);}).forEach(function(e){e.checked = target.checked;});
      return true;}


      function receiveAjax(body) {
        this.result.children[0].children[0].innerHTML = body;
        this.result.style.visibility = "visible";
        return;}


      listen(window, "load", init);
      
    </script>

    <style>
      .article {display: block; min-width: 85%; max-width: 100%;}
      .divDeskTop {height: 0.7em; text-align: center; background-size: 100% 100%; margin-top: 0em; padding: 0.1px;}
      .divDeskMiddle {height: auto; width: auto; background-size: 100% 100%; padding: 0.1px;}
      .divDeskBottom {height: 0.7em; background-size: 100% 100%; margin-bottom: 2em; padding: 0.1px;}
      .on-desk {margin-left: 2em; width: 100%;}
      

/* table display */
      ul#operations {list-style: none; margin-left: 0em; padding-left: 0em; display: table;}

      ul#operations > li > span {padding-left: 2em; padding-right: 2em; border-spacing: 25em; /*border: 1px solid blue;*/ width: auto; display: table-cell; /*inline-block;*/}
      ul#operations > li > input {padding-left: 2em; padding-right: 2em; border-spacing: 25em; /*border: 1px solid blue;*/ width: auto; display: table-cell; display: /*inline-block;*/}

      ul#operations > li {padding-left: 0em; /*border: 1px solid green;*/ width: auto; display: table-row-group;}
      ul#operations > li > * {width: auto; display: table-cell; /*border: 1px solid yellow;*/ padding-left: 2em; padding-right: 2em; border-spacing: 25em;}
      ul#operations > li > *.heading {font-weight: bold;}

      ul.sublist {list-style: none; margin-left: 0em; padding-left: 0em; display: table-row-group;}
      ul.sublist li {padding-left: 0em; /*border: 1px solid red;*/ width: auto; display: table-row;}
      ul.sublist li > * {width: auto; display: table-cell; padding-left: 2em; padding-right: 2em; border-spacing: 25em;}
      ul.sublist li > *.heading {font-weight: bold;}


/*
      ul#operations {list-style: none; margin-left: 0em; padding-left: 0em; /*display: table;*/}

      ul#operations > li > span {padding-left: 2em; padding-right: 2em; border-spacing: 25em; /*border: 1px solid blue;*/ width: auto; /*display: table-cell;*/ display: inline-block;}
      ul#operations > li > input {padding-left: 2em; padding-right: 2em; border-spacing: 25em; /*border: 1px solid blue;*/ width: auto; /*display: table-cell;*/ display: inline-block;}

      ul#operations > li {padding-left: 0em; /*border: 1px solid green;*/ width: auto; /*display: table-row;*/}
      ul#operations > li > * {width: auto; /*display: table-cell;*/ /*border: 1px solid yellow;*/ padding-left: 2em; padding-right: 2em; border-spacing: 25em;}
      ul#operations > li > *.heading {font-weight: bold;}

      ul.sublist {list-style: none; margin-left: 0em; padding-left: 0em; /*display: table;*/}
      ul.sublist li {padding-left: 0em; /*border: 1px solid red;*/ width: auto; /*display: table-row;*/}
      ul.sublist li > * {width: auto; /*display: table-cell;*/ padding-left: 2em; padding-right: 2em; border-spacing: 25em;}
      ul.sublist li > *.heading {font-weight: bold;}
*/

      .task {background-color: white;}
      button#go {margin-left: auto; margin-right: auto; display: inline-block;}

/*
      li.separator {display: table-row;}
      hr.separator {display: table-cell;}
*/

      div.debug {margin-top: 1em; white-space: nowrap; text-align: left;}
      div.debug * {text-align: left;}
      div.debug > input.debug {margin-left: 0em; margin-right: 0em; display: inline-block; width: auto; width: 1em;}
      div.debug > label {display: inline-block; width: auto;}
      div.debug > label:after {content: ":";}
      div.debug > label.undebug:after {content: normal;}
      textarea.debug {width: 100%; min-height: 10em; visibility: visible; display: block; visibility: hidden;}

      textarea {width: 100%; height: auto; visibility: visible;}

      .help {}
      .tooltip button {display: none;}
    </style>

  </head>

<body>
  <!--#include virtual="z2t_Backoffice/includes/heading-sensible.inc"-->

  <div class="article">
    <div class="divDeskTop"></div><!-- divDeskTop -->
    <div class="divDeskMiddle">
      <div class="on-desk">
        <ul id="operations">
          <li class="task"><input class="heading" type="checkbox" onclick="clickAll(this);"><span class="heading">Task</span><span class="heading">Status</span></li><hr>
          <!-- --Tasks go here-- -->
        </ul>
        <button id="go" onclick="operate">Go</button>
        <button id="abort" onclick="operate" disabled="true" style="background: darkgrey; color: lightgrey;">Abort</button>
      </div><!-- on-desk -->
      </div><!-- divDeskMiddle -->
    <div class="divDeskBottom"></div><!-- divDeskBottom -->
  </div><!-- article -->
  
</body>
</html>
