- Model 

  数据实体，分两部分（手动实现+自动生成)manual、auto

- View

  UI视图，基于StatefulWidget、StateLessWidget进行封装，对应Page和Widget（或者叫做Component）

  - BaseView，组织结构如下
    - model 对应ViewModel
    - onModelReady vm初始化完成的回调

- ViewModel

  UI视图和数据模型控制器，负责处理M和V之间的业务

  - BaseViewModel，组织结构如下
    - state 保存当前vm的状态（idle，loading(busy), success, empty, error)
    - repo repository 数据仓库，提供数据处理的API
    - stateError 保存错误状态，处理业务中遇到的异常信息
    - loadData （扩展）加载数据，一般用于数据初始化
    - loadMore（扩展）加载更多，一般用户下拉刷新数据或者加载新数据
    - onData （扩展）数据加载完成的回调方法

- Repository

  数据仓库，vm通过repository提供的api与服务器进行通信

  思考：是否考虑web服务器和socket服务器业务独立开，即WebDataProcess和SocketDataProcess

- Service（DataChannel）

  数据服务，提供对通信数据的序列化和反序列化，按模块拆分，独立处理关联的业务数据





