

- 方法1：
  这两天在构建一个应用的使用用到了maven，由于project很大，足足有700多个 pom.xml文件，更郁闷的是在很多 pom.xml 文件里都
  单独指定了资源库的url，我需要把这些资源库的url统一指定到nexus本地中央库。
  手工一个个改文件配置有点不太实际，所以google了一下，找到批量替换文件内容的好方法，命令结构如下:

  ```sh
  find -name '要查找的文件名' | xargs perl -pi -e 's|被替换的字符串|替换后的字符串|g' 。
  ```

  下面这个例子就是将当前目录及所有子目录下的所有 pom.xml 文件中的&#8221;http://repo1.maven.org/maven2&#8220;
  替换为&#8221;http://localhost:8081/nexus/content/groups/public&#8220;。

  ```sh
  find -name 'pom.xml' | xargs perl -pi -e 's|http://repo1.maven.org/maven2|http://localhost:8081/nexus/content /groups/public|g'
  ```

  这里用到了Perl语言，`perl -pi -e` -e 选项后跟一行代码，在命令行中会像运行一个普通的Perl 脚本那样运行该代码。
  从命令行中使用Perl 能够帮助实现一些强大的、实时的转换。认真研究正则表达式，并正确地使用，将会为您省去大量的手工编辑工作。

- Linux下批量替换多个文件中的字符串的简单方法。用sed命令可以批量替换多个文件中的字符串。
  ```sh
  sed -i "s/原字符串/新字符串/g" `grep 原字符串 -rl 所在目录`
  例如：我要把mahuinan替换 为huinanma，执行命令：
  sed -i "s/mahuinan/huinanma/g" 'grep mahuinan -rl /www'
  ```

  这是目前linux最简单的批量替换字符串命令了！
  具体格式如下：
  ```sh
  sed -i "s/oldString/newString/g"  `grep oldString -rl /path`

  sed -i "s/大小多少/日月水火/g" `grep 大小多少 -rl ./`
  ```

- 方法3：
  在日程的开发过程中，可能大家会遇到将某个变量名修改 为另一个变量名的情况，如果这个变量是一个局部变量的话，vi足以胜任，但是如果是某个全局变量的话，并且在很多文件中进行了使用，这个时候使用vi就是 一个不明智的选择。这里给出一个简单的shell命令，可以一次性将所有文件中的指定字符串进行修改：

  grep "abc" * -R | awk -F: '{print $1}' | sort | uniq | xargs sed -i 's/abc/abcde/g'


- 批量替换 配置文件中的IP：

  ```sh
  grep "[0-9]\{1，3\}\.[0-9]\{1，3\}\.[0-9]\{1，3\}\.[0-9]\{1，3\}" * -R | awk -F: '{print $1}' |  sort | uniq | xargs sed -i 's/[0-9]\{1，3\}\.[0-9]\{1，3\}\.[0-9]\{1，3\}\.[0-9]\{1，3\}/172\.0\.0\.1/g'
  ```


