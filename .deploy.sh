docker build -t jamespool/multi-client:latest -t jamespool/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jamespool/multi-server:latest -t jamespool/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t jamespool/multi-worker:latest -t jamespool/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jamespool/multi-client:latest
docker push jamespool/multi-client:$SHA
docker push jamespool/multi-server:latest
docker push jamespool/multi-server:$SHA
docker push jamespool/multi-worker:latest
docker push jamespool/multi-worker:$SHA

kubectl apply -f k8s/

kubectl set image deployments/server-deployment server=jamespool/multi-server:$SHA
kubectl set image deployments/client-deployment client=jamespool/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jamespool/multi-worker:$SHA