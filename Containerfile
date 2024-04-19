ARG UBUNTU_TAG=""
FROM docker.io/ubuntu:${UBUNTU_TAG}

ARG TAG=""

ENV LANG="en_US.UTF-8"
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /root
RUN apt-get update --yes
RUN apt-get install --yes wget
RUN apt-get install --yes libz-dev
RUN apt-get install --yes maude
RUN apt-get install --yes haskell-stack
RUN apt-get install --yes locales
RUN apt-get install --yes netbase
RUN stack upgrade
RUN locale-gen "en_US.UTF-8"
RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user
RUN wget https://github.com/tamarin-prover/tamarin-prover/archive/refs/tags/${TAG}.tar.gz
RUN tar xzf ${TAG}.tar.gz
RUN rm ${TAG}.tar.gz
WORKDIR /home/user/tamarin-prover-${TAG}
RUN stack setup
RUN stack install
RUN bash -c 'if [[ ${TAG} == "1.6.1" || ${TAG} == "1.4.1" ]]; then make sapic; fi'
ENV PATH="/home/user/.local/bin":${PATH}
WORKDIR /home/user
RUN rm -r /home/user/tamarin-prover-${TAG}
USER root
RUN apt-get install --yes graphviz
RUN apt-get install --yes python3
RUN apt-get install --yes python3-pip
RUN pip3 install tabulate matplotlib graphviz
RUN chown -R user:user /home/user/.local/bin/
USER user
