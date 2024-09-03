FROM rockylinux/rockylinux:9.3

RUN dnf -y update

# Install dependencies
RUN dnf -y install epel-release
RUN dnf -y install log4cplus

# Install rpm repository.
# See https://kea.readthedocs.io/en/kea-2.7.0/arm/quickstart.html
RUN curl -1sLfO  'https://dl.cloudsmith.io/public/isc/kea-2-6/setup.rpm.sh'
RUN bash setup.rpm.sh

# Install kea
RUN dnf -y install isc-kea

CMD ["/usr/sbin/kea-dhcp4", "-c", "/etc/kea/kea-dhcp4.conf"]
