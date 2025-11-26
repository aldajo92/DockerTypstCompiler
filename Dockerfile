FROM pandoc/typst:latest
LABEL maintainer="Alejandro Gomez (aldajo92)" \
      description="A Docker image for compiling Typst documents using pandoc/typst" \
      repo="https://github.com/aldajo92/DockerTypstCompiler"

# Switch to root to install additional packages and setup
USER root

# Install bash and other useful tools
RUN apk add --no-cache \
    bash \
    python3 \
    py3-pip

# TODO: Install additional tools or Typst packages if needed
# RUN apk add --no-cache \
#     <packages>

# Copy the compile script
COPY compile_typst.py /usr/local/bin/compile_typst.py
RUN chmod +x /usr/local/bin/compile_typst.py

# Create a non-root user for better security
RUN addgroup -g 1000 dockeruser 2>/dev/null || true && \
    adduser -u 1000 -G dockeruser -s /bin/bash -D dockeruser 2>/dev/null || true

# Switch to the created user
USER dockeruser
WORKDIR /home/dockeruser/ws_typst

# Create a wrapper script for Typst compilation
USER root
RUN echo '#!/bin/bash' > /usr/local/bin/compile_article.sh && \
    echo 'if [ $# -eq 0 ]; then' >> /usr/local/bin/compile_article.sh && \
    echo '    echo "Usage: compile_article.sh <article_directory>"' >> /usr/local/bin/compile_article.sh && \
    echo '    exit 1' >> /usr/local/bin/compile_article.sh && \
    echo 'fi' >> /usr/local/bin/compile_article.sh && \
    echo 'cd /home/dockeruser/ws_typst' >> /usr/local/bin/compile_article.sh && \
    echo 'python3 /usr/local/bin/compile_typst.py "$1" --all' >> /usr/local/bin/compile_article.sh && \
    chmod +x /usr/local/bin/compile_article.sh

USER dockeruser
WORKDIR /home/dockeruser/ws_typst

# Default command
ENTRYPOINT ["/usr/local/bin/compile_article.sh"]
