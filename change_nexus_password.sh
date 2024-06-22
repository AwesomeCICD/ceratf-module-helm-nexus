NEW_PASSWORD=${1}
TARGET_DOMAIN=${2}
set +e

echo "This should only run when nexus first created, and JVMs dont start quickly. Curl will retry for 3 minutes."

let attempts=0

function post_creds {

      response=$(curl -w "%{http_code}"  -iu admin:"admin123" \
            -XPUT -H 'Content-Type: text/plain' \
            --data "${NEW_PASSWORD}" \
            --connect-timeout 2 \
            --max-time 5 \
            --retry 60 \
            --retry-delay 5 \
            --retry-max-time 300 \
            https://nexus.${TARGET_DOMAIN}/service/rest/v1/security/users/admin/change-password \
            -o response.txt 2>/dev/null)


      if [ "$response" == "503" ]; then
      #       if [ $attempts -gt 4 ]; then 
      #             echo "Gave up after $attempts attempts"
      #             exit 0
      #       fi
            echo "503 in right cycle means we're waiting to start, but may be encountered in other lifecycles. "
            echo "We have waited to start and now give up, assuming we're in one of those intentional corner cases."
           # sleep 30
            #let attempts=attempts+1
            #post_creds
      else
            #nexus admin set, celebrate
            echo "job well done"
      fi
}

post_creds