# Usually I will have this in an ENV var but have it here for simplicity
token = 'UyyfCjtntdUtqh7ZoDkd0H1KM'
baseUrl = 'https://data.cityofchicago.org/resource/energy-usage-2010.json'
results = $('#results')
spinner = $('.spinner')

# Wrapper for making API calls
api =
  getResidential: (url, data) ->
    data ||= {}
    data.$$app_token = token
    data.community_area_name = 'Hermosa'
    data.building_type = 'Residential'

    $.ajax
      url: url
      data: data

  getCommercial: (url, data) ->
    data ||= {}
    data.$$app_token = token
    data.community_area_name = 'Hermosa'
    data.building_type = 'Commercial'

    $.ajax
      url: url
      data: data

clearRows = -> results.html ''

# Draw a single row
drawRow = (building) ->
  html =
    "<tr>
      <td>#{building.building_subtype}</td>
      <td>#{building.total_kwh}</td>
      <td>#{building.total_therms}</td>
    </tr>"

  results.append html

showSpinner = -> spinner.velocity 'transition.slideUpIn', 300

hideSpinner = -> spinner.velocity 'transition.slideDownOut', 300

# Create a table
successHandler = (data) ->

  # Draw the building for each row
  for building in data
    drawRow building

  results.find('tr').velocity 'transition.flipYIn', stagger: 75

# Create an empty table with an error message
errorHandler = (err) ->
  html =
    '<tr>
      <td>Error communicating with server. Please try again later</td>
    </tr>'

  results.append html
  results.find('tr').velocity 'transition.flipYIn', stagger: 75

# Display the data for Residential buildings
displayResidential = ->
  clearRows()
  showSpinner()

  residential = api.getResidential "#{baseUrl}"
  residential.success (data) ->
    hideSpinner()
    successHandler data

  residential.error (err) ->
    hideSpinner()
    errorHandler err

# Display the data for Commercial buildings
displayCommercial = ->
  clearRows()
  showSpinner()

  commercial = api.getCommercial "#{baseUrl}"
  commercial.success (data) ->
    hideSpinner()
    successHandler data

  commercial.error (err) ->
    hideSpinner()
    errorHandler err

$(document).ready ->
  displayResidential()

  $('#residential').click ->
    $('.active').removeClass 'active'
    $(@).parent('li').addClass 'active'
    results.find('tr').velocity 'stop'
    displayResidential()

  $('#commercial').click ->
    $('.active').removeClass 'active'
    $(@).parent('li').addClass 'active'
    results.find('tr').velocity 'stop'
    displayCommercial()
