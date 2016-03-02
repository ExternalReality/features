$(document).ready(function(){
  $("#ticketForm").submit(function( event ) {
     var obj = formToObj(document.querySelector("#ticketForm"));
     obj.ticketId === "0" ? delete obj.ticketId : obj;
     obj.clientPriority === "0" ? delete obj.clientPriority : obj;
     obj.url === "" ? delete obj.url : obj;
     $.ajax({
        type: "POST",
        url: "/tickets/create",
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
     }).done(function() { window.location.replace('/tickets/index') })
       .fail(function() {alert("Somthing Happened and the request failed")});
    event.preventDefault();
  });
});
