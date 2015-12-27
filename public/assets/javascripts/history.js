(function() {
  'use strict';
  $(document).ready(function() {
    return $(".btnCreateHistory").on("click", function(e) {
      var data;
      data = {
        subject: $("#historySubject").val(),
        abstract: ""
      };
      return $.ajax({
        type: "POST",
        url: "/api/history",
        data: data
      }).done(function(result) {
        console.log("succed");
        return console.log(result);
      }).fail(function(result) {
        return console.log(result);
      });
    });
  });

}).call(this);
