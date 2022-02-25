You are a Cloud Engineer responsible for all aspects of Kubernetes at your
company. Developers have adopted the Kubernetes platform for all of their new
applications and have built pipelines to automate the deployment of their code.

During a daily scrum you're told that the new development cluster recently
released to this group is not working correctly. You apologize for the
inconvenience and commit to solving this issue immediately so that the build
processes can return to a normal state.

You start by checking to see if the Kubernetes nodes are healthy.
`kubectl get nodes --request-timeout 5s`{{execute}}

After some time you receive an error message. Either a timeout or a connection refused.

Your first instinct, to check the nodes, has identified a new clue. You can't
access the nodes. After a second, you realize that this means that the
Kubernetes API is not responding to your commands so this is a larger issue than
a single node not being healthy. You change focus to start identifying new clues
related to the API server.

Since the Kubernetes API is unavailable, kubectl commands won't work. You must
rely on some commands from the container runtime instead, in this case it's
Docker. Take a look at the containers on the cluster by running some docker commands.

`docker ps -a`{{execute}}

You notice that some of your containers are exiting which is another clue. Which
one is the problem though? You start with the brains of the Kubernetes
machine. Check the docker logs for the API server container.

Identify the container ID of the Kube-API server by copying it from the 
`docker ps -a`{{execute}} command from above.

Then run 

`docker logs CONTAINERID_GOES_HERE`

We see a bunch of errors like:

`Transport failed to connect to 127.0.0.1:2379`

That is the etcd port number. You believe the API server isn't able to read or
write from etcd. Your focus changes to see whats wrong with the etcd container
which is also in an exited state.

Find the etcd container ID by running

`docker ps -a`{{execute}}

Then look at the etcd container's logs

`docker logs CONTAINERID_GOES_HERE`

The last log written by etcd looks to be the final clue you needed to solve the
issue.

`/etc/kubernetes/pki/etcd/wrongca.crt: no such file or directory`

It appears as though etcd can't find the CA certificate. In the editor, open the
etcd.yaml file in the manifests directory. Update the CA certificate path to
`/etc/kubernetes/pki/etcd/ca.crt`.

Since the etcd container is a static pod, the Kubelet will start the container
soon after the configuration is corrected. Once the etcd container has started
successfully the Kubernetes API should come back up and the following command
will work again.

>Note: This may take a moment. You can re-run the command below as needed until
>the nodes show up.

`kubectl get nodes`{{execute}}