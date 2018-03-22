# helm servecm plugin
<img align="right" src="https://github.com/kubernetes-helm/chartmuseum/raw/master/logo.png">

A drop-in replacement for `helm serve` which starts a [ChartMuseum](https://github.com/kubernetes-helm/chartmuseum) web server.

## Install

```
$ helm plugin install https://github.com/jdolitsky/helm-servecm
Installed plugin: servecm
```

If ChartMuseum is not installed, it will ask to install the latest stable release upon use:
```
$ helm servecm
ChartMuseum not installed. Install latest stable release? (type "yes"): yes
Attempting to install ChartMuseum server (v0.4.2)...
Detected your os as "darwin"
+ curl -LO https://s3.amazonaws.com/chartmuseum/release/v0.4.2/bin/darwin/amd64/chartmuseum
```

## Usage

Pass in the same args you would use for ChartMuseum:
```
$ helm servecm --help
```

S3 bucket example (bucket containing nothing but `drupal-0.9.1.tgz`):
```
$ export DEBUG=1  # this is needed if you want debug, helm steals the flag
$ helm servecm --port=8879 --context-path=/charts \
  --storage="amazon" \
  --storage-amazon-bucket="my-s3-bucket" \
  --storage-amazon-prefix="" \
  --storage-amazon-region="us-east-1"
2018-03-22T17:42:45.815-0500	DEBUG	Fetching chart list from storage
2018-03-22T17:42:46.893-0500	DEBUG	Regenerating index.yaml
2018-03-22T17:42:46.893-0500	DEBUG	Loading charts packages from storage (this could take awhile)	{"total": 1}
2018-03-22T17:42:46.974-0500	DEBUG	Adding chart to index	{"name": "drupal", "version": "0.9.1"}
2018-03-22T17:42:46.974-0500	DEBUG	index.yaml regenerated
2018-03-22T17:42:46.974-0500	INFO	Starting ChartMuseum	{"port": 8879}
```

Then use with Helm CLI:
```
helm repo add local http://127.0.0.1:8879/charts
helm install local/drupal
```

## Credits

Project layout taken from [adamreese/helm-nuke](https://github.com/adamreese/helm-nuke).
