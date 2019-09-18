# k8s实践(八)：ConfigMap and Secret

<br>

**环境说明：**

 
| 主机名 | 操作系统版本 | ip | docker version | kubelet version | 配置 | 备注 |
| :------: | :------:  | :------: | :------: | :------: | :------: |:------: |
| master | Centos 7.6.1810 | 172.27.9.131 |Docker 18.09.6 | V1.14.2 | 2C2G | master主机 |
| node01 | Centos 7.6.1810 | 172.27.9.135 |Docker 18.09.6 | V1.14.2 | 2C2G | node节点 |
| node02 | Centos 7.6.1810 | 172.27.9.136 |Docker 18.09.6 | V1.14.2 | 2C2G | node节点 |



<br>

## 1. ConfigMap
在实际的应用部署中， 经常需要为各种应用／中间件配置各种参数， 如数据库地址、 用户名、 密码等， 而且大多数生产环境中的应用程序配置较为复杂， 可能是多个 Config 文件、 命令行参数和环境变量的组合。 要完成这样的任务有很多种方案， 比如：

> * 1.可以直接在打包镜像的时候写在应用配置文件里面，但这种方式的坏处显而易见，因为在应用部署中往往需要修改这些配置参数，或者说制作镜像时并不知道具体的参数配置，一旦打包到镜像中将无法更改配置。另外，部分配置信息涉及安全信息（如用户名、 密码等），打包人镜像容易导致安全隐患;
> * 2.可以在配置文件里面通过ENV环境变量传入，但是如若修改ENV就意味着要修改yaml文件，而且需要重启所有的容器才行;
> * 3.可以在应用启动时在数据库或者某个特定的地方取配置文件。

<br>
显然，前两种方案不是最佳方案，而第三种方案实现起来又比较麻烦。为了解决这个难题,kubernetes引入ConfigMap这个API资源来满足这一需求。
<br>


## 2. 为什么需要ConfigMap和Secret
&emsp;&emsp;ConfigMap和Secret是Kubernetes系统上两种特殊类型的存储卷，ConfigMap象用于为容器中的应用提供配置数据以定制程序的行为，不过敏感的配置信息，例如密钥、证书等通常由Secret对象来进行配置。它们将相应的配置信息保存于对象中，而后在Pod资源上以存储卷的形式将其挂载并获取相关的配置，以实现配置与镜像文件的解耦。

<br>

## 3. ConfigMap作用

- 向容器传递命令行参数
- 为每个容器设置自定义环境变量
- 通过特殊类型的卷将配置文件挂载到容器中

<br>
<br>

**文章目录：**
# 一、概述
## 1. ConfigMap
## 2. 为什么需要ConfigMap和Secret
## 3. ConfigMap作用
# 二、准备工作
## 1. 制作镜像
## 2. 上传dockerhub
## 3. 验证镜像
# 三、容器中的配置数据传递
## 1. 容器的ENTRYPOINT和CMD
## 2. 向容器传递命令行参数
### 2.1 循环间隔参数化
### 2.2 Docker运行带参数镜像
### 2.3 Docker直接指定参数运行镜像
### 2.4 pod中定义传递的参数值
## 3. 为容器设置环境变量
### 3.1 生成镜像loong576/date-random:env
### 3.2 pod中指定环境变量
# 四、ConfigMap
## 1. 创建configmap
### 1.1 --from-file指定文件方式
### 1.2 --from-file指定目录方式
### 1.3 --from-literal字面量方式
### 1.4 --from-env-file键值对方式
### 1.5 yaml文件方式
## 2. 使用configmap
### 2.1 新建pod date-random-configmap-volume
### 2.2 访问测试
## 3. 更新应用配置
### 3.1 更新ConfigMap
### 3.2 nginx加载配置
### 3.3 再次访问nginx
# 五、Secret
## 1. 创建Secret
## 2. 查看Secret
## 3. 使用Secret
### 3.1 创建docker-registry secret
### 3.2 创建私有镜像loong576/test
### 3.3 创建pod private-pod-secret
### 3.4 pod中查看secret
## 4. 更新Secret


<br>
<br>

**详细搭建过程及测试：**

https://blog.51cto.com/3241766/2438955
