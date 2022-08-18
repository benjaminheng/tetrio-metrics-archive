.PHONY: archive
archive:
	./archive.sh $(DB)

.PHONY: tetrio-metrics
tetrio-metrics:
	./tetrio-metrics.sh
