NEW_PASSWORD=${1}
REGION=${2}



response=$(curl -w "%{http_code}"  -ifu admin:"admin123" \
      -XPUT -H 'Content-Type: text/plain' \
      --data "${NEW_PASSWORD}" \
      https://nexus.${REGION}.circleci-labs.com/service/rest/v1/security/users/admin/change-password \
      > response.txt)


if [ "$response" == "503" ]; then
      #Nexus not there yet, so we just silently proceed.
      echo "Nothing to do yet"
else
      #nexus admin set, celebrate
      echo "job well done"
fi