$.create = function() {
  var ret = [], a = arguments, i, e;
  a = a[0].constructor == Array ? a[0] : a;
  for(i=0; i<a.length; i++) {
    if(a[i+1] && a[i+1].constructor == Object) { // item is element if attributes follow
      e = document.createElement(a[i]);
      $(e).attr(a[++i]); // apply attributes
      if(a[i+1] && a[i+1].constructor == Array) $(e).append($.create(a[++i])); // optional children
      ret.push(e);
    } else { // item is just a text node
      ret.push(document.createTextNode(a[i]));
    }
  }
  return ret;
};

$.tpl = function(json, tpl) {
  var ret = [];
  jQuery.each(json.constructor == Array ? json : [json], function() {
    var o = $.create(tpl.apply(this));
    for(var i=0;i<o.length;i++) ret.push(o[i]);
  });
  return ret;
};