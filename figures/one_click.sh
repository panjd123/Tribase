echo "Starting one-click setup for TriBase..."
docker pull panjd123/tribase-env:latest

if [ -f benchmarks.zip ]; then
  echo "benchmarks.zip already exists, skipping download."
else
  pipx install gdown
  gdown https://drive.google.com/file/d/1KXG6Yy3b2k1b0b7j1F2v5c3JH9V8xQzD/view?usp=sharing --fuzzy
fi
unzip -o benchmarks.zip

docker run -d \
  --user "$(id -u):$(id -g)" \
  --name tribase-dev \
  -v .:/app/tribase \
  --restart always \
  panjd123/tribase-env \
  tail -f /dev/null

docker exec -it tribase-dev bash script/build.sh
docker exec -it tribase-dev bash figures/run.sh
docker exec -it tribase-dev bash figures/draw.sh
