FROM google/dart

COPY app/ /app/

RUN cd /app \
    && pub get \
    && dart2aot /app/bin/main.dart /main.dart.aot

# Install Flutter
RUN apt-get update \
    && apt-get -y install unzip \
    && git clone -b stable --depth 1 https://github.com/flutter/flutter.git /flutter \
    && /flutter/bin/flutter --version \
    && /flutter/bin/flutter config --no-analytics

COPY LICENSE README.md /

ENTRYPOINT ["dartaotruntime", "/main.dart.aot", "-f", "/flutter", "-p", "/github/workspace"]
