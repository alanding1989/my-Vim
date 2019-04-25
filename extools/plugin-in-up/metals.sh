# ================================================================================
#  File Name    : extools/plugin-in-up/metals.sh
#  Author       : AlanDing
#  mail         :
#  Created Time : Thu 25 Apr 2019 09:57:36 PM CST
# ================================================================================
#!/usr/bin/env bash

# Make sure to use coursier v1.1.0-M9 or newer.
cd /opt/lang-tools/scala && rm -rf coursier
curl -L -o coursier https://git.io/coursier
chmod +x coursier
./coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=coc.nvim \
  --java-opt -Dmetals.client=coc.nvim \
  --java-opt -Dmetals.java-home=/opt/lang-tools/java/jdk \
  --java-opt -Dmetals.sbt-script=/opt/lang-tools/scala/sbt/bin/sbt \
  --java-opt -Dmetals.extensions=true \
  --java-opt -Dmetals.status-bar=on \
  --java-opt -Dmetals.slow-task=on \
  --java-opt -Dmetals.input-box=on \
  --java-opt -Dmetals.icons=unicode \
  --java-opt -Dmetals.http=true \
  org.scalameta:metals_2.12:0.5.0 \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /opt/lang-tools/scala/metals-vim -f
