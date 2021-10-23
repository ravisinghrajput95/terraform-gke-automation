resource "kubectl_manifest" "db_deployment" {
    yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    io.kompose.service: mysql
  name: mysql
spec:
  selector:
    matchLabels:
      io.kompose.service: mysql
  replicas: 1
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        io.kompose.service: mysql
    spec:
      containers:
      - env:
        - name: MYSQL_DATABASE
          value: todos
        - name: MYSQL_PASSWORD
          value: dummytodos
        - name: MYSQL_ROOT_PASSWORD
          value: dummypassword
        - name: MYSQL_USER
          value: todos-user
        image: mysql:5.7
        args:
          - "--ignore-db-dir=lost+found" #CHANGE
        name: mysql
        ports:
        - containerPort: 3306
        volumeMounts:
        - mountPath: /var/lib/mysql
          name: mysql-database-data-volume
      restartPolicy: Always
      volumes:
      - name: mysql-database-data-volume
        persistentVolumeClaim:
          claimName: mysql-database-data-volume
YAML
}

resource "kubectl_manifest" "app_deployment" {
    yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    io.kompose.service: todo-web-application
  name: todo-web-application
spec:
  selector:
    matchLabels:
      io.kompose.service: todo-web-application
  replicas: 1
  template:
    metadata:
      labels:
        io.kompose.service: todo-web-application
    spec:
      containers:
      - env:
        - name: RDS_DB_NAME
#          value: todos
          valueFrom:
            configMapKeyRef:
              key: RDS_DB_NAME
              name: todo-web-application-config
        - name: RDS_HOSTNAME
          valueFrom:
            configMapKeyRef:
              key: RDS_HOSTNAME
              name: todo-web-application-config
        - name: RDS_PASSWORD
          valueFrom:
            secretKeyRef:
              key: RDS_PASSWORD
              name: todo-web-application-secrets
        - name: RDS_PORT
          valueFrom:
            configMapKeyRef:
              key: RDS_PORT
              name: todo-web-application-config
        - name: RDS_USERNAME
          valueFrom:
            configMapKeyRef:
              key: RDS_USERNAME
              name: todo-web-application-config
        image: rajputmarch2020/todo-web-application-mysql:0.0.1-SNAPSHOT
        name: todo-web-application
        ports:
        - containerPort: 8080
      restartPolicy: Always
YAML
}