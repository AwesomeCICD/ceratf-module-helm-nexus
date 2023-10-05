NEW_PASSWORD=${1}
REGION=${2}
set +e


response=$(curl -w "%{http_code}"  -ifu admin:"admin123" \
      -XPUT -H 'Content-Type: text/plain' \
      --data "${NEW_PASSWORD}" \
      https://nexus.${REGION}.circleci-labs.com/service/rest/v1/security/users/admin/change-password \
      -o response.txt 2>/dev/null)


if [ "$response" == "503" ]; then
      #Nexus not there yet, so we just silently proceed.
      echo "Nothing to do yet"
else
      #nexus admin set, celebrate
      echo "job well done"
fi