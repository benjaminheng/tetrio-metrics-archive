.PHONY: archive
archive:
	./archive.sh $(DB)

docker-tetrio-metrics:
	docker build . -t tetrio-metrics
	docker run -d -v $(PWD):/mnt/tetrio-metrics-archive --name tetrio-metrics --restart always tetrio-metrics
