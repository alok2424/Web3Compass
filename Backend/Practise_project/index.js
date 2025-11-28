const express = require('express');
const app = express();
const path = require('path');
const fs = require('fs');

app.set("view engine","ejs");
app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.use(express.static(path.join(__dirname,"public")));

/*
app.get('/',function(req,res){
    res.render("index");//index:name of ejs page//render is used as we using view engine
 
})
*/

app.get('/',function(req,res){
    fs.readdir(`./files`,function(err,files){
        res.render("index",{files:files});//index:name of ejs page//render is used as we using view engine
    })
})

app.get('/file/:filename',function(req,res){
    //utf-8 is basically reponsible for converting the buffer data into readable english form and then passes to callback middleware
    fs.readFile(`./files/${req.params.filename}`,"utf-8", function(err,filedata){
       res.render('show',{filename: req.params.filename, filedata: filedata});
    })
})
//method: get or post depends upon declared in frontend
//action: route will also be declared in frontend
// method('/action')
app.post('/create',function(req,res){
    fs.writeFile(`./files/${req.body.title.split(' ').join('')}.txt`,req.body.details(),function(err){
        res.redirect("/");
    })
})
app.listen(3000);