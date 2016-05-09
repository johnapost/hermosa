url = undefined
data = undefined

describe 'app', ->
  describe 'getResidential', ->
    beforeEach ->
      url = faker.internet.url()
      data = {etc: faker.hacker.noun()}
      spyOn($, 'ajax').and.callThrough()

    it 'should pass url and data to ajax', ->
      api.getResidential url, data

      expect $.ajax
        .toHaveBeenCalledWith url: url, data: data

    it 'should pass specify the community_area_name as Hermosa', ->
      api.getResidential url, data

      expect $.ajax.calls.mostRecent().args[0].data.community_area_name
        .toEqual 'Hermosa'

    it 'should pass specify the building_type as Residential', ->
      api.getResidential url, data

      expect $.ajax.calls.mostRecent().args[0].data.building_type
        .toEqual 'Residential'

  describe 'getCommercial', ->
    beforeEach ->
      url = faker.internet.url()
      data = {etc: faker.hacker.noun()}
      spyOn($, 'ajax').and.callThrough()

    it 'should pass url and data to ajax', ->
      api.getCommercial url, data

      expect $.ajax
        .toHaveBeenCalledWith url: url, data: data

    it 'should pass specify the community_area_name as Hermosa', ->
      api.getCommercial url, data

      expect $.ajax.calls.mostRecent().args[0].data.community_area_name
        .toEqual 'Hermosa'

    it 'should pass specify the building_type as Commercial', ->
      api.getCommercial url, data

      expect $.ajax.calls.mostRecent().args[0].data.building_type
        .toEqual 'Commercial'

  it 'clearRows should clear the rows of data', ->
    spyOn $.fn, 'html'

    clearRows()

    expect $.fn.html
      .toHaveBeenCalledWith ''

  it 'drawRow should append data', ->
    spyOn $.fn, 'append'
    subtype = faker.hacker.noun()
    kwh = faker.random.number min: 1, max: 10
    therms = faker.random.number min: 1, max: 10
    building =
      building_subtype: subtype
      total_kwh: kwh
      total_therms: therms

    drawRow building

    expect $.fn.append.calls.mostRecent().args[0].indexOf(subtype) > -1
      .toEqual true
    expect $.fn.append.calls.mostRecent().args[0].indexOf(kwh) > -1
      .toEqual true
    expect $.fn.append.calls.mostRecent().args[0].indexOf(therms) > -1
      .toEqual true

  describe 'successHandler', ->
    it 'should call drawRow for each item in data', ->
      arr = []
      for i in [0..4]
        arr.push faker.hacker.noun()
      spyOn window, 'drawRow'

      successHandler arr

      expect window.drawRow.calls.count()
        .toEqual 5

    it 'should animate in rows', ->
      spyOn($.fn, 'find').and.callThrough()
      spyOn $.fn, 'velocity'

      successHandler []

      expect $.fn.find
        .toHaveBeenCalledWith 'tr'
      expect $.fn.velocity
        .toHaveBeenCalledWith 'transition.flipYIn', stagger: 75

  it 'errorHandler should append the error message', ->
    spyOn $.fn, 'append'

    errorHandler()

    expect $.fn.append.calls.mostRecent().args[0].indexOf('Error') > -1
      .toEqual true

  describe 'displayResidential', ->
    beforeEach ->
      spyOn(api, 'getResidential').and.callFake ->
        success: (func) -> func data
        error: (func) -> func data

    it 'should call getResidential', ->
      displayResidential()

      expect api.getResidential.calls.count()
        .toEqual 1

    it 'should pass data to successHandler', ->
      spyOn window, 'clearRows'
      spyOn window, 'successHandler'

      displayResidential()

      expect window.clearRows.calls.count()
        .toEqual 2
      expect window.successHandler
        .toHaveBeenCalledWith data

    it 'should pass errors to errorHandler', ->
      spyOn window, 'clearRows'
      spyOn window, 'errorHandler'

      displayResidential()

      expect window.clearRows.calls.count()
        .toEqual 2
      expect window.errorHandler
        .toHaveBeenCalledWith data

  describe 'displayCommercial', ->
    beforeEach ->
      spyOn(api, 'getCommercial').and.callFake ->
        success: (func) -> func data
        error: (func) -> func data

    it 'should call getCommercial', ->
      displayCommercial()

      expect api.getCommercial.calls.count()
        .toEqual 1

    it 'should pass data to successHandler', ->
      spyOn window, 'clearRows'
      spyOn window, 'successHandler'

      displayCommercial()

      expect window.clearRows.calls.count()
        .toEqual 2
      expect window.successHandler
        .toHaveBeenCalledWith data

    it 'should pass errors to errorHandler', ->
      spyOn window, 'clearRows'
      spyOn window, 'errorHandler'

      displayCommercial()

      expect window.clearRows.calls.count()
        .toEqual 2
      expect window.errorHandler
        .toHaveBeenCalledWith data
