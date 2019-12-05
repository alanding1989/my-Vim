

## JVM 常用参数：  

|                     |                                         |
| ------------------- | -------------------------------------   |
| -XX:+PrintGCDetails | 输出详细的 GC 处理日志                  |
| -Xms1024m           | 设置堆初始分配大小，默认为物理内存 1/64 |
| -Xmx1024m           | 堆最大分配内存，默认为物理内存 1/4      |
| -xss                | 初始栈内存大小                          |


-Xss512K
-Xms1024m
-Xmx1024m
-Xmn256M 
-XX:MaxDirectMemorySize=128M
-XX:MaxPermSize=128M

-XX:+UseParNewGC
-XX:+UseConcMarkSweepGC
-XX:+UseCompressedOops
-XX:+PrintReferenceGC
-XX:CMSInitiatingOccupancyFraction=70

- 注意：
- 生产中实际初始堆内存必须与最大内存相同，避免GC与应用程序争抢内存，
  使得峰值和峰谷忽高乎低。
  这跟传统行业传感器灵敏度调节设定一个道理，比如空调温度设定，设定的不好会
  导致压缩机频繁启动，反而更耗电。

1. kafka 启动默认参数
    -server -XX:+UseG1GC 
    -XX:MaxGCPauseMillis=20
    -XX:InitiatingHeapOccupancyPercent=35
    -XX:+ExplicitGCInvokesConcurrent
    -Djava.awt.headless=true




## Jvm 诊断

- 程序启动时设置打印一些GC日志
  ``` sh
  # 判断Java版本，开启GC日志
  JAVA_MAJOR_VERSION=$($JAVA -version 2>&1 | sed -E -n 's/.* version "([0-9]*).*$/\1/p')
  if [[ "$JAVA_MAJOR_VERSION" -ge "9" ]] ; then
    GC_LOG_OPTS="-Xlog:gc*:file=$LOG_DIR/$GC_LOG_FILE_NAME:time,tags:filecount=10,filesize=102400"
  else
    GC_LOG_OPTS="-Xloggc:$LOG_DIR/$GC_LOG_FILE_NAME -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M"
  fi
  ```

  -XX:+HeapDumpOnOutOfMemoryError
  -XX:HeapDumpPath=/home/work/log/dump
  -verbose:gc
  -Xloggc:gc.log
  -XX:+PrintGCDetails
  -XX:+PrintGCTimeStamps
  -XX:+PrintGCApplicationStoppedTime
  -XX:+PrintReferenceGC
  -Dcom.sun.management.jmxremote.authenticate=false
  -Dcom.sun.management.jmxremote.ssl=false

- Java 管理扩展 jmx

- 堆转储快照，手工直接导，PID为进程号
  jmap -dump:live,format=b,file=m.hprof PID
