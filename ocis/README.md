## Disclaimers ✋

These charts are for demonstration purposes and not to be run in any production system as they are. This is still in heavy development.

## Hacks and WIP 🐱‍💻

Configuring the entire OCIS suite with an identity provided has proven tricky with a few catch-22 along the way. For this reason we need a reverse tunnel in order for phoenix to work as well.

### Start a reverse tunnel 🚇

For the reverse tunnel we're using [localtunnel](https://localtunnel.me). To start a reverse tunnel with this charts:

1. Install the Chart
2. Get the public IP of the proxy with `minikube services list`
3. Run `lt --local-https --allow-invalid-cert -p 30682 -l 192.168.64.5`
4. Update the `Values.ingressDomain`  entry on `values.yaml`  and read the comment as per why this can't be done with the `--set` flag.
5. Test that the tunnel is working by testing the webdav API through the proxy:

```console
curl -v -k -u einstein:relativity -H "depth: 0" -X PROPFIND https://stale-wasp-86.loca.lt/remote.php/dav/files/ | xmllint --format -
```

For the purposes of this demo the proxy is running with `PROXY_ENABLE_BASIC_AUTH=true` in order to bypass a certain catch-22 on the idp.