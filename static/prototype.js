$(document).ready(function(){
  $("#ticketForm").submit(function( event ) {
     var obj = formToObj(document.querySelector("#ticketForm"));
     var postURL = obj.ticketId === "0" ? "/tickets/create" : "/tickets/update";
     obj.ticketId === "0" ? delete obj.ticketId : obj.ticketId = parseInt(obj.ticketId) ;
     obj.clientPriority === "0" ? delete obj.clientPriority : obj.clientPriority = parseInt(obj.clientPriority) ;
     obj.url === "" ? delete obj.url : obj;
     $.ajax({
       type: "POST",
       url: postURL,
       contentType: 'application/json; charset=utf-8',
       data: JSON.stringify(obj),
     }).done(function() { window.location.replace('/tickets/index') })
       .fail(function() {alert("Somthing Happened and the request failed")});
    event.preventDefault();
  });
});
