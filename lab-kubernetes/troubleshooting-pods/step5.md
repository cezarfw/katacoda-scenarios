Your coworkers in Kubernetes are really gaining knowledge and pushing forward
with their new initiatives thanks to your guidance. You've become the expert in
the company regarding this matter.

One of your other coworkers is working on a new project and has gotten stuck
deploying a webserver in the production Kubernetes cluster. You offer your
assistance as always.

Check the status of the failed deployment.

`kubectl get pods`{{execute}}

Notice that the `webserver` pod is in a `Pending` state once again. This tells
us that the pod is waiting for a resource of some kind. Dig deeper.

`kubectl describe pod webserver`{{execute}}

You see that the pod failed scheduling because a persistent volume claim (PVC) wasn't
found. It appears as though your co-worker is using a persistent volume (PV) to
mount sound data into the container.

Check the existing persistent volumes.

`kubectl get pv`{{execute}}

And the existing persistent volume claims (PVCs).

`kubectl get pvc`{{execute}}

You'll notice that there is a persistent volume create, and a persistent volume
claim that is bound to this persistent volume. You ask your co-worker about this
and they explain that this IS the volume they expect to mount from their
container. Its time to fix the issue.

Delete the existing webserver deployment.

`kubectl delete -f webserver.yaml`{{execute}}

Now, edit the webserver.yaml in the editor. Replace the `MY_BAD_CLAIM_NAME` with
`task-pv-claim`. 

>Note: Be sure to keep the spacing in the YAML file the same. If you need help,
>refer to the `webserver-1-answer.yaml` file located in the editor.

After updating the `webserver.yaml` file with the correct PVC. Re-deploy the
application.

`kubectl apply -f webserver.yaml`{{execute}}

Then check the status of the pod.

`kubectl get pods`{{execute}}

Once the pod is running, check the `Webserver` tab next to your terminal tab.
This will open a new web page connected to the webserver app you just deployed.