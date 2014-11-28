FROM ubuntu

MAINTAINER Beemo Lin dteout@gmail.com

# make sure the package repository is up to date

RUN mkdir ~/sites
RUN apt-get update -y

# install vim
RUN apt-get install -y vim git wget curl tidy php5-cli php-pear

RUN pear install PHP_CodeSniffer

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN ["/bin/bash", "-l", "-c", "rvm requirements; echo 'source /usr/local/rvm/scripts/rvm' >> ~/.bashrc;"]

RUN ["/bin/bash", "-l", "-c", "rvm install 2.1.5; rvm use 2.1.5 --default;"]

RUN ["/bin/bash", "-l", "-c", "gem install bundler --no-ri --no-rdoc; gem install ruby-lint;"]

RUN git clone https://github.com/BeemoLin/vim.git ~/vim

RUN cp ~/vim/.vimrc ~/.vimrc

RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
