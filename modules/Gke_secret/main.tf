resource "kubectl_manifest" "todo-secret" {
    yaml_body = <<YAML
apiVersion: v1
kind: Secret
data:
  RDS_PASSWORD: ZHVtbXl0b2Rvcw==
metadata:
  name: todo-web-application-secrets
  namespace: default
type: Opaque
# kubectl create secret generic todo-web-application-secrets --from-literal=RDS_PASSWORD=dummytodos
# echo -n dummytodos | base64
YAML
}