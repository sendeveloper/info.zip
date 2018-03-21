<%
  Session("Redirect") = ""
  ColorTab = 3
  PageHeading = "Tax Data Edit: Canada"
%>

<!--#include file="includes/top.inc"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<script>
  var changes = [];

  function debug(/* args */) {
    var args = [].slice.call(arguments);
    return alert("debug: {" + args.forEach(function(e){return ok(e, "<undefined>").toString()}).join(", ") + "}");}
  

  ajaxPath = "ajax.asp";

  function action(place, data, replace) {
    var h = ajax(ajaxPath, 
      function(body) {
        get(place)[0][0].toMe(function(e){
          if (replace) {
            e.innerHTML = body;}
          else {
            e.appendChild(node("div").toMe(function(e){e.innerHTML = body;}));
          //e.appendChild(text(body));
        }})},
      function(body){
        get(place)[0][0].toMe(function(e){
          if (replace | !replace) {
            e.appendChild(node("div").toMe(function(e){
              e.appendChild(text("error: "));
              e.appendChild(
                node("div", ["style","display: inline-block; vertical-align: top;"]).
                  toMe(function(e){e.innerHTML = body;}));
              e.appendChild(
                node("button",[], 
                  text("Clear")).
                  toMe(function(e){
                    listen(e, "click", function(e){
                      e.target.parentNode.parentNode.removeChild(e.target.parentNode);})}))}))}})});
   // h.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    h.post(data.forEach(function(v, k){return [k.toString(), encodeURIComponent(v.toString())].join("=")}).join("&"));}


  listen(window, "load", function(e){
    get("#catalog")[0][0].toMe(function(e){
      e.selectedIndex = ffilter(
                         function(e){
                           return e.value === "z2t_Canada";},
                         e.options)});
    get(".resultset td").forEach(function(e){e.forEach(function(e){
      var parent = e;
      e.undo = e.innerHTML;
      listen(e, "dblclick", function(e){
        e.target.toMe(function(e){
          var content = e.innerHTML;
          e.childNodes.forEach(function(e){
            if (typeof(e.parentNode) === "undefined") {return;} // webkit bug
            e.parentNode.removeChild(e)});
          e.appendChild(node("input", ["type","text", "value",content, "size",content.length, "style","width: auto;"]).toMe(function(e){
                          e.editing = parent;
                          listen(e, "change", function(e){
                            classify(e.target.editing, "modified");
                            if (!e.target.editing.changeNode) {
                              e.target.editing.changeNode = {node: e.target.editing,
                                                             undo: []};
                              changes.push(e.target.editing.changeNode);}
                            e.target.editing.changeNode.toMe(function(changeNode){
                              changeNode.undo.push(e.target.editing.undo);});
                            e.target.editing.innerHTML = e.target.editing.undo = e.target.value;
                            e.target.editing = null;});
                          listen(e, "blur", function(e){
                              if ((e.target.editing) && e.target.parentNode) {
                                e.target.parentNode.innerHTML = e.target.value;}});}));
          e.edited = false;
          e.childNodes[0].select();})});})});

    listen(get("button.save")[0][0], "click", function(e){
      var modifiedAnything = false;
      get(".modified").forEach(function(e){e.forEach(function(e){
        modifiedAnything = true;
        message("acting: " + e);
        declassify(e, "modified");
        action(".ajax-status", {command: "save", 
                                field: e.className,
                                type: e.getAttribute("rel"),
                                value: e.innerHTML,
                                table: e.parentNode.parentNode.parentNode.parentNode.parentNode.id.split(".").last(), 
                                where: "id=" + e.parentNode.querySelector("td").innerHTML});
        e.undo = e.innerHTML;
        e.changeNode = null;});
      message(modifiedAnything ? "Changes saved." : "No changes to save.");})
      changes = [];});
    listen(get("button.revert")[0][0], "click", function(e){
      var modifiedAnything = false;
      changes.forEach(function(e){
        modifiedAnything = true;
        e.node.undo = e.undo[0];
        e.node.innerHTML = e.undo[0];
        e.node.changeNode = null;
        declassify(e.node, "modified");});
      message(modifiedAnything ? "Discarded changes." : "No changes to discard.");
      changes = [];});});

  function message(messageText) {
    get(".ajax-status")[0][0].toMe(function(e){
      e.appendChild(node("div", [], text(messageText)));
      e.scrollTop = e.scrollHeight;})
    return;}

  function last() {
    return this[this.length - 1];}
  Object.prototype.last = last;
</script>
<style>
  nav {height: 18%;}
  .divDeskTop {height: 78%;}

  button.save, button.revert {margin-left: 1em; vertical-align: baseline;}
  h {margin-bottom: 1em; display: inline-block;}
  .modified {border: 1px solid red;}
  .ajax-status {display: inline-block; margin-left: 2em; height: 5em; overflow: scroll; min-width: 45em; max-width: 45em; vertical-align: middle;}

  .edit {width: 1200px; white-space: normal; overflow: scroll;}
  .edit h {margin: 1em; font-size: 10pt;}
/*  .table h {margin-top: 1em; margin-bottom: 0em; font-size: 80%; display: block; text-align: left;}*/
  .table h {text-align: center; font-weight: bold; font-size: 14pt; display: inline-block;}
  div.resultset {margin-top: 1em; margin-bottom: 1em; /*display: inline-block;*/}
  .resultset td {font-size: 100%;} 
  .group div {display: inline-block; margin-left: 1em; margin-right: 1em; vertical-align: top;}
  .group h {text-align: center;}
</style>
<%
  sqlFieldTypes = True
  Set rs = sql("select * from philly05.z2t_Canada.dbo.z2t_Canada_ProvinceInfo order by Province")
%>
    <div class="edit">
      <h>Edit</h><button class="save">save</button><button class="revert">revert</button><div class="ajax-status"></div><hr>
<%
  Dim tables: tables = "z2t_Canada.dbo.z2t_Canada_ProvinceInfo;Province,Id/" &_
                       "z2t_Backoffice.dbo.z2t_Types;class,sequence/" &_
                       "z2t_Canada.dbo.z2t_Canada_PostalCodes;Province,City,PostalCode/" &_
                       "z2t_Canada.dbo.z2t_Canada_Export_2013_01;Province,City,PostalCode/" &_
                       "z2t_UpdatePostalCodes.dbo.z2t_Canada_PostalCodes_2012_03;Province,City,PostalCode"
  Call ShowTables(tables)
%>

        <div class="group">
<!--%

  tables = "dallas01.ha_BackOffice.dbo.ha_service_JobTypes;id/" &_
           "dallas01.ha_BackOffice.dbo.ha_service_NotificationMethods;id"
  Call ShowTables(tables)
%-->
          </div>
        </div>
    </div>

<!--#include file="includes/bottom.inc"-->

<%
' tables is a slash-separated string of semicolon-separated pairs table;orderby
Function ShowTables(tables)
  For each TableString in Split(tables, "/")
     Dim TablePair: TablePair = Split(TableString, ";")
     Dim table: table = TablePair(0)
     Dim orderby: orderby = TablePair(1)
      
     Response.Write("<div id=""" & table & """ class=""table"">")
     Response.Write("<h>" & LastDot(table) & "</h>")
     Call sqlTableInsert("select top 10 * from " & table & " order by " & orderby)
     Response.Write("</div>")
  Next
End Function

Function LastDot(text)
  Dim parts: parts = Split(text, ".")
  LastDot = parts(Ubound(parts))
End Function


Function present(stream, e) 
   stream.addChild()
End Function   
%>
