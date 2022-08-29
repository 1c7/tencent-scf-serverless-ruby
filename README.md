# 腾讯云 SCF + Ruby 容器镜像

## 介绍
我们希望用 Docker Image 方式跑 Ruby 代码。  
部署到腾讯云云函数上。
**但是使用过程中遇到问题** 
本代码仓库用于给腾讯云工单工程师复现问题。   

## 运行方法（不用 Docker)

先安装依赖
```
bundle install
```

运行服务器
```
ruby ./app.rb
```

访问 http://localhost:9000/

## 运行方法 (使用 Docker)
构建镜像
```
docker build --tag tencent-scf .
```

运行镜像
```
docker run -p 9000:9000 tencent-scf
```

访问 http://localhost:9000/