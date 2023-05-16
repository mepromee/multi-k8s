docker build -t mepromee/multi-client:latest -t mepromee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mepromee/multi-server:latest -t mepromee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mepromee/multi-worker:latest -t mepromee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mepromee/multi-client:latest
docker push mepromee/multi-server:latest
docker push mepromee/multi-worker:latest

docker push mepromee/multi-client:$SHA
docker push mepromee/multi-server:$SHA
docker push mepromee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mepromee/multi-server:$SHA
kubectl set image deployments/client-deployment client=mepromee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mepromee/multi-worker:$SHA