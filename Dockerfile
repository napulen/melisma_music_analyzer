FROM ubuntu:20.04

WORKDIR /melisma

RUN apt update
RUN apt install -y build-essential automake git unzip wget

# Get melisma codebase
RUN wget https://www.link.cs.cmu.edu/music-analysis/melisma2003.tar.gz
RUN tar -xvf melisma2003.tar.gz
RUN mkdir melisma2003/bin
WORKDIR /melisma/melisma2003/harmony
RUN make
RUN cp harmony ../bin/
WORKDIR /melisma/melisma2003/key
RUN make
RUN cp key ../bin/
WORKDIR /melisma/melisma2003/meter
RUN make
RUN cp meter ../bin/
WORKDIR /melisma

# Get supporting scripts by Craig Sapp
RUN wget http://extras.humdrum.org/man/tsroot/harmony2humdrum
RUN wget http://extras.humdrum.org/man/tsroot/key2humdrum
RUN chmod +x harmony2humdrum
RUN mv harmony2humdrum melisma2003/bin/
RUN chmod +x key2humdrum
RUN mv key2humdrum melisma2003/bin/

# Get humextra codebase
RUN wget https://github.com/craigsapp/humextra/archive/refs/heads/master.zip
RUN unzip master.zip
WORKDIR /melisma/humextra-master
RUN make library
RUN make programs

CMD bin/tsroot --meldir /melisma/melisma2003/bin/ --midir /melisma/humextra-master/bin/ --roman 
