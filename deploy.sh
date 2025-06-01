docker build -t taufinrusli/multi-client:latest -t taufinrusli/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t taufinrusli/multi-server:latest -t taufinrusli/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t taufinrusli/multi-worker:latest -t taufinrusli/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push taufinrusli/multi-client:latest
docker push taufinrusli/multi-server:latest
docker push taufinrusli/multi-worker:latest
docker push taufinrusli/multi-client:$SHA
docker push taufinrusli/multi-server:$SHA
docker push taufinrusli/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=taufinrusli/multi-client:$SHA
kubectl set image deployments/server-deployment server=taufinrusli/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=taufinrusli/multi-worker:$SHA