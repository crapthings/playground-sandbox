# app config
@config =

  useDebugger: yes
  useFixtures: yes

  loginOptions:
    required: yes

  collectionOptions: [

    {
      name: 'home'
      path: '/'
      isCollection: no
    }

    {
      name: 'posts'
      path: '/posts'
      isCollection: yes
      schema:
        title:
          type: String
        content:
          type: String
    }

  ]
