Your recent troubleshooting skills have not gone un-noticed amongst your peers.
They now look at you as the subject matter expert in all things Kubernetes.

Your co-workers, not to be out done, have been adding some new skills as well
and have started putting their resources into different namespaces. Again, your
phone rings about an issue within the lab cluster.

Your puzzled colleagues have deployed their production web server within its own
namespace called `prodapps`. The application is running and visible to users.

`Click the Webserver tab to display the application.`

The application should be working, but your colleagues inform you that they are
unable to access this application from pods in other namespaces. They begin
walking you through their testing methods.

First they deploy a container that contains the curl application into the
`prodapps` namespace.

`kubectl run curl --generator=run-pod/v1 --image=radial/busyboxplus:curl -n prodapps -i --tty --rm`{{execute}}

Once the pod has started, you will have a shell from within this curl
container to run tests.

Once you've gotten a terminal session, run the curl command to test connectivity
to the webserver.

`curl webserver`{{execute}}

OK, that worked. Exit out of the container by typing exit in the container's shell.

`exit`

Now, re-deploy that test container into the `default` namespace and exec into it
again. This will place the testing container into a different namespace from the
web server which is in `prodapps`.

`kubectl run curl --generator=run-pod/v1 --image=radial/busyboxplus:curl -i --tty --rm`{{execute}}

Your colleagues show you that if you run the curl command again, it doesn't work.

`curl webserver`{{execute}}

The curl command cannot seem to find the application. You have identified the issue your
co-workers have run into. Services referenced from a different namespace must
pass additional suffixes that include the namespace and cluster name.

You show them how it should be used by running this command:

`curl webserver.prodapps.svc.cluster.local`{{execute}}

Afterwards you teach your co-workers that services accessed from other
namespaces must include a DNS suffix for the service entry:

[Service Name].[Namespace Name].[svc.cluster.local]

Exit the container shell again by typing exit and hitting enter.

`exit`

Armed with this new knowledge you've provided, your colleagues go back to work to build more
apps segmented by namespaces.
