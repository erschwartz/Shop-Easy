var request = require('request');
var database = require('./utils/parseText');
var accessToken;
var options = {
    method: 'POST',
    url: 'https://api.clarifai.com/v1/token/',
    form:{
		'grant_type': "client_credentials",
		'client_id': process.env.CLIENT_ID,
		'client_secret': process.env.CLIENT_SECRET
    }
};

request(options, function(error, response){
	if(error){
		console.log(error);
	}
	else{
		accessToken = JSON.parse(response.body).access_token;
        console.log(response.body);
	}
});

var express = require("express");
var app = express();
var bodyParser = require('body-parser')
app.set('port', (process.env.PORT || 5000));

var server = app.listen(app.get("port"), function () {
    var host = server.address().address;
    var port = server.address().port;

    console.log('Example app listening at http://%s:%s', host, port);
});

var price = function(data){

};

// Configuration

app.use(express.static(__dirname + '/public'));
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}));

// Routes

app.post('/image/tags', function(req, res){
    res.set({
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
    });

    var options={
    	method: 'POST',
    	url: 'https://api.clarifai.com/v1/tag/',
    	headers:{
    		"Authorization": "Bearer " + accessToken 
    	},
    	form: {
    		url: req.body.encoded_data
    	}
    }
    request(options, function(error, response){
		if(error){
			res.status(404).send(error);
		}
		else{

			res.status(200).send(JSON.parse(response.body).results[0].result);
		}
	});
});

app.post('/items', function(req, res){
    res.set({
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
    });

    var options={
        method: 'POST',
        url: 'https://api.clarifai.com/v1/tag/',
        headers:{
            "Authorization": "Bearer " + accessToken 
        },
        form: {
            url: req.body
        }
    }
    request(options, function(error, response){
        if(error){
            res.status(404).send(error);
        }
        else{
            res.status(200).send(response.body);
        }
    });
});
