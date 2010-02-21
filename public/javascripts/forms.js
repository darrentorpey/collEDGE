var TagField = new DUI.Class({
  init: function(field, values, values_field) {
    TagField.objects << this;

    this.separator = ', ';

    this.field = field;
    this.values = values;
    this.values_field = values_field;
    var me = this;
    $.each(this.values, function(index, value) {
      var link = $.create('a', { 'class':'my_link', 'href':'#' }, [value]);
      $(link).click(function() {
        me.toggle_tag(this);
      });
      $(link).appendTo(values_field);
    });
  },
  toggle_tag: function(text) {
    var tags = this.field.val().split(this.separator);
    var val = text.innerHTML;
    if (tags.indexOf(val) >= 0) {
      this.remove_tag(val);
    } else {
      this.add_tag(val);
    }
  },
  add_tag: function(text) {
    if (this.field.val() == '') {
      this.field.val(this.field.val() + text);
    } else {
      var tags = this.field.val().split(this.separator);
      tags.push(text);
      this.field.val(tags.join(this.separator));      
    }
  },
  remove_tag: function(text) {
    var tags = this.field.val().split(this.separator);
    tags = $(tags).not(function(t) { return tags[t] == text; });
    this.field.val(tags.toArray().join(this.separator));
  }
});
TagField.objects = [];