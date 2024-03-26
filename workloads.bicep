@secure()
param kubeConfig string

provider kubernetes with {
  namespace: 'default'
  kubeConfig: kubeConfig
}

resource appsDeployment_workload1 'apps/Deployment@v1' = {
  metadata: {
    name: 'workload1'
    labels: {
      app: 'workload1'
    }
  }
  spec: {
    replicas: 11
    selector: {
      matchLabels: {
        app: 'workload1'
      }
    }
    template: {
      metadata: {
        labels: {
          app: 'workload1'
        }
      }
      spec: {
        containers: [
          {
            name: 'workload1'
            image: 'sturrent/dns-perf-test-loop:latest'
            resources: {
              requests: {
                memory: '10Mi'
                cpu: '90m'
              }
              limits: {
                memory: '500Mi'
                cpu: '900m'
              }
            }
          }
        ]
      }
    }
  }
}

resource appsDeployment_workload2 'apps/Deployment@v1' = {
  metadata: {
    name: 'workload2'
    labels: {
      app: 'workload2'
    }
  }
  spec: {
    replicas: 11
    selector: {
      matchLabels: {
        app: 'workload2'
      }
    }
    template: {
      metadata: {
        labels: {
          app: 'workload2'
        }
      }
      spec: {
        containers: [
          {
            name: 'workload2'
            image: 'sturrent/dns-perf-test-loop:latest'
            resources: {
              requests: {
                memory: '10Mi'
                cpu: '90m'
              }
              limits: {
                memory: '500Mi'
                cpu: '900m'
              }
            }
          }
        ]
      }
    }
  }
}

resource appsDeployment_workload3 'apps/Deployment@v1' = {
  metadata: {
    name: 'workload3'
    labels: {
      app: 'workload3'
    }
  }
  spec: {
    replicas: 11
    selector: {
      matchLabels: {
        app: 'workload3'
      }
    }
    template: {
      metadata: {
        labels: {
          app: 'workload3'
        }
      }
      spec: {
        containers: [
          {
            name: 'workload3'
            image: 'sturrent/dns-perf-test-loop:latest'
            resources: {
              requests: {
                memory: '10Mi'
                cpu: '90m'
              }
              limits: {
                memory: '500Mi'
                cpu: '900m'
              }
            }
          }
        ]
      }
    }
  }
}