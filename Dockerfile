FROM quay.io/rockylinux/rockylinux AS baserocky

FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:centos8-14.2-0

USER root
WORKDIR /usr/src
RUN rm /etc/yum.repos.d/*
COPY --from=baserocky /etc/yum.conf /etc/yum.conf
COPY --from=baserocky /etc/yum.repos.d /etc/yum.repos.d
COPY --from=baserocky /etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial /etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial
RUN dnf clean all;
RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN dnf -y install git make postgresql14-devel pgtap_14 && \
    dnf clean all;
RUN git clone https://github.com/michelp/pgjwt.git
RUN cd pgjwt && make && make install

WORKDIR /
USER 26
