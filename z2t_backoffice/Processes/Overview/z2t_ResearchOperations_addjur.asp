<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_BackOffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<%  
  PageHeading = "Add a Jurisdiction"
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
    <script type="text/javascript" src="<%=strPathIncludes%>lib-dev.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>z2t_Backoffice_functions.js"></script>

    <script type="text/javascript">
      var tooltip;

      function init(){
        // put help on the page title
        var title = get(".title")[0];
        title.insertBefore(node("a", ["href","javascript:help(\"" + "help-add-jurisdiction" + "\"); void(0);", "style","{margin-left: 0em; padding-left: 0em;}"], node("img", ["src","<%=strPathIncludes%>help/questionmark.gif", "alt","Help"])), title.childNodes[3]);

        (function(footer) {
          footer.innerHTML = "Passed";
          footer.style.color = "green";})(get("footer")[0].getElementsByTagName("em")[0]);
        listen(get("#jur-type"), "change", jurChange);
        get("#javascript-test").innerHTML = "Passed";
        get("#javascript-test").style.color = "green";
      
        tooltip = node("div", ["style","background: lightyellow; position: absolute; visibility: hidden; top: 100px; left: 100px; height: 2em; width: 10em;"]);
        get("body")[0].appendChild(tooltip);
        //get("div").forEach(function(e){listen(e, "mouseover", toolTip); /*listen(e, "mouseout", hideToolTip);*/ return;});
        //nodeEvents.push(["mouseover", toolTip, function(e){return e.nodeName.toLowerCase() == "div"}]);
        return;}
      
      function toolTip(event) {
        tooltip.innerHTML = event.target.style.overflow.toString();
        tooltip.style.left = px(event.screenX);
        tooltip.style.top = (event.screenY);
        tooltip.style.zIndex = 100; //event.target.style.zIndex + 1; // + window.getComputedStyle(tooltip).getPropertyValue("zIndex");
        show(tooltip);
        return;}

      function hideToolTip(event) {
        hide(tooltip);
        return;}

      function identity(e){return e;}

      function jurChange(event){
        switch(get("#jur-type").value) {
        case "city":
          document.forms["add-city"]["city"].disabled = false;
          document.forms["add-city"]["city"].style.visible = "visible";
          break;
        case "county":
          document.forms["add-city"]["city"].disabled = true;
          document.forms["add-city"]["city"].style.visible = "hidden";
          break;
        default:
          throw("Invalid jurisdiction selection");}
        return true;}

      function validate(){
        var formHash = {};
        document.forms["add-city"].elements.removeIfNot(function(e){return e.nodeName.toLowerCase() == 'input';}).forEach(function(e){formHash[e.name] = e.value;});
        var valid = false;
        var jurtype = 0;
        var city = "";
        switch (get("#jur-type").value) {
        case "city":
          jurtype = 3;
          city = "city='" + formHash["city"] + "'"
          if ((formHash["city"].length > 0) && (formHash["county"].length > 0) && (formHash["state"].length > 0)) {
            valid = true;}
          break;
        case "county":
          jurtype = 2;
          city = "";
        if ((formHash["county"].length > 0) && (formHash["state"].length > 0)) {
            valid = true;}
          break;
        default:
          throw("Invalid jurisdiction selection");
          return;
          break;}
      var url = "http://info.zip2tax.com/z2t_BackOffice/Research/z2t_ResearchOperations_operate.asp?op=add-jur&state=" + formHash["state"] + "&county=" + formHash["county"] + "&city=" + formHash["city"] + "&taxtype=" + get("#taxtype").value + "&rate=" + "0.0" + "&jurrate=" + "0.0" + "&jurtype=" + jurtype + "&jursize=" + jurtype + "&efffrom=" + get("#effective-from").value + "&effto=" + get("#effective-to").value;
      if (valid) {
      var win = ajax(url, 
        function(text){/*alert(text); alert(this.result.children[0].children[0]);*/ this.result.children[0].children[0].innerHTML = text; this.result.style.visibility = "visible";}
      );
      win.result = inlinePopUp("Loading...", "position: fixed; top: 4em; right: 5em; border: 1px solid blue; background: lightblue url('<%=strPathIncludes%>help/HelpBackground.jpg') repeat scroll left top; color: black; width: 20em; height: 20em; padding: 0em; font-size: 2em; visibility: visible;");
      win.get();
      get("#log").innerHTML += get("#jur-type").value + ":"  + formHash[get("#jur-type").value] + ", " + formHash.state + (get("#jur-type").value == "city" ? " (" + formHash.county + " county)" : "") + " [" + get("#taxtype").value +  "]" + "<br>";
      }
      return;}

     
      function click(button){
        alert(button.toString());
        return;}

      window.onload = init;
    </script>

    <style>
      html {height: 100%; max-height: 100%; overflow: hidden;}
      body {display: block; height: 100%; white-space: nowrap;}
      header {display: block; text-align: center; font-size: 2em; font-weight: bold; margin-top: .5em; margin-bottom: 0em;}
      article {display: inline-block; width: 70%; height: 100%;}
      aside {display: inline-block; border-left: 1px solid black; padding-left: .5em; min-width: 30%; width: 30%; height: 100%;}
      footer {display: block; bottom: 0em; position: absolute; background-color: black; color: grey;}
      footer > em {color: red;}

      article {display: block; min-width: 85%; max-width: 100%;}
      .divDeskTop {height: 0.7em; text-align: center; background-size: 100% 100%; margin-top: 0em; padding: 0.1px;}
      .divDeskMiddle {height: auto; width: auto; background-size: 100% 100%; padding: 0.1px;}
      .divDeskBottom {height: 0.7em; background-size: 100% 100%; margin-bottom: 2em; padding: 0.1px;}
      .on-desk {margin-left: 2em; width: 100%;}

      input[type='submit'] {width: auto;}
      select {width: auto;}
      div#log {display: block; width: auto;}

      /*div {border: 5px solid black; margin: 1px; padding 1px;}*/
    </style>
  </head>
  <body>
    <header>
      <!--#include virtual="z2t_Backoffice/includes/heading-sensible.inc"-->
    </header>

    <div class="article">
      <article>
	<div class="divDeskTop"></div><!-- divDeskTop -->
	<div class="divDeskMiddle">
	  <div class="on-desk">
	    <div id="log" disabled="disabled"></div>
	    <form name="add-city" action="javascript:validate();void(0);">
	      <fieldset>
		<legend>Add a new <select name="jur-type" id="jur-type" onchange="jurChange">
		    <option value="city" selected="selected">city</option>
		    <option value="county">county</option></select></legend>
		<label for="taxtype">Tax Type(s)</label>
		<select id="taxtype" name="taxtype">
		  <option value="1" selected="selected">Sales Tax</option>
		  <option value="2">Use Tax</option>
		  <option value="1,2">Both (Sale Tax & Use Tax)</option>
		</select><br>
		<label for="city">City</label><input type="text" name="city" value=""><br>
		<label for="county">County</label><input type="text" name="county" value=""><br>
		<label for="state">State</label><input type="text" name="state" value=""><br>
		<label for="effective-from">Effective From</label><input type="text" id="effective-from" name="effective-from" value="<%=SqlValue("select ResearchDate = util.dbo.z2t_ResearchDate()", "ResearchDate")%>"><br>
		<label for="effective-to">Effective To</label><input type="text" id="effective-to" name="effective-to" value="<%="2050-12-31"%>"><br>
		<input type="submit" name="add" value="Add">
	      </fieldset>
	    </form>
	  </div>
	</div><!-- divDeskMiddle -->
	<div class="divDeskBottom"></div><!-- divDeskBottom -->
      </article>

    <!--aside>Extra content goes here</aside-->

    <footer>Javascript: <em id="javascript-test">Failed</em></footer>
  </body>
</html>
