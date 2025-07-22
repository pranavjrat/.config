#!/bin/bash
# Wrapper script for jdtls to use Java 24 with memory optimizations
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Set JVM memory limits and performance options
exec /home/heisenberg/.local/share/nvim/mason/bin/jdtls \
  -Xms256m \
  -Xmx1g \
  -XX:+UseG1GC \
  -XX:+UseStringDeduplication \
  -XX:MaxGCPauseMillis=200 \
  -Djava.awt.headless=true \
  "$@"
