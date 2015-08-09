var ready;
ready = function() {

  $('.trim-dropdown').selectize({
      create: true,
      sortField: 'text',
  });

  if($("#show_optional").is(":checked")){
     $('.optional').show();   
  }else{
     $('.optional').hide();
  };

  var ckbox = $('#show_optional');

  $('#show_optional').on('click',function () {
    if (ckbox.is(':checked')) {
      $('.optional').show();
    } else {
       $('.optional').hide();
    }
  });

  // Make-Model Dependent Dropdown 
  var xhr_make;
  var select_make, $select_make;
  var select_model, $select_model;

  $select_make = $('.make-dropdown').selectize({
    create: true,
    onChange: function(value) {
      if (!value.length) return;
      select_model.disable();
      select_model.clearOptions();
      select_model.load(function(callback) {
        xhr_make && xhr_make.abort();
        xhr_make = $.ajax({
          url: '/customers/load_models?make=' + value,
          success: function(results) {
            select_model.enable();
            callback(results);
          },
          error: function() {
            callback();
          }
        })
      });
    }
  });

  $select_model = $('.model-dropdown').selectize({
    create: true,
    valueField: 'name',
    labelField: 'name',
    searchField: ['name']
  });

  select_model  = $select_model[0].selectize;
  select_make = $select_make[0].selectize;

  select_model.disable();

  // Instruction-SVC Dependent Dropdown 1
  var xhr_instruction_one;
  var select_instruction_one, $select_instruction_one;
  var select_svc_one, $select_svc_one;

  $select_instruction_one = $('.instruction-dropdown').eq(0).selectize({
    create: true,
    onChange: function(value) {
      if (!value.length) return;
      select_svc_one.disable();
      select_svc_one.clearOptions();
      select_svc_one.load(function(callback) {
        xhr_instruction_one && xhr_instruction_one.abort();
        xhr_instruction_one = $.ajax({
          url: '/customers/load_prices?service=' + value,
          success: function(results) {
            select_svc_one.enable();
            select_svc_one.open();
            callback(results);
          },
          error: function() {
            callback();
          }
        })
      });
    }
  });

  $select_svc_one = $('.svc-dropdown').eq(0).selectize({
    create: true,
    valueField: 'price',
    labelField: 'price',
    searchField: ['price'],
  });

  select_svc_one  = $select_svc_one[0].selectize;
  select_instruction_one = $select_instruction_one[0].selectize;

  select_svc_one.disable();

  // Instruction-SVC Dependent Dropdown 2
  var xhr_instruction_two;
  var select_instruction_two, $select_instruction_two;
  var select_svc_two, $select_svc_two;

  $select_instruction_two = $('.instruction-dropdown').eq(3).selectize({
    create: true,
    onChange: function(value) {
      if (!value.length) return;
      select_svc_two.disable();
      select_svc_two.clearOptions();
      select_svc_two.load(function(callback) {
        xhr_instruction_two && xhr_instruction_two.abort();
        xhr_instruction_two = $.ajax({
          url: '/customers/load_prices?service=' + value,
          success: function(results) {
            select_svc_two.enable();
            select_svc_two.open();
            callback(results);
          },
          error: function() {
            callback();
          }
        })
      });
    }
  });

  $select_svc_two = $('.svc-dropdown').eq(3).selectize({
    create: true,
    valueField: 'price',
    labelField: 'price',
    searchField: ['price'],
  });

  select_svc_two  = $select_svc_two[0].selectize;
  select_instruction_two = $select_instruction_two[0].selectize;

  select_svc_two.disable();

  // Instruction-SVC Dependent Dropdown 3
  var xhr_instruction_three;
  var select_instruction_three, $select_instruction_three;
  var select_svc_three, $select_svc_three;

  $select_instruction_three = $('.instruction-dropdown').eq(6).selectize({
    create: true,
    onChange: function(value) {
      if (!value.length) return;
      select_svc_three.disable();
      select_svc_three.clearOptions();
      select_svc_three.load(function(callback) {
        xhr_instruction_three && xhr_instruction_three.abort();
        xhr_instruction_three = $.ajax({
          url: '/customers/load_prices?service=' + value,
          success: function(results) {
            select_svc_three.enable();
            select_svc_three.open();
            callback(results);
          },
          error: function() {
            callback();
          }
        })
      });
    }
  });

  $select_svc_three = $('.svc-dropdown').eq(6).selectize({
    create: true,
    valueField: 'price',
    labelField: 'price',
    searchField: ['price'],
  });

  select_svc_three  = $select_svc_three[0].selectize;
  select_instruction_three = $select_instruction_three[0].selectize;

  select_svc_three.disable()
};

$(document).ready(ready);
$(document).on('page:load', ready);