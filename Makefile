.PHONY: archive
archive:
	./archive.sh $(DB)

.PHONY: tetrio-metrics
tetrio-metrics:
	./tetrio-metrics.sh

docker-tetrio-metrics:
	docker build . -t tetrio-metrics -f tetrio-metrics.Dockerfile
	docker run --rm -v $(PWD):/mnt/tetrio-metrics-archive --name tetrio-metrics tetrio-metrics
