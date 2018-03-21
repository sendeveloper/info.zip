// library of ubiquitous functions

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

// fix objects
var forEach = function(fn) {
  var length = this.length;
  if (typeof fn != "function") {
    throw new TypeError();}
  var result = [];
  for (var i = 0; i < length; i++) {
    //if (i in self) {
    result.push(fn.call(this[i], this[i]));
  //}
  }
  return result;}


//// uniform collections
function forPairs(fn) {
  var result = [];
  for (var key in this) {
    if (this.hasOwnProperty(key)) {
      result.push(fn.call(this, this[key], key));}}
  return result;}

function filter(fn) {
  var length = this.length;
  if (typeof fn != "function") {
    throw new TypeError();}
  var arg = arguments[1];
  var result = [];
  for (var i = 0, j = 0; i < length; i++) {
    if (i in this) {
      //alert(i + "," + this[i]);
      var value = fn.call(this, this[i]);
      if (value) {
        result.push(this[i]);}}}
  return result;}

// fix // fix objects & html nodes
var types = [Object, HTMLCollection, NodeList, Array];
for (var collection in types) {
  // make HTMLCollection / NodeList useful
  types[collection].prototype.forEach = forPairs; //types[collection].length ? forEach : forPairs;
  types[collection].prototype.filter = filter;}

// document.getElementsByClass
document.getElementsByClass = function(className) {
  return document.getElementsByTagName("*").filter(function(e){
    return e.className.split(" ").filter(function(e) {
      return (e == className);}).length > 0;})}


///// compatibility

// compatible events
     
function listen(element, event, fn, /*optional*/ bubble) {
  if (element.addEventListener) { // mozilla
    element.addEventListener(event, fn, !!bubble);}
  else { // others
    element["on" + event] = fn;}
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
  return node;}

/* tests

 inlinePopUp("hr");
 inlinePopUp(node("hr"));
 inlinePopUp([1, 2, 3]);
 inlinePopUp(({a: 7, b: 8, c: 9.0}));
 inlinePopUp(undefined);

*/

