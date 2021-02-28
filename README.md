# flutter_wechat
flutter开发框架入门学习

## 开发目标
### 1.用户注册和登录界面
### 2.用户好友列表
### 3.用户聊天界面
### 4.待扩展

## 项目架构设计
#### 1.框架：MVVM。基于MVVM设计模式实现UI和业务解耦，规范项目开发流程，提高项目开发效率，降低项目维护成本
#### 2.组织结构
	1. 状态管理 Provider + bloc（后期扩展）
	2. 路由管理 Fluro
	3. 本地数据缓存 ShareReference
	4. 网络服务 Dio+Mqtt
	5. 主题样式 Theme
	6. 国际化   Localization
	7. Json自动序列化
	7. 静态配置 Config
	8. 数据 data
	9. 工具包 Toolkit
		1. 屏幕适配
		2. 侧滑删除
		3. Toast
	10. 资源管理 ResourceManager
	11. 业务 Business Logic
#### 3.业务内容
	1. 登录
	2. 聊天列表（商品列表)
	3. 聊天室(商品详情)
	4. 好友列表（购物车）
	5. 我的（个人信息、退出、其他功能链接等)
#### 4. 拓展
	1. 将目前主流的架构，应用到当前项目中
	2. 扩展新功能
