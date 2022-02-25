Good Kubernetes experts are hard to find and in high demand so you've been busy
answering phone calls from recruiters trying to get you to join their team. You
need a break from all of job interests and ask a colleague what they're up to.
They casually ask for help with a Kubernetes cluster that isn't working and you
offer your expert level of assistance.

You start with a simple command to see if the nodes are up and running and that
the API server is responding.

`kubectl get nodes`{{execute}}

You got a connection refused error meaning that you can't communicate with the
Kubernetes API. This clue tells you that there is a cluster wide problem and you
start looking for more information about why you can't talk to the API server.

Since you can't run `kubectl` without the Kubernetes API, you fall back to
running commands for your container runtime interface (CRI) which in this case
is Docker.

`docker ps`{{execute}}

Well that's interesting. There is no kube-apiserver running on the control plane
node. It's no wonder that you can't issue `kubectl` commands successfully. It is
suspicious though, that other container are running successfully. You set your
sights on fixing the api-server.

You know that the control plane components are static pods so your next step is
to make sure the kube-apiserver has a valid yaml file in the default location of
`/etc/kubernetes/manifests/` In the editor, make sure you review the
kube-apiserver.yaml file that defines the container.

Well, the yaml file looks fine to you, so why didn't the kubelet on the control
plane node, start the container? Maybe the kubelet will have more information.

`systemctl status kubelet`{{execute}}

OK, now that is a problem. The kubelet service is not running on the host. You
assume that there was an issue on the host and the service and containers were
both stopped somehow. Since the other containers are still running you deduce
that those containers were never stopped after the kubelet service was stopped.
If you're right, the command below will start the API server container and
shortly thereafter you'll be able to run `kubectl` commands again.

Press `CTRL+C` in the terminal to quit the previous command and then start the
kubelet.

`systemctl start kubelet`{{execute}}

After a moment or two you can run a sample kubectl command.

`kubectl get nodes`{{execute}}

You've saved the day again. You've earned yourself a quick coffee break before
reviewing more job offers.