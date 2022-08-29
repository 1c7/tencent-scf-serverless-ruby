# 腾讯云 SCF + Ruby 容器镜像
(问题已解决，请直接翻到文章末尾看结论)

## 介绍
我们希望用 Docker Image 方式跑 Ruby 代码。  
部署到腾讯云云函数上。
但是使用过程中遇到问题。   
**本代码仓库用于给腾讯云工单工程师复现问题。**     

## 本地运行方法（不用 Docker)

先安装依赖
```
bundle install
```

运行服务器
```
ruby ./app.rb
```

访问 http://localhost:9000/

## 本地运行方法 (使用 Docker)
构建镜像
```
docker build --tag tencent-scf .
```

运行镜像
```
docker run -p 9000:9000 tencent-scf
```

访问 http://localhost:9000/

## 最核心的代码只有4个文件
* Gemfile, Gemfile.lock (依赖)
* Dockefile
* app.rb

## 部署到腾讯云的方法
1. 先推送到腾讯云 TCR 
2. 在[腾讯云 SCF](https://console.cloud.tencent.com/scf/list) 新建函数.
   1. "使用容器镜像"
   2. 填入镜像地址为 TCR 地址，如 `ccr.ccs.tencentyun.com/zhengcheng/zhengcheng-docker-repo:latest`
   3. 触发器为 "API 网关触发"
   4. 点击"完成"

# 解决方法（详细版）

## 一些背景信息：
* 我的电脑是 MacBook Pro（14英寸，2021年）芯片是 Apple M1 Pro。
* 我看到文档里有一句

> 云函数当前是基于 X86 架构运行的，所以暂不支持运行在 ARM 平台上构建的镜像。ARM 的平台典型如 Apple Mac 搭载 M1 芯片的 PC 端。

![](./img/x86.jpg)

所以我用了 AWS Codebuild 来负责 `docker build` Docker Image

![](img/codebuild.jpg)

用的容器镜像是 `aws/codebuild/amazonlinux2-x86_64-standard:4.0`

## 关于架构
1. 腾讯云 TCR 里显示架构 arm64 并不碍事。这个并不影响。可以正确运行。

![](img/tcr.jpg)

# 解决方法（简略版）
1. 新建函数的时候除了选择你自己的镜像，其他保留默认即可。  

![](img/create-scf-function.jpg)

2. 这个默认触发器是正确的
![](img/trigger-correct.jpg)

3. 不要改成 API 网关触发
![](img/trigger-wrong.jpg)

