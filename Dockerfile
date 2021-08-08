FROM ubuntu
COPY    install_1.sh /tmp/
RUN     bash /tmp/install_1.sh
COPY    main.cpp /root/main.cpp

EXPOSE 45654
ENTRYPOINT ["/etc/code-server-hub/.cshub/bin/code-server", "--host", "0.0.0.0", "--port", "45654", "--auth", "none","--log", "debug"]