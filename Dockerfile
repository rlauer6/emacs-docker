FROM amazonlinux:2
ARG user
ARG group
RUN yum install -y \
    gcc make tar less which bzip2 gunzip git texinfo \
    automake autoconf epel-release gnutls gnutls-devel \
    ncurses ncurses-devel openssl 

########################################################################
RUN git clone --depth 1 git://git.sv.gnu.org/emacs.git
RUN cd emacs; \
./autogen.sh; \
./configure && make && make install
########################################################################

RUN useradd -u $group $user
USER $user
