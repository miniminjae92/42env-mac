Dockerfile
docker build -> image
docker run -> container or use docker-compose.yml
docker-compose up and down
docker system df, docker system prune
docker ps, docker image ls, docker rmi image

```
docker build -t 42env:1.0 .
docker tag 42env:1.0 42env:lastest
```

Dockerfile, docker-compose와 local volume을 마운트해서 설정 완료
Host OS:arm64, Container ubuntu 22.04
clipboard 기능 사용하기 위해서 x11 이용
XQuarts install -> xterm settings -> security 수정 -> xhost +localhost
