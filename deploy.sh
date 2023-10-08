docker build -t randyb11595/multi-client:latest -t randyb11595/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t randyb11595/multi-server:latest -t randyb11595/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t randyb11595/multi-worker:latest -t randyb11595/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push randyb11595/multi-client:latest
docker push randyb11595/multi-server:latest
docker push randyb11595/multi-worker:latest

docker push randyb11595/multi-client:$SHA
docker push randyb11595/multi-server:$SHA
docker push randyb11595/multi-worker:$SHA

kubectl apply -f k8s 

kubectl set image deployments/client-deployment client=randyb11595/multi-client:$SHA
kubectl set image deployments/server-deployment server=randyb11595/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=randyb11595/multi-worker:$SHA 