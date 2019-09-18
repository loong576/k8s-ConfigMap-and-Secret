FROM centos:centos7.6.1810 

ADD date-random.sh /usr/bin/date-random

ENTRYPOINT ["/usr/bin/date-random"]

#CMD ["10"]
