#!/bin/bash
kubectl exec -it nodejs-application-rvig-dep-749c5b9c7f-6d2nd -n ragav -- /bin/bash -c "while true;do curl localhost;done;"

