docker build -t radu93/multi-client:latest -t radu93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t radu93/multi-server:latest -t radu93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t radu93/multi-worker:latest -t radu93/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push radu93/multi-client:latest
docker push radu93/multi-server:latest
docker push radu93/multi-worker:latest
docker push radu93/multi-client:$SHA
docker push radu93/multi-server:$SHA
docker push radu93/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=radu93/multi-server:$SHA
kubectl set image deployments/client-deployment client=radu93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=radu93/multi-worker:$SHA