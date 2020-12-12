FROM node:15.2.1

SHELL ["/bin/bash", "-c"]

# Install Ruby 2.5:
RUN wget https://cache.ruby-lang.org/pub/ruby/snapshot/snapshot-ruby_2_5.tar.gz \
 && tar xzf snapshot-ruby_2_5.tar.gz \
 && ( \
        cd snapshot-ruby_2_5 && \
        ./configure && \
        time make && \
        make install \
    ) \
 && rm -fr snapshot-ruby_2_5* \
 && true

# WORKDIR for dependencies:
WORKDIR /deps

# Copy over the npm and gem manifests:
COPY package.json Gemfile* ./

# Install all NodeJS npm dependencies:
RUN npm install --verbose . \
 && npm audit fix \
 && mv ./node_modules / \
 && true

# Install all Ruby gem dependencies:
RUN gem install bundler -v 2.1.4 \
 && bundle install \
 && true

# Development setup stuff:
RUN apt-get update \
 && apt-get install -y \
        cpio \
        jq \
 && true

# Install node packages needed to build:
RUN npm install --verbose -g \
        coffeescript \
 && npm install --verbose --prefix=/usr/local \
        ingy-prelude \
        ini \
        liquid \
        merge-anything \
        yaml \
 && true

RUN git clone https://github.com/swinton/liquidize /liquidize \
 && mv /liquidize/bin/liquidize /bin/ \
 && rm -fr /liquidize \
 && true

# XXX Uncomment when stable
# # Copy builder scripts:
# COPY ps-* /bin/

# /builder will be our main workdir:
WORKDIR /builder

# /output will be our build area
RUN mkdir /output \
 && chown node.node /output \
 && true

#------------------------------------------------------------------------------
# Steps above should never change.
#------------------------------------------------------------------------------

RUN apt-get install -y \
        less \
        locales \
        silversearcher-ag \
        tig \
        tmux \
        vim \
        w3m \
 && true

# Set locale for tmux:
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
 && locale-gen en_US.UTF-8 \
 && true

# Add some Bash aliases:
COPY bashrc /home/node/.bashrc

# Copy builder scripts:
COPY ps-* /bin/
