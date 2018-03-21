// Source: lib.js
// Version: 2012-05-02.2
// Description: library of ubiquitous functions

window.onerror = function(message, file, line) {alert([file,line,message].join(" : "));}

// test for number
function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}


// comparison
function min(a, b) {
  return a <= b ? a : b;}

function max(a, b) {
  return a >= b ? a : b;}

///// javascript ugliness

// return value unless it is null or undefined; then return alternative
function ifnull(value, alternative) {
  return ((typeof(value) == "undefined") || (value === null)) ? alternative : value;}

// preserve the built-ins for inter-library compatibility
////var oldForEach = (typeof(forEach) == "undefined") ? function(){alert('undefined function call');} : forEach;
////var oldFilter = (typeof(filter) == "undefined") ? function(){alert('undefined function call');} : filter;

// fix objects
var forEach = function(fn) {
  var length = this.length;
  if (typeof(fn) != "function") {
    return undefined; // jQuery compatibility hack
    throw new TypeError("forEach: fn is not a function");}
  var result = [];
  for (var i = 0; i < length; i++) {
    //if (i in self) {
    result.push(fn.call(this[i], this[i]));
  //}
  }
  return result;}
forEach.replace = function(){return "forEach";}; // jQuery compatibility hack

//// uniform collections
function forPairs(fn) {
  if (typeof(fn) != "function") {
    return undefined; // jQuery compatibility hack
    inspect(fn);
    var exception = new TypeError("forPairs: fn is not a function"); alert(exception.stack.toString());
    throw new TypeError("forPairs: fn is not a function");}
  var result = [];
  for (var key in this) {
    if (this.hasOwnProperty(key)) {
      result.push(fn.call(this, this[key], key));}}
    return result;}

////  else { // jQuery compatibility
////    this.oldForEach.apply(this, arguments);}}
forPairs.replace = function(){return "forPairs";}; // jQuery compatibility hack

function inspect(object) {
  var string = ""
  alert(typeof(object) == "object");
  for (var property in object){
    if (object.hasOwnProperty(property)) {
      string += property + ": " + object[property] + "\n";}}
  alert(string);}

function removeIfNot(fn) {
  var length = this.length;
  if (typeof(fn) != "function") {
    return undefined; // jQuery compatibility hack
    throw new TypeError("removeIfNot: fn is not a function");}
  var arg = arguments[1];
  var result = [];
  for (var i = 0, j = 0; i < length; i++) {
    if (i in this) {
      //alert(i + "," + this[i]);
      var value = fn.call(this, this[i]);
      if (value) {
        result.push(this[i]);}}}
  return result;}
removeIfNot.replace = function(){return "removeIfNot";}; // jQuery compatibility hack

function removeIfNotOld(fn) {
  var length = this.length;
//  if (typeof(fn) != "Function") {
//    throw new TypeError("removeIfNot: fn is not a function");}
  var arg = arguments[1];
  var result = [];
  for (var i = 0, j = 0; i < length; i++) {
    if (i in this) {
      //alert(i + "," + this[i]);
      if (typeof(fn) == "Function") {
      var value = fn.call(this, this[i]);
      if (value) {
        result.push(this[i]);}}}}
  return result;}
////  else { //jQuery compatibility
////    this.oldFilter.apply(this, arguments);}}

// fix // fix objects & html nodes
var types = [Object, HTMLCollection, NodeList];
for (var collection in types) {
  // make HTMLCollection / NodeList useful
////  if (types[collection].prototype.forEach) {
////    types[collection].prototype.oldForEach = types[collection].prototype.forEach;}
  types[collection].prototype.forEach = forPairs; //types[collection].length ? forEach : forPairs;
////    types[collection].prototype.oldFilter = types[collection].prototype.filter;}
////  types[collection].prototype.oldFilter = types[collection].prototype.filter
  types[collection].prototype.removeIfNot = removeIfNot;
}
Array.prototype.forEach = forEach;

// document.getElementsByClass
document.getElementsByClass = function(className) {
  return document.getElementsByTagName("*").removeIfNot(function(e){
    return e.className.split(" ").removeIfNot(function(e) {
      return (e == className);}).length > 0;})}


///// compatibility

// compatible events

var listeners = []; // [[element, event, fn, bubblep]]
var listen =
(function(){
  function chain (event){
    listeners.removeIfNot(function(e){return (event.target == e[0]) && (event.type == e[1]) /*&& (!!bubblep == e[3])*/;}).forEach(function(e){return e[2](event);})}
  return (
  function listen(element, event, fn, /*optional*/ bubblep) {
    if (listeners.indexOf([element, event, fn, !!bubblep]) > -1) {return "Event handler already installed";}
    if (element.addEventListener) { // mozilla
      element.addEventListener(event, fn, !!bubblep);}
    else { // others -- chain the event handlers
      if (element["on" + event] != chain) {
        if (element["on" + event]) {
          listeners.push = [element, event, element["on" + event], !!bubblep];}
        element["on" + event] = chain;}}
    listeners.push([element, event, fn, !!bubblep]);
    return fn;});})();

function unlisten(element, event, fn, bubblep) {
  if (element.removeEventListener) { // mozilla
    element.removeEventListener(event, fn, !!bubblep);}
  listeners.splice(listeners.indexOf([element, event, fn, !!bubblep]), 1);
  return fn;}

///// dom

// find elements in page (returns array when class or tagname are used)
//   use .class, #id, tagname, or _tagname
//
//  FIXME: pseudo selectors and [properties] are not supported -- yet.
function get(id) {
  switch (ifnull(id.match(/^(?:\.)|(?:#)|(?:_)/), [""])[0]) {
  case ".": // class
    return document.getElementsByClass(id.replace(/^\./, ""));
    break;
  case "#": // id
    return document.getElementById(id.replace(/^#/, ""));
    break;
  case "_": // tag
  default:
    return document.getElementsByTagName(id.replace(/^_/, ""));
    break;}
  throw("Inaccessible code section accessed");
  return undefined;}

// Return boolean value of whether OBJ is undefined.
// If ALTERNATIVE is supplied, return OBJ when defined; defaulting to ALTERNATIVE.
function undef(obj, /*optional*/ alternative) {
  var altform = !(typeof(alternative) == "undefined")
  var isUndefined = (typeof(obj) == "undefined");
  return altform ? (isUndefined ? alternative : obj) : isUndefined;}


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


function num(e, defaultValue) {
  if (typeof(e) == "undefined") {
    return defaultValue;}
  // careful here -- all sorts of things get coerced to NaN -- unless they are coerced to zero
  else if (isNaN(e)) {
    return defaultValue;}
  else if (e == null) {
    return defaultValue;}
  else {
    return e;}}


function str(e) {
  return undef(e, "<undefined>").toString();}


function identity(e) {return e};


function verily(e) {return true;}


//function fmap(fn, list) {return forPairs.call(list, fn);}
function fmap(fn /*, list ... */) {
  var lists = [].slice.call(arguments, 1);
  var firsts = [];
  var rests = [];
  for (var index = 0; index < lists.length; index++) {
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
  for (var index = 0; index < lists.length; index++) {
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
function ffilter(predicate, list) {return [].slice.call(list).filter(predicate);}
// function ffilter(predicate /*, lists */) {
//   var lists = [].slice(arguments, 1)
//   var length = this.length;
//   if (typeof fn != "function") {
//     throw new TypeError();}
//   var arg = arguments[1];
//   var result = [];
//   for (var i = 0, j = 0; i < length; i++) {
//     if (i in this) {
//     //alert(i + "," + this[i]);
//   var value = fn.apply(this, this[i]);
//   if (value) {
//     result.push(this[i]);}}}
//   return result;}


// // apply without the silly (and annoying) implicit THIS
// function fapply(fn /*, args */) {
//   return fn.apply(null, [].slice(arguments, 1));}

// find element lists ala css-selectors
function get(selectors /*, root */) {
  var root = arguments[1];
  //alert("[" + selectors + ", " +  root + "]");
  selectors = (undef(selectors.length) || typeof(selectors) == "string") ? [selectors] : selectors;
  selectors = selectors.reverse();
  var e = root ? [root] : [document];
  for (var query = selectors.pop(); (e.length > 0) && query; query = selectors.pop()) {
    e = [].concat.apply(fmap(function(it){return it ? [].slice.apply(it.querySelectorAll(query)) : [];}, e));}
  //alert("{" + fmap(function(a){return fmap(function(b){return b.parentNode;}, a);}, e)  + "}");
  return [].concat.apply(e);}


// create plain text node
function text(string) {
  return document.createTextNode(string);}

// create entity reference
function entity(string) {
  return document.createEntityReference(string);}

var nodeEvents = []; // array of [event-name, handler-function, filter]

// create (nested) nodes -- children are HTML nodes or lists of HTML nodes
function node(element, attributes /*children...*/ ) {
  var args = [].slice.call(arguments, 2).reverse();
  var node = document.createElement(element);
  attributes = (!!attributes) ? attributes.reverse() : [];
  while (attributes.length != 0) {
    var attribute = attributes.pop();
    var value = attributes.pop();
    node.setAttribute(attribute, value);}
  while (args.length != 0) {
    var nodelist = args.pop();
    if (nodelist instanceof Array) {
      nodelist.forEach(function(e){node.appendChild(e);})}
    else {
      node.appendChild(nodelist);}}
  nodeEvents.forEach(function(eventHandler){if ((typeof(eventHandler[2] == "undefined") || eventHandler[2](node))) {listen(node, eventHandler[0], eventHandler[1])} return;});
  return node;}


// add a class to an element (classSpecifier can be space-separated string of multiple classes to add)
function classify (e, classSpecifier) {
  e.className = ok(e.className, "");
  fmap(function(eachClass) {
    if (e.className.split(" ").indexOf(eachClass) == -1) {
      e.className += " " + eachClass};},
        classSpecifier.split(" "));
  return e.className;}


// remove a class from an element (classSpecifier can be space-separated string of multiple classes to remove)
function declassify(e, classSpecifier) {
  var classesBeingRemoved = classSpecifier.split(" ");
  return e.className = ffilter(function(eachClass){return (classesBeingRemoved.indexOf(eachClass) == -1);},
                                 e.className.split(" ")).
    join(" ");}


var css = (function css() {
  var computedstyle = (typeof(window) != "undefined") ? window.getComputedStyle : function(){return element.currentStyle};
  return function(element){return computedstyle(element);}})();

function px(number) {
  return number.toString() + "px";}

function hide(node) {
  //node.style.oldDisplay = node.style.display;
  return node.style.visibility = "hidden";}

function show(node) {
  return node.style.visibility = "visible";}


function xy(obj) {
  if (typeof(obj.offsetParent) == "undefined") {throw("Legacy browser does not support javascript");}
  for(var position = [0,0]; obj; obj = obj.offsetParent) {
    position[0] += obj.offsetLeft;
    position[1] += obj.offsetTop;}
  return position;}


//// display

var gensym = (function() {
  var gensymCount = 0;
  return function gensym(base) {
    gensymCount += 1;
    return ((typeof(base) == "undefined") ? "G" : base + "-") + gensymCount.toString();}})();


function toHtml() {
    if (typeof(this) == "undefined") {return text("&lt;undefined&gt;");}
    else if (this instanceof HTMLElement) {return this;}
    else if (this instanceof String) {return text(this);}
    else if (this instanceof Number) {return text(this.toString());}
    else if (this instanceof Array) {return node.apply(this, ["ul", []].concat(this.forEach(function(e){return node("li", [], e.toHtml());})));}
    else if (this instanceof Object) {return node.apply(this, ["dl", []].concat(this.forEach(function(value, key){return [node("dt", [], key.toHtml()), node("dd", [], value.toHtml())]})));}
    else {text(this.toString());}
    return undefined;}
toHtml.replace = function(){return "toHtml";}; // jQuery compatibility hack


/* FIXME: a work in progress
function stringify(e) {
  return "{" + e.forEach(function(v, k){return k + ": " + v;}).join(", \n") + "}";}
Object.prototype.toString = stringify;
*/

Object.prototype.toHtml = toHtml;


// Display body in a pop-up div.  body is an html node.
function inlinePopUp(body, /* optional */ style){
  if (typeof(body) == "undefined") {body = text("{undefined}");}
  else {body = body.toHtml();}
  style = (typeof(style) != "undefined") ? style : "position: absolute; top: 4em; right: 5em; border: 1px solid black; background-color: lightblue; color: black; width: 40em; height: 40em; padding: 0em; overflow: auto; height: 10em; max-height: 80%;";
  var popup, inner, content, closediv, close;
  var id = gensym("popup");
  popup = node("div", ["id",id, "class","popup", "style",style], inner = node("div", ["style","height: 100%; width: 100%; overflow: auto;"], content = node("div", ["style","width: 100%; height: 85%; /* border: 1px solid black; */ top: 1em; margin: 1em; overflow: auto;"], body), closediv = node("div", ["style","width: 100%; height: 100%; text-align: center;"], close = node("button", ["onclick","this.blur(); hide(get(\"#" + id + "\"));", "style","margin-left: auto; margin-right: auto; width: auto; height: auto; text-align: center; margin-top: 1em; margin-bottom: 1em; position: absolute; bottom: 1em;"], text("Close")))));
  inner.appendChild(closediv.cloneNode(true));
  with (closediv.style) {
    bottom = null;
    top = "1em";
    right = "1em";}
  get("body")[0].appendChild(popup);
  close.focus();
  return popup;}


//// help

function help(helpId) {
  var win = ajax("http://info.zip2tax.com/z2t_BackOffice/Research/z2t_ResearchOperations_operate.asp?op=" + helpId, function(body){this.result.children[0].children[0].innerHTML = body; this.result.style.visibility = "visible"; return;});
  var titleHelp = ["research-operations", "help-add-jurisdiction"].indexOf(helpId) >= 0;
  win.result = inlinePopUp(titleHelp ? "Loading..." : helpId,  "position: fixed; top: 4em; right: 5em; border: 1px solid blue; background: lightblue url('<%=strPathIncludes%>help/HelpBackground.jpg') repeat scroll left top; color: black; width: auto; height: 20em; padding: 0em; font-size: 2em; visibility: hidden;");
  if (titleHelp) {win.result.style.width = "auto"; win.result.style.maxWidth="90%"; win.result.style.right = "5%"; win.result.style.height = "40em"; win.result.maxHeight = "80%"; win.result.style.top="5%";}
  win.get();
  return win;}


//// ajax

function ajaxDefaultError(body) {
  switch (this.status) {
  case 0:
    inlinePopUp(node("div", [], node("h1", ["style","font-size: 1.5em; font-weight: bold;"], text("Unreachable URL")), node("br"), text(this.url)));
    return;
    break;
  default:
    var errorText;
    var errorBox = inlinePopUp(errorBox = node("div", [], node("h1", ["style","font-size: 1.5em; font-weight: bold;"], text(this.status.toString() + ": " + this.statusText)), node("div", [], errorText = node("div"))));
    errorText.innerHTML = this.responseText;
    errorBox.style.width = "auto";
    errorBox.style.maxWidth = "90%";
    errorBox.style.height = "auto";
    errorBox.style.maxHeight = "90%";
    return;
    break;}
  return;}

function ajaxChange(state) {
  try {
    var states = {0: "uninitialized", 1: "loading", 2: "loaded", 3: "interactive", 4: "complete"};
    var status = {0: "unreachable", 404: "not found", 200: "success", 500: "server error"};

    switch (this.readyState) {
    case 4:
      //alert("State: " + this.readyState +  " Status: " + this.status + " / " + this.responseText);
      //inlinePopUp(node("div", [], node("h1", [], text(this.status.toString())), text((this.status == 200) ? this.responseText : this.responseText)));
      switch (this.status) {
      case 200:
        this.fn.call(this, this.responseText);
        break;
      default:
        this.error.call(this, this.responseText);
        return;
        break;}
      break;
    default:
      //alert("State: " + this.readyState + " Status: " + this.status + " / " + this.responseText);
      //inlinePopUp(node("div", [], text("Error: " + this.status.toString() + " / " + this.responseText)));
      break;}
    return;
  } catch(error) {alert(error); return;}}

function ajaxDefaultFn(body) {
  var n;
  inlinePopUp(n = node("div"));
  n.innerHTML = body;
  return;}

// Use FN for callback; store any data in the object returned from the call to AJAX
function ajax(url, /*optional*/ fn, error) {
  var http = new XMLHttpRequest();

    http.get = function ajaxGet(/*optional*/ synchronous) {
    http.open("GET", url, synchronous);
    return http.send();} ;

    http.post = function ajaxPost(params, /*optional*/ synchronous) {
      http.open("POST", url, synchronous);
      http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      http.setRequestHeader("Content-length", params.length);
      http.setRequestHeader("Connection", "close");
      return http.send(params);}

  http.onreadystatechange = ajaxChange;
  http.fn = (typeof(fn) == "undefined") ? ajaxDefaultFn : fn;
  http.error = (typeof(error) == "undefined") ? ajaxDefaultError : error;
  http.url = url;
  //http.send(null); // allow caller to send post data or store ancillay data in the http request obect
  return http;}

var ajaxPath = null; // user must define the default ajaxPath
// Append (or REPLACE) PLACE with the response from ajaxPath (sending post DATA)
function action(place, data, replace) {
  if (!ajaxPath) {
    return alert("No ajaxPath was specified.")}
  var h = ajax(ajaxPath,
               function actionCallback(body) {
                 get(place)[0][0].toMe(function(e){
                   if (replace) {
                     e.innerHTML = body;}
                   else {
                     e.appendChild(node("div").toMe(function(e){e.innerHTML = body;}));
                     //e.appendChild(text(body));
                   }})},
               function actionError(body){
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


var json = (function(){
/*
Node type             nodeName returns              nodeValue returns    
Document              #document                     null                 
DocumentFragment      #document fragment            null                 
DocumentType          doctype name                  null                 
EntityReference       entity reference name         null                 
Element               element name                  null                 
Attr                  attribute name                attribute value      
ProcessingInstruction target                        content of node      
Comment               #comment                      comment text         
Text                  #text                         content of node      
CDATASection          #cdata-section                content of node      
Entity                entity name                   null                 
Notation              notation name                 null                 
*/

  var nodeType = {1: "element",
                  2: "attribute",
                  3: "text",
                  4: "cdata",                     
                  5: "entity-reference",
                  6: "entity",
                  7: "processing-instruction",
                  8: "comment",
                  9: "document",
                  10: "document-type",
                  11: "document-fragment",
                  12: "notation"};
  return
  function json(xml){
    // Create the return object
    var jsonObject = {};
    if  (xml.nodeType == 1) { // element
      // do attributes
      xml.attributes.forEach(function(e){
        jsonObject["@attributes"][e.nodeName] = e.nodeValue;
        return;})}
    else if (xml.nodeType == 3) { // text
      jsonObject = xml.nodeValue;}
    
    xml.childNodes.forEach(function(e){
      jsonObject[undef(e.nodeName, "")] = xml(e);})
    
    
    // do children
    if (xml.hasChildNodes()) {
      for(var i = 0; i < xml.childNodes.length; i++) {
        var item = xml.childNodes.item(i);
        var nodeName = item.nodeName;
        if (typeof(obj[nodeName]) == "undefined") {
          obj[nodeName] = xmlToJson(item);}
        else {
          if (typeof(obj[nodeName].push) == "undefined") {
            var old = obj[nodeName];
            obj[nodeName] = [];
            obj[nodeName].push(old);}
          obj[nodeName].push(xmlToJson(item));}}}
    return json;};})();


//// support pipelines with "toMe" -- apply the function to this
Object.prototype.toMe = function toMe(fn) {
  fn.apply(this, [this].concat([].slice.call(arguments, 1)));
  return this;}
