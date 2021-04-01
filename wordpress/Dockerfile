FROM wordpress:5.2.2-php7.3-apache

ENV SRC_WP_CONTENT_DIR /usr/src/wordpress/wp-content

ENV RUN_GROUP ec2-user
ENV RUN_GROUP_ID 1000
ENV RUN_USER ec2-user
ENV RUN_USER_ID 1000

RUN groupadd -g ${RUN_GROUP_ID} ${RUN_GROUP}
RUN useradd -u ${RUN_USER_ID} -g ${RUN_GROUP} ${RUN_USER}

RUN mkdir -p ${SRC_WP_CONTENT_DIR}/cache
RUN mkdir -p ${SRC_WP_CONTENT_DIR}/uploads
RUN mkdir -p ${SRC_WP_CONTENT_DIR}/upgrade

RUN echo "file_uploads = On\n" \
  "upload_max_filesize = 900M\n" \
  "post_max_size = 900M\n" \
  "max_execution_time = 300\n" \
  > /usr/local/etc/php/conf.d/uploads.ini

