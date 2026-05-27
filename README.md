# Kubernetes

Kubernetes cluster which consists of the following components:

- gRPC & RestAPI applications
  - ASP.Net Core
  - Node.JS
  - Python Quart with Hypercorn ASGI/WSGI
  - LLM RAG
- Databases
  - PostgreSQL (with vector extension)
  - Neo4J
  - Chroma vector database
- Elasticsearch cluster
  - 3 Master nodes
  - 5 Slave nodes
- Ollama LLM model server
- Redis cluster
- RabbitMQ cluster
- Ethereum node which consists of:
  - Executor (GETH)
  - Consensus (Lodestar Beacon and Validator)

## Prerequisites

- Install microk8s
- Install awscli
- Install sops for secrets encryption/decryption.
- Install helm-secrets plugin.
- Run `aws config` to set up aws configurations and credentials

## Update kubeconfig

- `aws eks update-kubeconfig --region <region> --name <cluster name>`
- The step above will update `~/.kube/config`
- However, `microk8s.kubectl` uses the config in `/var/snap/microk8s/current/credentials/client.config`
- For local k8s cluster, `cp /var/snap/microk8s/current/credentials/client.config ~/.kube/config`
- So, copy the EKS config from `~/.kube/config` to `/var/snap/microk8s/current/credentials/client.config`

## Set Aliases

`snap alias microk8s.kubectl kubectl`

## List and use contexts

- `kubectl config get-contexts` will show available clusters, both local and remote:

  ```
  $ k config get-contexts
  CURRENT   NAME        CLUSTER            AUTHINFO    NAMESPACE
  *         mycluster   mycluster          myuser
            microk8s    microk8s-cluster   admin
  ```

- `kubectl config use-context` to select a cluster to work with.

![Kubernetes cluster](./k8s.jpg?raw=true "Kubernetes Cluster")

## Helm Charts

```
$ helm list
NAME         	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART              	APP VERSION
common-config	default  	1       	2026-04-30 19:48:02.558336511 +0800 +08	deployed	common-config-1.0.0	1.0.0
mlflow       	default  	1       	2026-05-10 18:45:05.436044549 +0800 +08	deployed	mlflow-1.0.0       	1.0.0
neo4j        	default  	1       	2026-04-30 12:14:44.725694023 +0800 +08	deployed	Neo4J-1.0.0        	1.0.0
nodejsrestapi	default  	1       	2026-04-30 12:26:15.66047827 +0800 +08 	deployed	NodeJSRestAPI-1.0.0	1.0.0
ollama       	default  	1       	2026-04-30 19:43:59.079113432 +0800 +08	deployed	Ollama-1.0.0       	1.0.0
postgresql   	default  	2       	2026-04-30 19:52:32.278028891 +0800 +08	deployed	PostgreSQL-1.0.0   	1.0.0
pythonrestapi	default  	1       	2026-04-30 12:26:31.715122897 +0800 +08	deployed	PythonRestAPI-1.0.0	1.0.0
ragagent     	default  	1       	2026-04-30 12:27:31.357106725 +0800 +08	deployed	RAGAgent-1.0.0     	1.0.0
redis-cluster	default  	1       	2026-05-06 12:43:23.866466742 +0800 +08	deployed	RedisCluster-1.0.0 	1.0.0
```

## Cluster Resources

```
$ k get all
NAME                                          READY   STATUS      RESTARTS   AGE
pod/daemonset-8s4zs                           1/1     Running     0          108m
pod/khteh-es-es-master-0                      1/1     Running     0          3m18s
pod/khteh-es-es-master-1                      1/1     Running     0          3m18s
pod/khteh-es-es-master-2                      1/1     Running     0          3m18s
pod/khteh-es-es-data-0                        1/1     Running     0          3m18s
pod/khteh-es-es-data-1                        1/1     Running     0          3m17s
pod/khteh-es-es-data-3                        1/1     Running     0          3m17s
pod/khteh-es-es-data-4                        1/1     Running     0          3m17s
pod/khteh-es-es-data-2                        1/1     Running     0          3m17s
pod/khteh-kibana-kb-fcd8b8985-rjlwc           1/1     Running     0          3m58s
pod/khteh-kibana-kb-fcd8b8985-8sp56           1/1     Running     0          3m57s
pod/kibana-0                                  1/1     Running     0          14m
pod/kibana-1                                  1/1     Running     0          14m
pod/postgresql-0                              1/1     Running     8 (4h10m ago)     3d22h
pod/chroma-0                                  1/1     Running     1 (5h50m ago)   23h
pod/neo4j-0                                   1/1     Running     0          14m
pod/nodejsrestapi-0                           2/2     Running     0          30s
pod/nodejsrestapi-1                           2/2     Running     0          30s
pod/pythonrestapi-0                           2/2     Running     0          49m
pod/pythonrestapi-1                           2/2     Running     0          49m
pod/ollama-0                                  2/2     Running     0          19m
pod/ollama-1                                  2/2     Running     0          19m
pod/rabbitmq-server-0                         1/1     Running    11         2d3h
pod/rabbitmq-server-1                         1/1     Running    11         2d3h
pod/rabbitmq-server-2                         1/1     Running    11         2d3h
pod/redis-cluster-0                           1/1     Running     0          14d
pod/redis-cluster-1                           1/1     Running     0          14d
pod/redis-cluster-2                           1/1     Running     0          14d
pod/redis-cluster-3                           1/1     Running     0          14d
pod/redis-cluster-4                           1/1     Running     0          14d
pod/redis-cluster-5                           1/1     Running     0          14d

NAME                                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/kubernetes                    ClusterIP   10.152.183.1     <none>        443/TCP             145m
service/khteh-es-es-transport         ClusterIP   None             <none>        9300/TCP            5m18s
service/khteh-es-es-http              ClusterIP   10.152.183.80    <none>        9200/TCP            5m18s
service/khteh-es-es-internal-http     ClusterIP   10.152.183.49    <none>        9200/TCP            5m18s
service/khteh-es-es-master            ClusterIP   None             <none>        9200/TCP            5m16s
service/khteh-es-es-data              ClusterIP   None             <none>        9200/TCP            5m16s
service/khteh-kibana-kb-http          ClusterIP   10.152.183.49    <none>        5601/TCP            6m33s
service/svc-postgresql                ClusterIP   None             <none>        5432/TCP            3d22h
service/svc-postgresql-nodeport       NodePort    10.152.183.70    <none>        5432:30000/TCP      3d22h
service/svc-chroma                    ClusterIP   None             <none>        80/TCP              2d
service/svc-chroma-nodeport           NodePort    10.152.183.193   <none>        80:30005/TCP        2d
service/svc-nodejsrestapi             ClusterIP   None             <none>        443/TCP             70s
service/svc-nodejsrestapi-nodeport    NodePort    10.152.183.243   <none>        443:31004/TCP       69s
service/svc-pythonrestapi             ClusterIP   None             <none>        80/TCP,443/UDP      49m
service/svc-pythonrestapi-nodeport    NodePort    10.152.183.195   <none>        443:31002/UDP       49m
service/svc-ollama                    ClusterIP   None             <none>        11434/TCP           19m
service/svc-ollama-nodeport           NodePort    10.152.183.76    <none>        11434:32000/TCP     19m
service/rabbitmq                      ClusterIP   10.152.183.93    <none>        5671/TCP,15671/TCP,15691/TCP                   2d3h
service/rabbitmq-nodes                ClusterIP   None             <none>        4369/TCP,25672/TCP                             2d3h
service/svc-redis-cluster             ClusterIP   None             <none>        6379/TCP,16379/TCP  61d
service/svc-ragagent                  ClusterIP   None             <none>        80/TCP,4433/TCP,443/UDP                        20h
service/svc-ragagent-nodeport         NodePort    10.152.183.169   <none>        443:31003/UDP                                  58s
service/svc-neo4j                     ClusterIP   None             <none>        7473/TCP,7474/TCP,7687/TCP                     5m56s
service/svc-neo4j-nodeport            NodePort    10.152.183.170   <none>        7473:30002/TCP,7474:30003/TCP,7687:30004/TCP   5m56s

NAME                                               DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/daemonset                           1         1         1       1            1           <none>          108m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
khteh-kibana-kb                        2/2     2            2           7m45s

NAME                                    READY   AGE
statefulset.apps/khteh-es-es-master     3/3     16m
statefulset.apps/khteh-es-es-data       5/5     16m
statefulset.apps/postgresql             1/1     140m
statefulset.apps/chroma                 1/1     23h
statefulset.apps/neo4j                  1/1     140m
statefulset.apps/nodejsrestapi          2/2     105s
statefulset.apps/pythonrestapi          2/2     49m
statefulset.apps/ollama                 2/2     19m
statefulset.appsrabbitmq-server         3/3     2d3h
statefulset.apps/redis-cluster          6/6     14d

NAME                                              REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/kibana-hpa    StatefulSet/kibana    3%/75%    2         5         2          74s
horizontalpodautoscaler.autoscaling/restapi-hpa   StatefulSet/restapi   1%/75%    2         5         2          23m
```

## Redis Cluster:

- 3 master nodes
- 3 slave nodes

```
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:6
cluster_size:3
cluster_current_epoch:6
cluster_my_epoch:1
cluster_stats_messages_ping_sent:8926
cluster_stats_messages_pong_sent:8993
cluster_stats_messages_sent:17919
cluster_stats_messages_ping_received:8988
cluster_stats_messages_pong_received:8929
cluster_stats_messages_meet_received:5
cluster_stats_messages_received:17922
total_cluster_links_buffer_limit_exceeded:0
cluster_slot_migration_active_tasks:0
cluster_slot_migration_active_trim_running:0
cluster_slot_migration_active_trim_current_job_keys:0
cluster_slot_migration_active_trim_current_job_trimmed:0
cluster_slot_migration_stats_active_trim_started:0
cluster_slot_migration_stats_active_trim_completed:0
cluster_slot_migration_stats_active_trim_cancelled:0
redis-cluster-0
master
12530
10.1.207.210
6379
12530

redis-cluster-1
master
12530
10.1.207.220
6379
12530

redis-cluster-2
master
12530
10.1.207.196
6379
12530

redis-cluster-3
slave
10.1.207.255
6379
connected
12530

redis-cluster-4
slave
10.1.207.244
6379
connected
12530

redis-cluster-5
slave
10.1.207.223
6379
connected
12530
```

## Elasticsearch Cluster:

```
$ k get es
NAME       HEALTH   NODES   VERSION   PHASE   AGE
khteh-es   green    8       9.2.2    Ready   5m35s
```

## Kibana

- Point the browser to localhost/kibana
- Supports GeoIP

```
$ k get kibana
NAME           HEALTH   NODES   VERSION   AGE
khteh-kibana   green    2       9.2.2    5m5s
```

## RabbitMQ Cluster:

```
$ k get rabbitmqcluster
NAME       ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmq   True               True               2d3h
```

- Status:

```
$ k exec -it rabbitmq-server-0 -- rabbitmq-diagnostics status
Defaulted container "rabbitmq" out of: rabbitmq, setup-container (init)
Status of node rabbit@rabbitmq-server-0.rabbitmq-nodes.default ...
Runtime

OS PID: 1
OS: Linux
Uptime (seconds): 13461
Is under maintenance?: false
RabbitMQ version: 4.2.6
RabbitMQ release series support status: see https://www.rabbitmq.com/release-information
Node name: rabbit@rabbitmq-server-0.rabbitmq-nodes.default
Erlang configuration: Erlang/OTP 27 [erts-15.2.7.8] [source] [64-bit] [smp:16:1] [ds:16:1:10] [async-threads:1] [jit:ns]
Crypto library: OpenSSL 3.5.6 7 Apr 2026
Erlang processes: 501 used, 1048576 limit
Scheduler run queue: 1
Cluster heartbeat timeout (net_ticktime): 60

Plugins

Enabled plugin file: /operator/enabled_plugins
Enabled plugins:

 * rabbitmq_prometheus
 * rabbitmq_peer_discovery_k8s
 * rabbitmq_federation_management
 * rabbitmq_federation
 * rabbitmq_top
 * rabbitmq_exchange_federation
 * rabbitmq_peer_discovery_common
 * rabbitmq_shovel
 * amqp10_client
 * prometheus
 * gun
 * rabbitmq_queue_federation
 * rabbitmq_federation_common
 * ddskerl
 * rabbitmq_management
 * rabbitmq_management_agent
 * rabbitmq_web_dispatch
 * amqp_client
 * cowboy
 * oauth2_client
 * jose

Data directory

Node data directory: /var/lib/rabbitmq/mnesia/rabbit@rabbitmq-server-0.rabbitmq-nodes.default
Raft data directory: /var/lib/rabbitmq/mnesia/rabbit@rabbitmq-server-0.rabbitmq-nodes.default/quorum/rabbit@rabbitmq-server-0.rabbitmq-nodes.default

Config files

 * /etc/rabbitmq/conf.d/10-defaults.conf
 * /etc/rabbitmq/conf.d/10-operatorDefaults.conf
 * /etc/rabbitmq/conf.d/11-default_user.conf
 * /etc/rabbitmq/conf.d/90-userDefinedConfiguration.conf

Log file(s)

 * <stdout>

Alarms

(none)

Tags

(none)

Memory

Total memory used: 0.1321 gb
Calculation strategy: rss
Memory high watermark setting: 0.6 of available memory, computed to: 2.577 gb

reserved_unallocated: 0.0519 gb (39.26 %)
other_system: 0.0277 gb (20.96 %)
code: 0.0242 gb (18.36 %)
other_proc: 0.0176 gb (13.34 %)
plugins: 0.0039 gb (2.98 %)
metrics: 0.002 gb (1.51 %)
other_ets: 0.0012 gb (0.91 %)
atom: 0.0012 gb (0.89 %)
allocated_unused: 0.0011 gb (0.86 %)
metadata_store: 0.0004 gb (0.32 %)
msg_index: 0.0004 gb (0.27 %)
mgmt_db: 0.0002 gb (0.15 %)
binary: 0.0002 gb (0.14 %)
metadata_store_ets: 0.0 gb (0.03 %)
quorum_ets: 0.0 gb (0.0 %)
connection_other: 0.0 gb (0.0 %)
quorum_queue_procs: 0.0 gb (0.0 %)
quorum_queue_dlx_procs: 0.0 gb (0.0 %)
stream_queue_procs: 0.0 gb (0.0 %)
stream_queue_replica_reader_procs: 0.0 gb (0.0 %)
mnesia: 0.0 gb (0.0 %)
connection_readers: 0.0 gb (0.0 %)
connection_writers: 0.0 gb (0.0 %)
stream_queue_coordinator_procs: 0.0 gb (0.0 %)
queue_procs: 0.0 gb (0.0 %)
connection_channels: 0.0 gb (0.0 %)

File Descriptors

Total: 0, limit: 65439

Free Disk Space

Low free disk space watermark: 2.0 gb
Free disk space: 259.0934 gb

Totals

Connection count: 0
Queue count: 0
Virtual host count: 1

Listeners

Interface: [::], port: 15671, protocol: https, purpose: HTTP API over TLS (HTTPS)
Interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Interface: [::], port: 15691, protocol: https/prometheus, purpose: Prometheus exporter API over TLS (HTTPS)
Interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Interface: [::], port: 5671, protocol: amqp/ssl, purpose: AMQP 0-9-1 and AMQP 1.0 over TLS
```

- Listeners:

```
$ k exec -it rabbitmq-server-0 -- rabbitmq-diagnostics listeners
Defaulted container "rabbitmq" out of: rabbitmq, setup-container (init)
Asking node rabbit@rabbitmq-server-0.rabbitmq-nodes.default to report its protocol listeners ...
Interface: [::], port: 15671, protocol: https, purpose: HTTP API over TLS (HTTPS)
Interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Interface: [::], port: 15691, protocol: https/prometheus, purpose: Prometheus exporter API over TLS (HTTPS)
Interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Interface: [::], port: 5671, protocol: amqp/ssl, purpose: AMQP 0-9-1 and AMQP 1.0 over TLS
```

## Horizontal Pod Autoscaler:

```
$ k get hpa
NAME          REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
kibana-hpa    StatefulSet/kibana    11%/75%   2         5         2          20s
restapi-hpa   StatefulSet/restapi   1%/75%    2         5         2          22m
rabbitmq-hpa  StatefulSet/rabbitmq  41%/75%   3         6         3          4d5h
```

## Manifest validation

- `sudo apt install -y yamllint`
- `yamllint <filename>.yml`

## GPU

- Ensure the operator is running properly

```
$ k get all -n gpu-operator-resources
$ k logs -n gpu-operator-resources -lapp=nvidia-operator-validator -c nvidia-operator-validator
```

- Check GPU resource availability:

```
$ k get nodes
$ k describe node <node name>
Capacity:
  cpu:                16
  ephemeral-storage:  959786032Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             71442080Ki
  nvidia.com/gpu:     0       <- XXX
  pods:               110
Allocatable:
  cpu:                16
  ephemeral-storage:  958737456Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             71339680Ki
  nvidia.com/gpu:     0     <- XXX
  pods:               110
```

## Helm Charts

### Secrets

- Create a GPG key: `gpg --full-generate-key`
- `gpg --list-keys`
  - Use the public key signature as `pgp` value in `.sops.yaml` configuration file.
- `gpg --list-secret-keys`
- Encrypt secret files: `helm secrets encrypt my_secret.yml > my_secret.yml.enc`

### Debug

- `helm lint <chart folder>`
- `helm template --debug <chart folder>`

### Install

- To find versions of chart from remote repository:

```
$ helm search repo <repo-name>/<chart-name> --versions
```

- `helm install <name> --dry-run --debug <chart folder> --set-file secretPath=<secret file path> --wait`
- `--wait` is needed especially for running helm hooks which need the pods to be in ready state.
- `helmfile sync`: Executes `helm upgrade --install` for all releases defined in the file.
- `helmfile apply`: Similar to sync, but often used with the helm-diff plugin to show changes before applying them.

### Update

- `helm upgrade --install <name> <chart folder>`

### Uninstall

- `helm uninstall <name>`
