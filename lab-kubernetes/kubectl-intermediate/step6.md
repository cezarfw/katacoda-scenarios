Now that we have created two new namespaces, we can deploy a container in each of the namespaces.

Let's  deploy a single `redis` container into the `backend` namespace using `kubectl run`. Type the below command:

`kubectl run redis --image=quay.io/quay/redis -n backend`{{execute}}

Let's deploy a single `nginx` container application in the `frontend` namespace using `kubectl run`. Type the below command:

`kubectl run nginx --image=quay.io/bitnami/nginx --namespace frontend`{{execute}}

Now. let's verify whether our pods have been created:

`kubectl get pods`{{execute}}

**Oops!** `No resources found`. You won't see any resources, because you are currently in the `default` namespace and the new containers were deployed into different namespaces. To retrieve and display the newly created containers, we need to pass the `--namespace NAMESPACE-NAME` flag  or the `-n` flag, which is short for the `--namespace` flag.

Let's check on the *pods* created in the `frontend` *namespace* by typing the below command:

`kubectl get pods --namespace frontend`{{execute}}

We can run a similar command to check on the *pods* in the `backend` *namespace* by typing:

`kubectl get pods -n backend`{{execute}}
