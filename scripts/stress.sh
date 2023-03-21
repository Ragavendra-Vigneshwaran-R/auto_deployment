#!/bin/bash
kubectl exec -it nodejs-application-rvig-dep-589d694498-rxtlh -n ragav -- /bin/bash -c "while true;do curl localhost;done;"

