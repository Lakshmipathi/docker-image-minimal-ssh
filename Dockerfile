FROM busybox

COPY sshd /sbin/sshd
COPY ssh-keygen /bin/ssh-keygen
COPY lib64 /lib64

RUN install -d -o root -g root -m 700 /var/empty/sshd

COPY etc/ssh /etc/ssh
COPY start.sh /start.sh
RUN chmod 755 /start.sh

RUN (echo clouds; echo clouds ) | passwd root

CMD /start.sh

