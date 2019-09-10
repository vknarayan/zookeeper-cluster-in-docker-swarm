FROM zookeeper:3.5.5

USER root

# copy docker-entrypoint.sh into the image and make it executable
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Call entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]
