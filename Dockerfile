FROM debian:13-slim
 
ENV HOME=/home/claude
ENV PATH="${HOME}/.local/bin:$PATH"

RUN mkdir -p ${HOME}/.local/bin && \
    mkdir -p ${HOME}/.local/share && \
    chmod -R 777 ${HOME}
 
# Install Claude Code
RUN apt-get update && \
    apt-get install -y curl
 
RUN curl -fsSL https://claude.ai/install.sh | bash
 
# Install core dependencies
RUN apt-get install -y \
    bash \
    git \
    jq \
    ripgrep
 
RUN apt-get clean
 
WORKDIR /workspace
 
CMD ["claude"]
