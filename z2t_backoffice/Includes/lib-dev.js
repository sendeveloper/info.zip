// Source: lib.js 
// Version: 2012-05-02.2
// Description: library of ubiquitous functions

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


var css = (function() {
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

    http.get = function() {
    http.open("GET", url, true);
    return http.send();} ;

    http.post = function(params) {
      http.open("POST", url, true);
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

