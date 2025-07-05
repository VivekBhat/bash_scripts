# Kubectl Helper Commands
# Examples:
# View Logs of a Single Pod:

kubectl logs my-pod-name -n my-namespace

# View Logs of a Specific Container in a Pod (if multiple containers exist):
kubectl logs my-pod-name -c my-container-name -n my-namespace

# View Logs Continuously (Similar to tail -f):
kubectl logs -f my-pod-name -n my-namespace

# View Previous Logs (from a previous instance of the container, if it has crashed or restarted):
kubectl logs my-pod-name -n my-namespace --previous

## Forward Port 8080 on Your Local Machine to Port 80 on the Pod:
kubectl port-forward my-pod-name 8080:80 -n my-namespace
