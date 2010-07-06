// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// application.js
function clear_form_elements(ele) {
  $(ele).find(':input').each(function() {
    switch(this.type) {
      case 'password':
      case 'select-multiple':
      case 'select-one':
      case 'text':
      case 'textarea':
        $(this).val('');
        break;
      case 'checkbox':
      case 'radio':
        this.checked = false;
    }
  });
}

// Usage: jQuery('#my_form').preventDoubleSubmit();
jQuery.fn.preventDoubleSubmit = function() {
  jQuery(this).submit(function() {
    if (this.beenSubmitted)
      return false;
    else
      this.beenSubmitted = true;
  });
};

