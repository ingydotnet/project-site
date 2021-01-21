FROM node:15.2.1

SHELL ["/bin/bash", "-c"]

# Clone the bootstrap site source code:
RUN git clone \
      --branch=v4.5.3 \
      --depth=1 \
      https://github.com/twbs/bootstrap /base \
 && true

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

# WORKDIR for dependency installation:
WORKDIR /base

# Install all NodeJS npm dependencies:
RUN npm install --verbose . \
 && ( npm audit fix || true ) \
 && mv ./node_modules / \
 && git reset --hard \
 && git clean -dxf \
 && git status --ignored \
 && true

# Install all Ruby gem dependencies:
RUN gem install bundler -v 2.1.4 \
 && bundle install \
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

# Liquid CLI for rendering templates:
RUN git clone https://github.com/swinton/liquidize /liquidize \
 && mv /liquidize/bin/liquidize /bin/ \
 && rm -fr /liquidize \
 && true

# Development setup stuff:
RUN apt-get update \
 && apt-get install -y \
        cpio \
        jq \
        librsvg2-bin \
 && true

COPY Gemfile /base/Gemfile
RUN bundle install

# /ps will be our main workdir:
WORKDIR /ps

# /output will be our build area:
RUN mkdir /common /input /build /output \
 && chown -R node.node /base /ps /common /input /build /output \
 && true

ENV PATH "/ps/bin:/common/bin:$PATH"

#------------------------------------------------------------------------------
# Steps above should never change.
# Development helpers below:
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
