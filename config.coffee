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
        title: String
        content: String
      dummy: 10
    }

    {
      name: 'authors'
      path: '/authors'
      isCollection: yes
      schema:
        username: String
      dummy: 3
    }

    {
      name: 'books'
      path: '/books'
      isCollection: yes
      schema:
        author: String
      dummy: 5
    }

  ]
