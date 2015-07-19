## Lls

### Overview

已实现功能：

* 用户注册及登录
* 同时在线用户/游客数
* 用户/游客在线时间
* 已注册用户资料持久化（mysql）

时间关系，以下方面未能完善。

* Session的清除策略
* 模块组织混乱及粒度过大
* 单元测试
* 更正式的生产环境自动化部署
* 更完善的运行日志

### Up and Running

本地运行需先安装

* Ruby 2.2.2
* Ansible 1.9.1
* Vagrant 1.7.1

Clone项目到本地后，执行

```bash
$ bundle install
```

启动 vagrant 虚拟机，将会在其中自动安装 mysql

```bash
$ vagrant up
```

设置虚拟机中的 mysql

```bash
$ rake setup
```

启动服务器程序

```bash
$ puma
```

在浏览器打开页面`http://localhost:9292`即可使用。