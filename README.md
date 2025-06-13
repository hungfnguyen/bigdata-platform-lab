# Big Data Docker Setup

This project sets up a local Big Data environment using Docker Compose. It includes essential services like Hadoop, Hive, Spark, Kafka, and more — ideal for students and data engineers who want to **learn, experiment, and build pipelines** using industry-standard tools.

---

## Included Components

| Service        | Description                                                  |
| -------------- | ------------------------------------------------------------ |
| **Hadoop**     | HDFS with 1 NameNode and 2 DataNodes for distributed storage |
| **Hive**       | Hive Metastore, HiveServer2, and MariaDB for SQL-on-HDFS     |
| **Spark**      | Spark Master, Workers, Thrift Server, Jupyter Notebook       |
| **Kafka**      | Kafka + Zookeeper + Schema Registry + Control Center         |
| **SQL Server** | Optional Microsoft SQL Server instance for testing           |

---

## How to Use

### 1. Requirements

* Docker and Docker Compose installed
* Create a shared external Docker network:

```bash
docker network create data_network
```

### 2. Start Services

Run the following commands from the project root to launch each stack:

```bash
docker-compose -f hadoop/docker-compose.yaml up -d
docker-compose -f hive/docker-compose.yaml up -d
docker-compose -f spark/docker-compose.yaml up -d
docker-compose -f kafka/docker-compose.yml up -d
```

> You can start only the services you need depending on what you're learning.

---

## Web Interfaces

| Service              | URL                                            |
| -------------------- | ---------------------------------------------- |
| HDFS NameNode UI     | [http://localhost:9870](http://localhost:9870) |
| Spark Master UI      | [http://localhost:8082](http://localhost:8082) |
| Jupyter Notebook     | [http://localhost:8890](http://localhost:8890) |
| Kafka Control Center | [http://localhost:9021](http://localhost:9021) |
| Schema Registry      | [http://localhost:8081](http://localhost:8081) |

---

## Use Cases

This setup is perfect for learning:

* HDFS file storage and management
* Writing SQL queries with Hive
* Building Spark jobs for batch or interactive processing
* Streaming with Kafka
* Integrating services like Hive ↔ Spark ↔ Kafka

---
## Authors

- **Hung Nguyen** – [@hungfnguyen](https://github.com/hungfnguyen)
