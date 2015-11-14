var crypto = require("crypto");
var d = new Date();
var rfc2104Hmac = generateHmac(d.toUTCString(), "awsSecretKey value");
 
console.log(rfc2104Hmac);

var request = require("request");
var d = new Date().toUTCString();
var config = {
  awsAccessKeyId : "AKIAIC6QW3BQF5FNHHDQ",
  awsSecretKey   : "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",
  awsAssociateTag: "hkharvard-20"
}

var url = 'http://webservices.amazon.com/onca/xml';

/**
 * Get the signature/digest of a supplied input string
 * @param data [Required] The String to encode
 * @param awsSecretKey [Required] Secret key shared with Amazon
 * @param algorithm [Optional] Encryption algorithm, defaults to sha256
 * @param encoding [Optional] The output encoding. Default to base64
 * @returns Str with encoded digest of the input string
 */
function generateHmac (data, awsSecretKey, algorithm, encoding) {
  encoding = encoding || "base64";
  algorithm = algorithm || "sha256";
  return crypto.createHmac(algorithm, awsSecretKey).update(data).digest(encoding);
}


Service=AWSECommerceService&
AWSAccessKeyId=[AWS Access Key ID]&
AssociateTag=[Associate ID]&  
Operation=ItemSearch&
Keywords=Rocket&
SearchIndex=Toys
&Timestamp=[YYYY-MM-DDThh:mm:ssZ]
&Signature=[Request Signature]

// Options for the http POST request
var options = {
	url: url,
	method: 'GET',
  	form: {
  		"Service": "AWSECommerceService",
  		"AWSAccessKeyId": config.awsAccessKeyId,
  		"AssociateTag": config.awsAssociateTag,
  		"Operation": "ItemLookup",
  		"ItemId": 0679722769,
  		"ResponseGroup": "ItemAttributes,Offers,Images,Reviews",
  		"Version": "2013-08-01"
  	}
};

request(options, function (error, response, body) {
		console.log(response.statusCode, body);
	}
);