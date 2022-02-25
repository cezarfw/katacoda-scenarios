Several weeks later on a team video chat, your coworker asks for help again. 

This time, the same app isn't working. Your teammate explains that after some
testing, it can't be re-deployed. They go on to say that the Kubernetes manifest
hasn't changed. You begin to investigate.

Check to see whats running in your cluster.

`kubectl get pods`{{execute}}

Deploy the manifest.

`kubectl apply -f kuard-1-answer.yaml`{{execute}}

Investigate the details of the deployment.

`kubectl get pods`{{execute}}

You see that the Pod is in the `Pending` state. Dig further by running a describe.

`kubectl describe pod kuard`{{execute}}

We see that pod `FailedScheduling` and a message noting `node(s) had taints that
the pod didn't tolerate`.  This clue tells us that some of our nodes have taints
on them and we're missing a matching toleration. Check the taints on the nodes
by running a get on the nodes.

`kubectl get nodes`{{execute}}

If you look through the data you'll find a taint listed.

>NOTE: We can also use jq to
>look for a specific item and that command is shown below. Either will return the
>data you're looking for.

>`kubectl get nodes -o json | jq '.items[].spec.taints'`{{execute}}

We can see that both of our nodes have a taint and the Kubernetes manifest
doesn't have a toleration that matches this. Time to fix the issue.

First start by deleting the existing pod.

`kubectl delete pod kuard`{{execute}}

Now modify the manifest by adding a toleration for the worker node. Edit the
kuard-1.yaml file and add the following in the .spec section.

``` yaml
tolerations:
- key: disktype
  operator: Equal
  value: slow
  effect: NoSchedule
```

>Note: The corrected image answer file is found in the `kuard-2-answer.yaml` if
>you need more information.

Apply the manifest again.

`kubectl apply -f kuard-1.yaml`{{execute}}

Check the pod again and see if the Kubernetes scheduler was able to deploy the
pod now that a toleration was added.

`kubectl get pods`{{execute}}

