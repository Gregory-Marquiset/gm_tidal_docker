FROM debian:trixie

RUN useradd -m -G audio TidalProducer

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git jackd2 qjackctl zlib1g-dev gcc g++ ghc cabal-install

RUN apt-get install -y --no-install-recommends \
    supercollider sc3-plugins sc3-plugins-language sc3-plugins-server
    
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean

USER TidalProducer

CMD ["sleep", "5000"]
