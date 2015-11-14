var fs = require('fs');

var getNames = function(callback){
	fs.readFile('./db.text', 'utf8', function (err, data) {
		if (err) {
			return console.log(err);
	  	}
	  	else{
			var names = data.split('\n');
			var list = [];
			for(var i = 0; i < names.length; i++){
				list.push(names[i].split(',')[0]);
			}
			callback(list);
	  	}
	});
};
var getPrices = function(callback){
	fs.readFile('./db.text', 'utf8', function (err, data) {
		if (err) {
			return console.log(err);
	  	}
	  	else{
			var names = data.split('\n');
			var list = [];
			for(var i = 0; i < names.length; i++){
				list.push(names[i].split(',')[1]);
			}
			callback(list);
	  	}
	});
};
var getImages = function(callback){
	fs.readFile('./db.text', 'utf8', function (err, data) {
		if (err) {
			return console.log(err);
	  	}
	  	else{
			var names = data.split('\n');
			var list = [];
			for(var i = 0; i < names.length; i++){
				list.push(names[i].split(',')[2]);
			}
			callback(list);
	  	}
	});
};
var getTags = function(callback){
	fs.readFile('./db.text', 'utf8', function (err, data) {
		if (err) {
			return console.log(err);
	  	}
	  	else{
			var names = data.split('\n');
			var list = [];
			for(var i = 0; i < names.length; i++){
				list.push(names[i].split(',')[3]);
			}
			callback(list);
	  	}
	});
};

module.export = {
	names: getNames,
	prices: getPrices,
	images: getImages,
	tags: getTags
}