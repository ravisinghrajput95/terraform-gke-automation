resource "kubectl_manifest" "todo-PVclaim" {
    yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  labels:
    io.kompose.service: mysql-database-data-volume
  name: mysql-database-data-volume
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 100Mi
status: {}
YAML
}