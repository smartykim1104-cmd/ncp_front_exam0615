#!/usr/bin/env bash
set -e

IMAGE_NAME="my-diary-frontend"
CONTAINER_NAME="my-diary-frontend"
BACKEND_HOST="10.10.2.6"

cd "$(dirname "$0")/.."

# 기존 컨테이너 중지 및 제거
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

# Frontend 이미지 빌드
# 이미지 빌드 시 Backend 호스트주소를 주입
docker build \
  --build-arg BACKEND_HOST="$BACKEND_HOST" \
  -t "$IMAGE_NAME" .

# 컨테이너 실행하는 구문
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 80:80 \
  --restart unless-stopped \
  "$IMAGE_NAME"

echo "Frontend container is running."
