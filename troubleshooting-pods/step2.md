Someone in your organization has come to you for help. They are new to
Kubernetes and are having trouble deploying a container. You offer your help and
begin troubleshooting for your co-worker. 

First, re-deploy the container from the
Kubernetes manifest they provided to us named, `kuard.yaml. Deploy the container.

`kubectl apply -f kuard.yaml`{{execute}}

Now check the status of the container.

`kubectl get pods`{{execute}} This will list the pods in the default namespace.

You should see that the pod is in an error state and the STATUS likely shows
`ImagePullBackOff` or `ErrImagePull`. This is a good clue as to the scope of the issue.

To gather some more information, run a describe command on that pod.
`kubectl describe pod kuard`{{execute}}

From the output of the command, you'll see a message stating that it 
`Failed to pull image` and that the image was not found.

Now that you've identified the issue it's time fo fix it. Delete the failed pod.
`kubectl delete pod kuard`{{execute}}

Modify the Kubernetes manifest used to deploy this pod. The file is named `kuard.yaml` and can be found in your editor.

Replace the image entry `gcr.io/kuar-demo/kuard-amd64` with
`gcr.io/kuar-demo/kuard-amd64:blue` and save the file.

>Note: YAML formatting is VERY specific. Be sure not to indent or space the
>addition. If you need help, look at the `kuard-1-answer.yaml` file for the
>correct result.

Deploy the new pod with the corrected image by running:
`kubectl apply -f kuard.yaml`{{execute}}

Run `kubectl get pods`{{execute}} again and see if the pod starts up. It might
take a few seconds for the container image to load, so you can run this command
multiple times.