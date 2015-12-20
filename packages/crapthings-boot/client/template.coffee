# login event
Template.__login.events
  'submit form': (e, t) ->
    e.preventDefault()
    opt =
      username: t.find('input[name="username"]').value
      password: t.find('input[name="password"]').value
    Meteor.loginWithPassword opt.username, opt.password, (err) ->
      unless err
        Router.go '/'
