# zookeeper-cluster-in-docker-swarm
Build zookeeper cluster in docker swarm. collect it's logs and metrics

1. Create docker swarm

$ docker swarm init --advertise-addr 192.168.1.25
Replace 192.168.1.25 with the IP of the manager node.
Run "docker swarm join" in the worker nodes with the token given by the above init command.

2. Refer to stack.yml which deploys zookeeper cluster in the swarm.

$ docker stack deploy -c stack.yml zookeeper

3. zookeeper logs:
By default, zookeeper container writes logs to stdout. To change this to write to log file, set the environment variable ZOO_LOG4J_PROP to INFO,ROLLINGFILE. This can be done in stack.yml. This will write the logs in "/logs" folder in the container. This can be mapped to host folder ( eg., /home/orange/myzookeeper) using a bind mount in stack.yml file. To solve the folder permission problem, make necessary changes in the docker_entrypoint.sh present in the root folder of the container and overwrite it in the Dockerfile.

4. zookeeper metrics:

metrics turned on by default. metricbeat knows the end points to collect metrics.

metricbeat configuration:

module: zookeeper

enabled: true

metricsets: ["mntr"]

period: 10s

hosts: ["localhost:2181", "localhost:2182", "localhost:2183"]

  
5. zookeeper config file ( "$ZOO_CONF_DIR/zoo.cfg")

The zkServer.sh script creates zoo.cfg, if none exists. It uses server info passed through stack.yml file. Default value of $ZOO_CONF_DIR is /conf
You can override it, provided you know what you are doing.
