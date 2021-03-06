docker build -t $DOCKER_ID/multi-client:latest -t $DOCKER_ID/multi-client:$SHA  ./client
docker build -t $DOCKER_ID/multi-server:latest -t $DOCKER_ID/multi-server:$SHA  ./server
docker build -t $DOCKER_ID/multi-worker:latest -t $DOCKER_ID/multi-worker:$SHA  ./worker

docker push $DOCKER_ID/multi-client:latest
docker push $DOCKER_ID/multi-server:latest
docker push $DOCKER_ID/multi-worker:latest

docker push $DOCKER_ID/multi-client:$SHA
docker push $DOCKER_ID/multi-server:$SHA
docker push $DOCKER_ID/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=$DOCKER_ID/multi-client:$SHA
kubectl set image deployment/server-deployment server=$DOCKER_ID/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=$DOCKER_ID/multi-worker:$SHA