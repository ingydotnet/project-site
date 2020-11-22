FROM node:15.2.1

SHELL ["/bin/bash", "-c"]

WORKDIR /work

# Get Bootstrap 4.5:
RUN git clone https://github.com/twbs/bootstrap base \
 && ( \
        cd base && \
        git checkout -b project-site v4.5.0 && \
        npm install --verbose . && \
        npm audit fix \
    )

# Install Ruby:
RUN wget https://cache.ruby-lang.org/pub/ruby/snapshot/snapshot-ruby_2_5.tar.gz \
 && tar xzf snapshot-ruby_2_5.tar.gz \
 && ( \
        cd snapshot-ruby_2_5 && \
        ./configure && \
        time make && \
        make install \
    ) \
 && rm -fr snapshot-ruby_2_5* \
 && gem install bundler -v 1.17.3 \
 && true

# Install Ruby gems:
RUN ( cd base && bundle install )

# Dev setup stuff:
RUN apt-get update
RUN apt-get install -y less
RUN apt-get install -y locales
RUN apt-get install -y silversearcher-ag
RUN apt-get install -y tig
RUN apt-get install -y tmux
RUN apt-get install -y vim
RUN apt-get install -y w3m

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
 && locale-gen en_US.UTF-8

COPY bashrc /root/.bashrc
