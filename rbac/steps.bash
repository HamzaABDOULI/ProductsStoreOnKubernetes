mkdir cert

cd  cert/

# generate .key
openssl genrsa -out hamza.key 2048

# generate .csr
openssl req -new \
    -key hamza.key \
    -out hamza.csr \
    -subj "/CN=hamza/O=eralabs"

ls ~/.minikube/
# Check that the files ca.crt and ca.key exist in the location.

# generate .crt
openssl x509 -req \
    -in hamza.csr \
    -CA ~/.minikube/ca.crt \
    -CAkey ~/.minikube/ca.key \
    -CAcreateserial \
    -out hamza.crt \
    -days 500

kubectl config set-credentials hamza \
    --client-certificate=cert/hamza.crt \
    --client-key=cert/hamza.key

kubectl config set-context hamza-context \
    --cluster=minikube \
    --namespace=office \
    --user=hamza

kubectl config use-context hamza-context

kubectl config use-context minikube
