apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: ${circleci_region}-istio-gateway-nexus
  namespace: ${ingress_namespace}
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
  - port:
       name: http
       number: 80
       protocol: HTTP
    tls:
       httpsRedirect: true
    hosts:
    - "*.nexus.${target_domain}" # all nexus domains
  - port:
      number: 443
      name: https
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: "cert-nexus"
    hosts:
    - "*.nexus.${target_domain}" # all nexus domains