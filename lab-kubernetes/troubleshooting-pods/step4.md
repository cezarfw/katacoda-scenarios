The next day your coworker praises your commitment to helping other team members.
You're starting to gain accolades from your manager for your troubleshooting skills in the
Kubernetes world.

Later that day ...

The same coworker sends you an instant message, letting you know that the
application is broken ... again. It's time for you to put your Kubernetes skills
to the test again.

Check to see whats running in your cluster.

`kubectl get pods`{{execute}}

Deploy the manifest.

`kubectl apply -f kuard-2-answer.yaml`{{execute}}

Investigate the details of the deployment.

`kubectl get pods`{{execute}}

You see that the Pod is in the `Pending` state. Its starting to look like a
toleration is missing again. You dig further by running a describe.

`kubectl describe pod kuard`{{execute}}

This time, you notice that 1 node had a taint the pod didn't tolerate, but it
also notes that 1 node was unschedulable. This clue leads us to think that the
scope of the problem is actually a node. Check the status of the nodes.

`kubectl get nodes`{{execute}}

Here we see that `node01` is in a `Ready` state, but that Scheduling is
disabled. It appears as though someone has cordon'd that node so that the
scheduler wouldn't deploy resources to it. After talking with teammates you find
out that someone was testing and forgot to enable scheduling again.

Uncordon the node to fix the issue.

`kubectl uncordon node01`{{execute}}

Now, check to see if the pod is still in a pending state.

`kubectl get pods`{{execute}}