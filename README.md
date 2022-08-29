# 腾讯云 SCF + Ruby 容器镜像

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

## 部署到腾讯云的方法
1. 先推送到腾讯云 TCR 
2. 在[腾讯云 SCF](https://console.cloud.tencent.com/scf/list) 新建函数.
   1. "使用容器镜像"
   2. 填入镜像地址为 TCR 地址，如 `ccr.ccs.tencentyun.com/zhengcheng/zhengcheng-docker-repo:latest`
   3. 触发器为 "API 网关触发"
   4. 点击"完成"