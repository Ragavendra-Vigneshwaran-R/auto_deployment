const express = require('express');
const session=require('express-session');
const flash=require('connect-flash');
var bodyParser = require('body-parser');
const { execFile } = require('child_process');


const app = express();
app.use(session({
    secret:'flashblog',
    saveUninitialized:true,
    resave:true
}));
app.use(flash());

var port=8000;
var urlencodedParser = bodyParser.urlencoded({ extended: false })

         //Home Page
app.get('/', function (req, res) {
    res.sendFile(__dirname+'/Application/dashboard.html');
    
    //res.send("Server is running at "+ port);
});

app.get('/features',(req,res)=>{
    res.sendFile(__dirname+'/Application/features.html');
});


app.get('/deployment_with_HPA',(req,res)=>{
    res.sendFile(__dirname+'/Application/Deplayment_with_HPA.html');
});

app.get('/deployment_with_CLS',(req,res)=>{
    res.sendFile(__dirname+'/Application/deployment_with_CLS.html');
});


app.get('/deployment_with_CICD',(req,res)=>{
    res.sendFile(__dirname+'/Application/deployment_with_CICD.html');
});


app.get('/deployment_with_monitoring',(req,res)=>{
    res.sendFile(__dirname+'/Application/Deployment_with_monitoring.html');
});


app.get('/deployment_with_multifeature',(req,res)=>{
    res.sendFile(__dirname+'/Application/multifeature.html');
});



app.post('/cls', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    console.log(selected_cloud +"--"+ docker_image + " "+ dedicated_cluster+ " "+ namespace);
    setTimeout(()=>{
        res.sendStatus(200);
    },10000)

});


app.post('/keda', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    var min_pod=req.body.minimumpods;
    var max_pod=req.body.maximumpods;
    var metric=req.body.metrics;
      const scriptPath = '../Rest-API/trigger_keda.sh';
      const args = ['--dockerimage', docker_image, '--maxpods', max_pod , '--minpods', min_pod, '--metrics', metric, '--namespace', namespace];
      
      execFile(scriptPath, args, (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          return;
        }
        console.log(`stdout: ${stdout}`);
        console.error(`stderr: ${stderr}`);
      });

      setTimeout(function () {
        res.sendStatus(200);

      }, 10000)

});


app.post('/cicd', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    console.log(selected_cloud +"--"+ docker_image + "--"+ dedicated_cluster+ "--"+ namespace);
     
    const scriptPath = '../Rest-API/trigger_cicd.sh';
      const args = ['--dockerimage', docker_image, '--namespace', namespace];
      
      execFile(scriptPath, args, (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          return;
        }
        console.log(`stdout: ${stdout}`);
        console.error(`stderr: ${stderr}`);
      });

      setTimeout(function () {
        res.sendStatus(200);

      }, 10000)


});


app.post('/monitoring', urlencodedParser, (req, res) => {
    var selected_cloud=req.body.cloudprovider;
    var docker_image=req.body.dockerimage;
    var dedicated_cluster=req.body.Dedicated_cluster;
    var namespace=req.body.namespace;
    console.log(selected_cloud +"--"+ docker_image + "--"+ dedicated_cluster+ "--"+ namespace);
    const scriptPath = '../Rest-API/trigger_monitoring.sh';
    const args = ['--dockerimage', docker_image, '--namespace', namespace];
    
    execFile(scriptPath, args, (error, stdout, stderr) => {
      if (error) {
        console.error(`exec error: ${error}`);
        return;
      }
      console.log(`stdout: ${stdout}`);
      console.error(`stderr: ${stderr}`);
    });

    setTimeout(function () {
      res.sendStatus(200);
    }, 10000)

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
    setTimeout(()=>{
        res.sendStatus(200);
    },10000)

});

app.listen(port,()=>{
    console.log("Server is running @ "+ port);
});