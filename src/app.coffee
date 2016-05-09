# Usually I will have this in an ENV var but have it here for simplicity
token = 'UyyfCjtntdUtqh7ZoDkd0H1KM'
baseUrl = 'https://data.cityofchicago.org/resource/energy-usage-2010.json'
results = $('#results')

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

# Draw a single row
drawRow = (building) ->
  html =
    "<tr>
      <td>#{building.total_kwh}</td>
      <td>#{building.total_therms}</td>
    </tr>"

  results.append html

# Create a table
successHandler = (data) ->

  # Draw the building for each row
  for building in data
    drawRow building

  results.find('tr').velocity 'transition.flipYIn', stagger: 100

# Create an empty table with an error message
errorHandler = (err) ->
  html =
    '<tr>
      <td>Error communicating with server. Please try again later</td>
    </tr>'

  results.append html
  results.find('tr').velocity 'transition.flipYIn', stagger: 100

# Called on document ready
init = ->
  residential = api.getResidential "#{baseUrl}"
  residential.success (data) -> successHandler data
  residential.error (err) -> errorHandler err

$(document).ready -> init()
