
<!-- vim-markdown-toc GFM -->

- [demo](#demo)
- [容器管理](#容器管理)
- [镜像管理：](#镜像管理)

<!-- vim-markdown-toc -->



### demo  
1. 运行一个容器

  ``` sh
  docker run -dit -rm --privileged -p21:21 -p80:80 -p8080:8080 -p30000-30010:30000-30010 \
    --restart=always \ 
    -v /opt/snnu_docker_ui/dist/:/usr/share/nginx/snnu_ui/ \
    --name how2jtmall how2jtmall/hello:latest /usr/sbin/init
  ```
    
  - docker run 表示运行一个镜像

  - -dit 是 -d -i -t 的缩写。 
      -d 表示 detach，在后台运行。 
      -i 表示提供交互接口，可以通过 docker 和 操作系统交互。 
      -t 表示提供 tty 伪终端，与 -i 配合就可以通过 ssh 工具连接到 这个容器里

  - rm 表示如果容器已经存在，自动删除容器

  - --privileged 启动容器的时候，把权限带进去。 这样才可以在容器里进行完整的操作

  - -p 21:21 
    - -p 表示port
    - 第一个21，表示在CentOS 上开放21端口。 
    - 第二个21 表示在容器里开放21端口。 这样当访问CentOS 的21端口的时候，就会间接地访问到容器里了

  - -p30000-30010 和21也是一个道理，这个是ftp用来传输数据的

  - --restart=always 表示当Docker 重启时，容器能够自动启动

  - -v 将Docker内部目录映射到宿主机的目录，就可以共享宿主机的文件目录，冒号左边是宿主机的目录
      这里是为了灵活配置项目部署，如果这里加了就可以不用在Dockerfile文件中COPY dist/ /usr/share/nginx/snnu_ui/，
      只需要每次将打成的包放到宿主机的对应目录下，容器会自动识别，可以不必每次更新包都需要重新生成镜像。
      如果不加的话，就需要在Dockerfile文件中COPY dist/ /usr/share/nginx/snnu_ui/，每次重新打包都需要重新生成镜像。

  - --name how2jtmall 给容器取了个名字，叫做 how2jtmall，方便后续管理

  - how2jtmall/hello:latest somebody/hello就是镜像的名称， latest是版本号，即最新版本

  - /usr/sbin/init: 容器启动后需要运行的程序，即通过这个命令做初始化


2. 更新一个容器参数
  ``` sh
  docker container update --restart=no $容器名字
  ```

3. 容器启动之后查看容器输出
  ```
  docker container logs 容器名字
  ```



### 容器管理
1. 运行 run

2. 进入 exec  
   docker exec -it how2jtmall /bin/bash

3. 生命周期管理， 暂停，恢复，停止，启动 pause, unpause, stop, start

4. ps 查看所有的容器

5. 检查某个具体的容器

6. rm 删除容器

7. 删除所有容器
   docker rm `docker ps -a -q` -f

8. commit，对容器做了修改后，把改动后的容器，再次转换为镜像


### 镜像管理：
1. search 查看仓库里有些什么镜像

2. pull 拉取镜像

3. images 查看本地有些什么镜像

4. rmi 删除本地镜像

5. tag修改本地镜像名称  
  - docker tag docker.io/tomcat:8.0 docker.io/mytomcat:8.0
  通过tag可以对镜像进行标记，把 docker.io/tomcat:8.0 标记成了docker.io/mytomcat:8.0

6. push , 把镜像提交到仓库

7. 删除所有镜像 docker rmi $(docker images -q)

