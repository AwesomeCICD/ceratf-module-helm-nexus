NEW_PASSWORD=${1}
REGION=${2}

curl -ifu admin:"admin123" \
      -XPUT -H 'Content-Type: text/plain' \
      --data "${NEW_PASSWORD}" \
      https://nexus.${REGION}.circleci-labs.com/service/rest/v1/security/users/admin/change-password