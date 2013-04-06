# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  loadStates = ->
    # disable dropdown until states are successfully retrieved and listed
    document.getElementById("states").disabled = true

    # first clear out any options
    document.getElementById("states").options.length = 0

    # make the AJAX request to the server
    $.get("/api/v1/states", {}).success((result) ->
      # why would you need to check for 'success'? would an empty states array be enough for a failure?
      if 1 is 1 or result.status is "SUCCESS"
        states = result.states

        i = 0
        while i < states.length
          # Create an Option object
          opt = document.createElement("option")
          opt.value = states[i].id
          opt.text = states[i].name
          document.getElementById("states").options.add opt
          i++

        # enable dropdown since states were successfully retrieved and listed
        document.getElementById("states").disabled = false
        # load all the cities associated with this state
        loadCities states[0].id
      else
        alert "Could not retrieve states from server."
    ).error (xhr, textStatus, errorThrown) ->
      alert "Could not retrieve states from server."

  loadCities = (state_id) ->
    # disable dropdown until states are successfully retrieved and listed
    document.getElementById("cities").disabled = true

    # first clear out any options
    document.getElementById("cities").options.length = 0

    # make the AJAX request to the server
    $.get("/api/v1/cities",
      state_id: state_id
    ).success((result) ->
      # why would you need to check for 'success'? would an empty cities array be enough for a failure?
      if 1 is 1 or result.status is "SUCCESS"
        cities = result.cities

        i = 0
        while i < cities.length
          # Create an Option object
          opt = document.createElement("option")
          opt.value = cities[i].id
          opt.text = cities[i].name
          document.getElementById("cities").options.add opt
          i++

        # enable dropdown since cities were successfully retrieved and listed
        document.getElementById("cities").disabled = false
      else
        alert "Could not retrieve cities from server."
    ).error (xhr, textStatus, errorThrown) ->
      alert "Could not retrieve cities from server."

  loadStates()

  $("#states").change ->
    state_id = $("#states").val()
    loadCities state_id

  $("#cancel").click ->
    location.href = "/posts"
