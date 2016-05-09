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

  describe 'init', ->
    it 'should call getResidential', ->
      success = jasmine.createSpy()
      spyOn(api, 'getResidential').and.callFake -> success: success

      init()

      expect api.getResidential.calls.count()
        .toEqual 1
      expect success.calls.count()
        .toEqual 1

    it 'should pass data to drawDom', ->
      spyOn window, 'drawDom'
      spyOn(api, 'getResidential').and.callFake ->
        success: (func) -> func data

      init()

      expect window.drawDom
        .toHaveBeenCalledWith data
