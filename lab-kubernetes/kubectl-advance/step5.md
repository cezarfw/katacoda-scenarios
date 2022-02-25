To dump logs from a specified pod or container into the standard output, use the `kubectl logs POD_NAME`

Let's switch to the kube-system namespace and access some logs: 

`kubectl ns kube-system`{{execute}}  

Let's get all the pods: 
 
`kubectl get pods`{{execute}}

Use the `pod-logs` plugin to get the weave pods logs:

`kubectl pod-logs`{{execute}}  

Select one of the pods from the list and review the logs.

Alternatively, you can use the `kubectl logs` command to view container logs (see `kubectl logs --help` for more information).

**Note:**
*If a pod has more than one container, the `-c CONTAINER_NAME` option can be used to specify which container's logs to output.*

*The `pod-logs` plug-in does not allow output redirection. Therefore, if you want to redirect the output use `kubectl logs` as such:
`kubectl logs POD  -c CONTAINER > logsfile`.*

Switch back to the default namespace before moving on to the next step:

`kubectl ns default`{{execute}}