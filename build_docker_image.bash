image_name="coolnamesalltaken/pico-docker"
git submodule update --init --recursive
docker buildx build --platform linux/amd64,linux/arm64 -t $image_name . --push
