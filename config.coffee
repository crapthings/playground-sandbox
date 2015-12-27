# app config
@config =

  defaultLayout: 'layout_default'

  useDebugger: yes
  useFixtures: yes

  loginOptions:
    required: yes

  collectionOptions: [

    {
      name: 'home'
      label: '主页'
      path: '/'
      isCollection: no
    }

    {
      name: 'outdoor'
      label: '户外资源'
      path: '/outdoor'
      isCollection: no
    }

    {
      name: 'projects'
      label: '项目'
      path: '/projects'
      hide: yes
      isCollection: yes
      schema:
        title:
          type: String
          label: '名称'
        type:
          type: String
          label: '类型'
          allowedValues: ['户外', '视讯']
    }

  ]
