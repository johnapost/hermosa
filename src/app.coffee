# Usually I will have this in an ENV var but have it here for simplicity
token = 'UyyfCjtntdUtqh7ZoDkd0H1KM'
baseUrl = 'https://data.cityofchicago.org/resource/energy-usage-2010.json'

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

# create the table structure
drawDom = (data) ->
  console.log data

# Called on document ready
init = ->
  residential = api.getResidential "#{baseUrl}"
  residential.success (data) -> drawDom data

$(document).ready -> init()
