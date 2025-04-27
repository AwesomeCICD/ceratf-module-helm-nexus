kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nexus-blob-storage
  namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: ${size}
  storageClassName: "nexus-gp2"