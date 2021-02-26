docker build -t delriobilbao/multi-client:latest -t delriobilbao/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t delriobilbao/multi-server:latest -t delriobilbao/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t delriobilbao/multi-worker:latest -t delriobilbao/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push delriobilbao/multi-client:latest
docker push delriobilbao/multi-server:latest
docker push delriobilbao/multi-worker:latest

docker push delriobilbao/multi-client:$SHA
docker push delriobilbao/multi-server:$SHA
docker push delriobilbao/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=delriobilbao/multi-server:$SHA
kubectl set image deployments/client-deployment client=delriobilbao/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=delriobilbao/multi-worker:$SHA
