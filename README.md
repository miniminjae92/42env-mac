create Dockerfile
create docker-compose.yml
docker run -> container or use docker-compose.yml
docker-compose up and down

```
docker build -t 42env:1.0 .
docker tag 42env:1.0 42env:lastest
docker-compose up -d --build
docker-compose build --no-cache
docker-compose down
docker images
docker ps
docker system df
docker system prune
docker rmi 42env:1.0
```

Dockerfile, docker-compose와 local volume을 마운트해서 설정 완료
Host OS:arm64, Container ubuntu 22.04
clipboard 기능 사용하기 위해서 x11 이용
XQuarts install -> xterm settings -> security 수정 -> xhost +localhost

볼륨 마운트 권한 문제 해결을 위해서 uid, gid 사용 설정
