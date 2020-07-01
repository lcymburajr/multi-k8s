docker build -t lcymburajr/multi-client:latest -t lcymburajr/multi-client:$SHA ./client/Dockerfile ./client
docker build -t lcymburajr/multi-server:latest -t lcymburajr/multi-server:$SHA ./server/Dockerfile /server
docker build -t lcymburajr/multi-worker:latest -t lcymburajr/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push lcymburajr/multi-client:latest
docker push lcymburajr/multi-server:latest
docker push lcymburajr/multi-worker:latest

docker push lcymburajr/multi-client:$SHA
docker push lcymburajr/multi-server:$SHA
docker push lcymburajr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=lcymburajr/multi-client:$SHA
kubectl set image deployment/server-deployment server=lcymburajr/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=lcymburajr/multi-worker:$SHA