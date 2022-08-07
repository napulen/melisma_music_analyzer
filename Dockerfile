FROM ubuntu:20.04

ENV ROOT=/code
ENV MELISMA=/code/melisma2003
ENV HUMEXTRA=/code/humextra
ENV HUMDRUM=/code/humdrum

RUN apt update
RUN apt install -y build-essential autoconf automake libtool git python3 unzip wget

# Get melisma codebase
WORKDIR $ROOT
RUN wget https://www.link.cs.cmu.edu/music-analysis/melisma2003.tar.gz
RUN tar -xvf melisma2003.tar.gz
RUN mkdir melisma2003/bin
WORKDIR $MELISMA/harmony
RUN make
RUN cp harmony ../bin/
WORKDIR $MELISMA/key
RUN make
RUN cp key ../bin/
WORKDIR $MELISMA/meter
RUN make
RUN cp meter ../bin/
WORKDIR $ROOT

# Get supporting scripts by Craig Sapp
RUN wget http://extras.humdrum.org/man/tsroot/harmony2humdrum
RUN wget http://extras.humdrum.org/man/tsroot/key2humdrum
RUN chmod +x harmony2humdrum
RUN mv harmony2humdrum melisma2003/bin/
RUN chmod +x key2humdrum
RUN mv key2humdrum melisma2003/bin/

# Get humextra codebase
RUN git clone https://github.com/humdrum-tools/humextra.git
WORKDIR $HUMEXTRA
RUN make library
RUN make programs

# Get humdrum codebase
WORKDIR $ROOT
RUN git clone https://github.com/humdrum-tools/humdrum.git
WORKDIR $HUMDRUM
RUN make bin

WORKDIR $HUMEXTRA
COPY phd_testset_krn ./phd_testset_krn/
COPY run.sh .
RUN chmod +x run.sh

ENTRYPOINT ["./run.sh"]
