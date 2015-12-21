# rebug route
Router.route '/debugger', ->
  @render '__debugger'
,
  name: '__debugger'

Template.registerHelper 'test', (a) ->
	console.log a
