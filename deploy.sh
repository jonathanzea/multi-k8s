docker build -t zetajonathan/multi-client:latest -t zetajonathan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zetajonathan/multi-server:latest -t zetajonathan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zetajonathan/multi-worker:latest -t zetajonathan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zetajonathan/multi-client:latest
docker push zetajonathan/multi-server:latest
docker push zetajonathan/multi-worker:latest

docker push zetajonathan/multi-client:$SHA
docker push zetajonathan/multi-server:$SHA
docker push zetajonathan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=zetajonathan/multi-client:$SHA
kubectl set image deployments/server-deployment server=zetajonathan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=zetajonathan/multi-worker:$SHA

