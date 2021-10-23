resource "kubectl_manifest" "todo-db-service" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  annotations:
    kompose.cmd: kompose convert
    kompose.version: 1.19.0 ()
  creationTimestamp: null
  labels:
    io.kompose.service: mysql
  name: mysql
spec:
  type: ClusterIP
  ports:
  - name: "3306"
    port: 3306
    targetPort: 3306
  selector:
    io.kompose.service: mysql
YAML
}

resource "kubectl_manifest" "todo-app-service" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    io.kompose.service: todo-web-application
  name: todo-web-application
spec:
  type: LoadBalancer
  ports:
  - name: "8080"
    port: 8080
    targetPort: 8080
  selector:
    io.kompose.service: todo-web-application
YAML
}