# use lodash
_ = lodash

# app class
@Boot = class Boot

  #
  constructor: (@config = {}) ->

    {
      @collectionOptions
      @loginOptions
      @useDebugger
      @useFixtures
    } = @config

    @collections = {}

    do @setCollections

    do @setRoutes

    do @setTemplateHelpers

    do @setDebugger

    do @setDebugUser

  #
  setCollections: ->
    _.each @collectionOptions, (collection) =>
      { name, isCollection } = collection
      @collections[name] = new Mongo.Collection name if isCollection

      methods = {}

      if isCollection

        methods["#{name}/insert"] = (opt) =>
          @collections[name].insert opt

        methods["#{name}/update"] = (id, opt) =>
          @collections[name].update id, $set: opt

        methods["#{name}/remove"] = (id) =>
          @collections[name].remove id

        Meteor.methods methods

  #
  setRoutes: ->
    do @setLoginRoute
    _.each @collectionOptions, (collection) =>
      { name, path, isCollection } = collection
      routerData = {}
      routerData[name] = @collections[name].find {} if isCollection
      if Meteor.isClient
        Router.route path, ->
          @render name,
            data: -> routerData
        ,
          name: name

  #
  setLoginRoute: ->
    self = @
    if @loginOptions?.required and Meteor.isClient
      Router.route '/login', ->
        @render 'login'
      ,
        name: 'login'

      Router.onBeforeAction ->
        unless Meteor.userId()
          @layout self.loginOptions?.layoutTemplate or '__blank'
          @render self.loginOptions?.loginTemplate or '__login'
        else
          do @next

  #
  setTemplateHelpers: ->
    if Meteor.isClient
      Template.registerHelper 'routersOptions', => @collectionOptions

  #
  setDebugger: ->
    if @useDebugger and Meteor.isClient
      Meteor.startup ->
        Blaze.render Template['__nav__debugger'], document.body

  #
  setDebugUser: ->
    if Meteor.isServer and not Meteor.users.findOne { username: 'debug' }
      Accounts.createUser
        username: 'debug'
        password: 'debug'

  #
  setDummies: ->
    _.each @collectionOptions, (collection) =>
      { name, isCollection, schema, dummy } = collection
      if Meteor.isServer and isCollection and dummy
        @collections[name].remove {}
        _.times dummy, =>
          opt = {}
          _.each schema, (value, key) =>
              opt[key] = Random.id() if value.name is 'String'
          @collections[name].insert opt

#
if Meteor.isClient

  _.extend Meteor,

    _logout: (path = 'home') ->
      Meteor.logout (err) ->
        unless err
          Router.go path
