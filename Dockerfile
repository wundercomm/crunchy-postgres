FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-14.2-1

USER root
WORKDIR /usr/src
RUN rm /etc/yum.repos.d/crunchypg14.repo
RUN microdnf clean all;
RUN curl -o /tmp/pgdg-redhat-repo-latest.noarch.rpm https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN rpm -i /tmp/pgdg-redhat-repo-latest.noarch.rpm
RUN microdnf -y install git make postgresql14-devel pgtap_14 && \
    microdnf clean all;
RUN git clone https://github.com/michelp/pgjwt.git
RUN cd pgjwt && make && make install

WORKDIR /
USER 26
