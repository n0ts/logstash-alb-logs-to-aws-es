## logstash-alb-logs-to-aws-es

This is [logstash container image](https://www.elastic.co/guide/en/logstash/current/docker.html) for [ALB log](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html) put to to [Amazon Elasticsearch Service](https://aws.amazon.com/elasticsearch-service/).


```
$ docker run \
  -e S3_BUCKET=<The name of the S3 buket> \
  -e S3_PREFIX=<The prefix in the bucket> \
  -e ES_HOST=<The Amazon Elasticsearch Service host name> \
  -e ES_INDEX=<The name of elasticsearch index name>
```

* Required IAM role

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "es:Describe*",
                "es:List*",
                "es:ESHttpGet",
                "es:ESHttpHead"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "es:ESHttpDelete",
                "es:ESHttpPost",
                "es:ESHttpPut"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:es:ap-northeast-1:<AWS account id>:domain/<Amazon Elasticsearch Service domain name>/*"
        }
    ]
}
```


### How to runnin in local (use docker-compose)

```
$ AWS_DEFAULT_REGION= AWS_PROFILE= \
  AWS_S3_BUCKET=<s3 bucket> S3_PREFIX=<s3 bucket prefix> \
  LB_DNS_NAME=<dns name of alb> make (up-local|up|down)
```
