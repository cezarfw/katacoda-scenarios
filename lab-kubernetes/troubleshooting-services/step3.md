Your continued success at solving Kubernetes problems has earned you a
promotion. You're now the team leader at your company. The go-to person for the
advanced Kubernetes problems.

One of your teammates asks you for help with solving a problem with one of the
development clusters. Your teammate explains that none of the applications
deployed within the cluster are accessible. These applications have been tested
using the same YAML manifests on other clusters and have been found to work just
fine.

As you sit down at the keyboard to begin troubleshooting, you keep in mind that
your co-worker knows basic Kubernetes troubleshooting and the usual problems
have probably been checked. Based on the fact that the same manifests work in
other clusters, you suspect the scope of this issue is cluster related, rather
than the application.

First, check the application status by checking the `Webserver` tab. 
Then run:
`kubectl get pods -n prodapps -o wide`{{execute}} 
where you verify the webserver pod is running without any issues.

Next, check the service exposing the webserver by running
`kubectl get services -n prodapps`{{execute}}.

You see that the service is configured. Check the Kubernetes Endpoints to make
sure the pod is exposed properly. `kubectl get endpoints -n prodapps`{{execute}}.

Sure enough, the pod has a proper service endpoint so traffic should be getting
to the pod. Your suspicions about this being a cluster scoped issue are starting
to overwhelm you. Its time to check the cluster components within the
kube-system namespace.

`kubectl get pods -n kube-system`{{execute}}

At first glance, things look to be in pretty good shape. Your pods are all in a
running state, but we're missing a `kube-proxy`. 

>Note: You may have a katacode pod that is in an error state. This is not
>material to the lab.

The kube proxy is supposed to be deployed on each node (usually a daemonset) and configures the
hosts routing rules. For instance, ensuring traffic can get to your service
endpoints that we already validated.

You need to get kube-proxy deployed. Use the kube-proxy.yaml manifest visible in
the editor, to deploy the kube-proxy components into the cluster.

`kubectl apply -f kube-proxy.yaml`{{execute}}

Now, check the Webserver again to see if the issue is resolved.