_ = lodash

Template.breadcrumb.helpers

	paths: ->
		if Router.current()

			routes = []

			_.each Router.current().route.path().split('/'), (path) ->
				if path and not _.includes ['new', 'update'], path
					routes.push _.find app.collectionOptions, (a) ->
						a.routeName = Router.current().route.getName()
						return a.name is path and a.path isnt '/'

			return routes
