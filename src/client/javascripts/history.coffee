'use strict'


$(document).ready ->
  $(".btnCreateHistory").on "click",(e)->
    data =
      subject: $("#historySubject").val()
      abstract: ""
    $.ajax({
      type: "POST"
      url: "/api/history"
      data: data
    }).done((result)->
      console.log "succed"
      console.log result
    ).fail((result)->
      console.log result
    )
