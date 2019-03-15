## read damper
## Update the id for your point
curl -X "POST" "http://localhost/api/read" \
     -H 'Accept: application/json' \
     -H 'Content-Type: text/zinc' \
     -d $'ver:"2.0" 
filter,limit 
"id==@f8f9ae2d-772a-4464-9bec-8c1e3fb4b488",1000
'
