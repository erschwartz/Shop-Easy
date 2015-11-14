var crypto = require("crypto");
var request = require("request");
var date = (new Date()).toISOString();
var config = {
  awsAccessKeyId : "AKIAIC6QW3BQF5FNHHDQ",
  awsSecretKey   : "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",
  awsAssociateTag: "hkharvard-20"
}
var url = 'http://webservices.amazon.com/onca/xml';

function generateHmac (data, awsSecretKey, algorithm, encoding) {
  encoding = encoding || "base64";
  algorithm = algorithm || "sha256";
  return crypto.createHmac(algorithm, awsSecretKey).update("").digest(encoding);
}
console.log(generateHmac('2014-08-18T12%3A00%3A00Z', '1234567890'));
console.log(encodeURIComponent(generateHmac('2014-08-18T12%3A00%3A00Z', '1234567890')));
// Options for the http POST request
var options = {
	url: url,
	method: 'POST',
  	form: {
  		"Service": "AWSECommerceService",
  		"AWSAccessKeyId": config.awsAccessKeyId,
  		"AssociateTag": config.awsAssociateTag,
  		"Operation": "ItemSearch",
  		"Keywords": "Rocket",
  		"SearchIndex": "Toys",
  		"Timestamp": date,
  		"Signature": encodeURIComponent(generateHmac(date, config.awsSecretKey))
  	}
};

request(options, function (error, response) {
	if(error){
		console.log(error);
	}
	else{
		console.log(response.body);
	}
});