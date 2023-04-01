const express = require('express');
var bodyParser = require('body-parser')


const app = express();
var port=8000
var urlencodedParser = bodyParser.urlencoded({ extended: false })


app.get('/', function (req, res) {
res.send("Server is running at "+ port);
});

app.get('/r',(req,res)=>{
    res.send("ok");
});

app.post('/cls', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    console.log(selected_cloud +"--"+ docker_image + " "+ dedicated_cluster+ " "+ namespace);
    res.sendStatus(200);

});


app.post('/keda', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    var min_pod=req.body.minimumpods;
    var max_pod=req.body.maximumpods;
    var metric=req.body.metrics;
    console.log(selected_cloud +"--"+ docker_image + "--"+ dedicated_cluster+ "--"+ namespace+ "--"+ min_pod+ "--"+ max_pod +"--"+ metric);
    res.sendStatus(200);

});


app.post('/cicd', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    console.log(selected_cloud +"--"+ docker_image + "--"+ dedicated_cluster+ "--"+ namespace);
    res.sendStatus(200);

});


app.post('/monitoring', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    console.log(selected_cloud +"--"+ docker_image + "--"+ dedicated_cluster+ "--"+ namespace);
    res.sendStatus(200);

});



app.post('/multi-feature', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var keda=req.body.KEDA;
    var min_pod=req.body.minimumpods;
    var max_pod=req.body.maximumpods;
    var cicd=req.body.CICD;
    var cicd_namespace=req.body.CICD_namespace;
    var cls=req.body.CLS;
    var cls_namespace=req.body.CLS_namespace;
    var monitoring=req.body.monitoring;
    var monitoring_namespace=req.body.monitoring_namespace;
    //console.log(req.body);
    console.log(selected_cloud +"--"+ docker_image + "--"+ dedicated_cluster+ "--"+min_pod+"--"+ max_pod+"--"+keda+"--"+cicd+"--"+cicd_namespace+"--"+cls+"--"+cls_namespace+"--"+monitoring+"--"+monitoring_namespace);
    res.sendStatus(200);

});-

app.listen(port,()=>{
    console.log("Server is running @ "+ port);
});