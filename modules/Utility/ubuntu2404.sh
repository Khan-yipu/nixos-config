podman create \
  --name ubuntu2404 \
  # --network slirp4netns \
  --userns=keep-id \
  # -v /home/khanif/.vimrc:/home/ubuntu/.vimrc:ro \
  # -v /home/khanif/.vim:/home/ubuntu/.vim:ro \
  # -v /home/khanif/.config/fish:/home/ubuntu/.config/fish:ro \
  -v /home/khanif/f2m:/home/ubuntu/f2m:rw \
  docker.io/library/ubuntu:24.04 \
  sleep infinity