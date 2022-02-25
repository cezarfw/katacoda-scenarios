As a cloud support engineer, you receive a call from an employee who needs help
with their new application. The user states that after deploying their
containers, they are unable to access them through a web browser.

You've gotten access to their cluster and have committed to your co-worker to
help them fix this issue.

First, lets get a look at whats happening within the cluster, specifically to
make sure that their container is running.

`kubectl get pods`{{execute}}

Well, there is a pod in a running state which is a good sign. Now, lets look to
see if there is a Kubernetes service associated with that application to publish
it outside the cluster.

`kubectl get services`{{execute}}

We can see that there are two services, within the default namespace, One of
which is the Kubernetes ClusterIP which should be visible on all Kubernetes
clusters. The second service looks to be what is used to connect the `kuard` pod.

Lets see what happens when we try to access the application via a web browser.
Click the Webserver tab to see the status of the application in a browser.

Well, your co-worker was telling the truth, the application isn't available. You
ask to run one more test to confirm your suspicions.

`kubectl get endpoints kuard`{{execute}}

This command returns no endpoints for the kuard pod. This means that the service
that was deployed isn't associated with this pod. Its likely that it was
misconfigured.

Lets take a look at the manifest used to deploy this application. Click the
`kuard-1.yaml` file in the editor to see what was used for the deployment.

### AH HA!

You notice in the manifest that the pod has a label of `app: kuard`. The
service manifest found in the second half of the manifest is trying to select
pods with a label of `application: kuard`. This may seem like a small thing, but these
need to match for the service to be associated with the pods running in the
cluster.

Fix this by changing the service's selector so that they match.
>NOTE: If you are stuck, look at the `scenario1-answer.yaml` file.

When you've made the changes re-apply the manifest by running:

`kubectl apply -f kuard-1.yaml`{{execute}}

After the manifest has been re-applied, check the Webserver tab again to see
your working application.

You can also re-run the `kubectl get endpoints kuard`{{execute}} command
where you'll see an endpoint associated with your running pod now.