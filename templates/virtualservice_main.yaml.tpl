
kind: VirtualService
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: nexus-virtual-service
  namespace: ${namespace}
spec:
  hosts:
    - "nexus.${target_domain}"
  gateways:
    - istio-ingress/${circleci_region}-istio-gateway-subdomains
  http:
  - route:
    - destination:
        host: nxrm-nexus-repository-manager.nexus.svc.cluster.local #prod namespace
        port:
          number: 8081