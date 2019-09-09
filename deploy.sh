docker build -t jeb2162/multi-client:latest -t jeb2162/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeb2162/multi-worker:latest -t jeb2162/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t jeb2162/multi-server:latest -t jeb2162/multi-server:$SHA -f ./server/Dockerfile ./server

docker push jeb2162/multi-client:latest
docker push jeb2162/multi-client:$SHA

docker push jeb2162/multi-server:latest
docker push jeb2162/multi-server:$SHA

docker push jeb2162/multi-worker:latest
docker push jeb2162/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeb2162/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeb2162/multi-client:$SHA
kubectl set image deployments/worker-deployment client=jeb2162/multi-worker:$SHA


