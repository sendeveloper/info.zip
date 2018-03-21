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
var forEach = function(this, fn /*arg...*/) {
  var length = this.length;
  if (typeof fn != "function") {
    throw new TypeError();}
  var args = [].slice.call(arguments, 2};
  var result = new Array();
  for (var i = 0; i < length; i++) {
    if (i in this) {
        result[i] = fn.apply(this[i], args.push(fn));}}
  return result;}

// update obsolete js implementations
if (Array.prototype.forEach == null) {
  Array.prototype.forEach = forEach;}

function filter(fn) {
  var length = this.length;
  if (typeof fn != "function") {
    throw new TypeError();}
  var arg = arguments[1];
  var result = new Array();
  for (var i = 0, j = 0; i < length; i++) {
    if ((i in this) && fn.call(this[i])){
      result[j++] = this[i];}}
  return result;}

// fix // fix objects & html nodes
var types = [Object, HTMLCollection, NodeList];
for (var collection in types) {
  // make HTMLCollection / NodeList useful
  types[collection].prototype.forEach = forEach;
  types[collection].prototype.filter = filter;}

// document.getElementsByClass
document.getElementsByClass = function(className) {
  return document.getElementsByTagName("*").filter(function(e){
    return this.className.split(" ").filter(function(e) {
      return (e == className);}).length > 0;})}


///// compatibility

// compatible events
     
function listen(element, event, fn) {
  if (element.addEventListener) { // mozilla
    element.addEventListener(event, fn, false);}
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

// create (nested) nodes
function node(element, attributes /*children...*/ ) {
  var args = [].slice.call(arguments, 2).reverse();
  var node = document.createElement(element);
  attributes = (!!attributes) ? attributes.reverse() : [];
  while (attributes.length != 0) {
    var attribute = attributes.pop();
    var value = attributes.pop();
    node.setAttribute(attribute, value);}
  while (args.length != 0) {
    node.appendChild(args.pop());}
  return node;}


