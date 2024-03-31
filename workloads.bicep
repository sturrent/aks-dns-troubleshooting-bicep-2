@secure()
param kubeConfig string

provider 'kubernetes@1.0.0' with {
  namespace: 'default'
  kubeConfig: kubeConfig
} as k8s

resource appsDeployment_dbCheck 'apps/Deployment@v1' = {
  metadata: {
    name: 'db-check'
    labels: {
      app: 'db-check'
    }
  }
  spec: {
    replicas: 1
    selector: {
      matchLabels: {
        app: 'db-check'
      }
    }
    template: {
      metadata: {
        labels: {
          app: 'db-check'
        }
      }
      spec: {
        containers: [
          {
            name: 'db-check'
            image: 'sturrent/dns-monitor:latest'
          }
        ]
      }
    }
  }
}

resource appsDeployment_workload1 'apps/Deployment@v1' = {
  metadata: {
    name: 'workload1'
    labels: {
      app: 'workload1'
    }
  }
  spec: {
    replicas: 15
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
                memory: '70Mi'
                cpu: '90m'
              }
              limits: {
                memory: '700Mi'
                cpu: '1'
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
    replicas: 15
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
                memory: '70Mi'
                cpu: '90m'
              }
              limits: {
                memory: '700Mi'
                cpu: '1'
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
    replicas: 15
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
                memory: '70Mi'
                cpu: '90m'
              }
              limits: {
                memory: '700Mi'
                cpu: '1'
              }
            }
          }
        ]
      }
    }
  }
}
