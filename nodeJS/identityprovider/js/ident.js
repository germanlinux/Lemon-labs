$( function() {
  // cook name ???
  //--------------
  var cookName = '';
  ( function () {
    $.ajax({
      url : '/gimcookin',
      type: 'POST', 
      dataType: "json",
      success: function( data ) {
        if( data.result == 'ok' ){
          cookName = data.cookname;
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('error ' + textStatus + " " + errorThrown);
      }
    });
  } )();

  
  
  $('#userid').focus()
  .keyup( function ( ev ) {
    if( ev.keyCode == 13 ){
      $('#userpw').focus();
    }
  });
  
  $('#userpw').keyup( function ( ev ) {
    if( ev.keyCode == 13 ){
      $('#sendvalid').click();
    }
  });
  
  $('#sendvalid').click( function () {
    var pars = { user : $('#userid').val(),
                 pass : $('#userpw').val() };
    if( pars.user.length < 2 ){
      alert( '?? User ??' );
      $('#userid').focus();
      return;
    }
    if( pars.pass.length < 2 ){
      alert( '?? Password ??' );
      $('#userpw').focus();
      return;
    }
    $.ajax({
      url : '/verify',
      type: 'POST', 
      data: pars,
      dataType: "json",
      success: function( data ) {
        if( data.result == 'ok' && data.habilit == 'ok' ){
          var options = { 'path': '/', 'domain' : 'demo.appli' };
          $.cookie( cookName, data.luid, options);
          //alert( 'uuid=' + data.luid );
          var cible = $('#forurl').text();
          $(location).attr('href', cible );
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('error ' + textStatus + " " + errorThrown);
      }
    });
  } );
});


