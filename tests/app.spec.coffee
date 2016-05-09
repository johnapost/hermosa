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

  it 'drawRow should append total_kwh and total_therms', ->
    spyOn $.fn, 'append'
    kwh = faker.random.number min: 1, max: 10
    therms = faker.random.number min: 1, max: 10
    building = total_kwh: kwh, total_therms: therms

    drawRow building

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
        .toHaveBeenCalledWith 'transition.flipYIn', stagger: 100

  describe 'errorHandler', ->
    it 'should append the error message', ->
      spyOn $.fn, 'append'

      errorHandler()

      expect $.fn.append.calls.mostRecent().args[0].indexOf('Error') > -1
        .toEqual true

  describe 'init', ->
    it 'should call getResidential', ->
      success = jasmine.createSpy()
      spyOn(api, 'getResidential').and.callFake ->
        success: success
        error: -> return

      init()

      expect api.getResidential.calls.count()
        .toEqual 1
      expect success.calls.count()
        .toEqual 1

    it 'should pass data to successHandler', ->
      spyOn window, 'successHandler'
      spyOn(api, 'getResidential').and.callFake ->
        success: (func) -> func data
        error: -> return

      init()

      expect window.successHandler
        .toHaveBeenCalledWith data

    it 'should pass errors to errorHandler', ->
      spyOn window, 'errorHandler'
      spyOn(api, 'getResidential').and.callFake ->
        success: -> return
        error: (func) -> func data

      init()

      expect window.errorHandler
        .toHaveBeenCalledWith data
