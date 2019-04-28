FROM newsdev/varnish:4.1.0
RUN apt-get install -y libmhash-dev
RUN \
  cd /usr/local/src/ && \
  curl -sfL  https://github.com/varnish/libvmod-digest/archive/libvmod-digest-1.0.1.tar.gz -o  libvmod-digest-1.0.1.tar.gz && \
  tar -xzf libvmod-digest-1.0.1.tar.gz  && \
  cd libvmod-digest-libvmod-digest-1.0.1 && \
  ./autogen.sh && \
  ./configure VARNISHSRC=/usr/local/src/varnish-4.1.0 && \
  make install 

COPY default.vcl.source /etc/varnish/default.vcl.source
COPY replacevars.sh /replacevars.sh
RUN chmod +x /replacevars.sh 
COPY start.sh /start.sh
RUN chmod +x start.sh
CMD ["/start.sh"]
