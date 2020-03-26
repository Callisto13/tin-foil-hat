IMAGE = callisto13/tin-foil-hat

.PHONY: all

all: build push

build:
	@docker build -t $(IMAGE) .

push:
	@docker push $(IMAGE)
