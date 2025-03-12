# Steps to Reproduce the Velero issues: 
1. Use the Helmfile to install the requirements with `helmfile sync`
2. Generate an access key from minio and put it in the s3-cred file.
3. Create the secret to access s3:
   ```
   kubectl create secret generic s3-credentials-secret-aws --from-literal cloud="$(cat s3-cred)" -n velero
   ```
4. Create a backup of the `ocis` namespace by running:
   ```
   velero backup create ocis-backup-test --include-namespaces=ocis
   ```
5. Verify that the backup state is completed:
   ```
   velero backup describe ocis-backup-test
   ```
6. Create a restore from that backup to a new namespace:
   ```
   velero restore create --from-backup=ocis-backup-test --namespace-mappings ocis:restored-ocis
   ```
7. Verify the restore is completed:
   ```
   velero restore get
   velero restore describe <restore_name>
   velero restore logs <restore_name>
   ```
8. Verify the downloadrequest, it should be the newest one after running the restore describe/logs: 
   ```
   k get downloadrequest -n velero
   k describe downloadrequest <download_request_name> -n velero
   ```
9. Switch the BcakupStorageLocation bucket, in this case as the credentials are the same, a `kubectl edit` and changing the bucket name is enough.
10. Verify the downloadrequest again.
