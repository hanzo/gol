/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "YahooModule.h"

@implementation YahooModule


- (NSArray*) moduleDependencies
{
	return [NSArray arrayWithObject:@"network"];
}

- (void) configure
{
	[self bindCode:@"b64_hmac_sha1" code:@"function(k,d,_p,_z){if(!_p){_p='='}if(!_z){_z=8}function _f(t,b,c,d){if(t<20){return(b&c)|((~b)&d)}if(t<40){return b^c^d}if(t<60){return(b&c)|(b&d)|(c&d)}return b^c^d}function _k(t){return(t<20)?1518500249:(t<40)?1859775393:(t<60)?-1894007588:-899497514}function _s(x,y){var l=(x&0xFFFF)+(y&0xFFFF),m=(x>>16)+(y>>16)+(l>>16);return(m<<16)|(l&0xFFFF)}function _r(n,c){return(n<<c)|(n>>>(32-c))}function _c(x,l){x[l>>5]|=0x80<<(24-l%32);x[((l+64>>9)<<4)+15]=l;var w=[80],a=1732584193,b=-271733879,c=-1732584194,d=271733878,e=-1009589776;for(var i=0;i<x.length;i+=16){var o=a,p=b,q=c,r=d,s=e;for(var j=0;j<80;j++){if(j<16){w[j]=x[i+j]}else{w[j]=_r(w[j-3]^w[j-8]^w[j-14]^w[j-16],1)}var t=_s(_s(_r(a,5),_f(j,b,c,d)),_s(_s(e,w[j]),_k(j)));e=d;d=c;c=_r(b,30);b=a;a=t}a=_s(a,o);b=_s(b,p);c=_s(c,q);d=_s(d,r);e=_s(e,s)}return[a,b,c,d,e]}function _b(s){var b=[],m=(1<<_z)-1;for(var i=0;i<s.length*_z;i+=_z){b[i>>5]|=(s.charCodeAt(i/8)&m)<<(32-_z-i%32)}return b}function _h(k,d){var b=_b(k);if(b.length>16){b=_c(b,k.length*_z)}var p=[16],o=[16];for(var i=0;i<16;i++){p[i]=b[i]^0x36363636;o[i]=b[i]^0x5C5C5C5C}var h=_c(p.concat(_b(d)),512+d.length*_z);return _c(o.concat(h),512+160)}function _n(b){var t='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/',s='';for(var i=0;i<b.length*4;i+=3){var r=(((b[i>>2]>>8*(3-i%4))&0xFF)<<16)|(((b[i+1>>2]>>8*(3-(i+1)%4))&0xFF)<<8)|((b[i+2>>2]>>8*(3-(i+2)%4))&0xFF);for(var j=0;j<4;j++){if(i*8+j*6>b.length*32){s+=_p}else{s+=t.charAt((r>>6*(3-j))&0x3F)}}}return s}function _x(k,d){return _n(_h(k,d))}return _x(k,d)};"];
	[self bindCode:@"percentEscape" code:@"function(r){return encodeURIComponent(r).replace(/!/g,'%21').replace(/\\*/g,'%2A').replace(/\\'/g,'%27').replace(/\\(/g,'%28').replace(/\\)/g,'%29')};"];
	[self bindCode:@"oauthRequest" code:@"function(key,secret,apiEndpoint,apiQuery){var encodedQuery=Titanium.Yahoo.percentEscape(apiQuery);var timestamp=Math.floor(new Date().getTime()/1000);var theUrl=apiEndpoint.split('?')[0];var nonce='';for(var i=0;i<10;i++){nonce+=String.fromCharCode(Math.floor(Math.random()*26)+97)}var theHead=apiEndpoint.split('?')[1];var theBody='&oauth_consumer_key='+key;theBody+='&oauth_nonce='+nonce;theBody+='&oauth_signature_method=HMAC-SHA1';theBody+='&oauth_timestamp='+timestamp;theBody+='&oauth_version=1.0';theBody+='&q='+encodedQuery;var theData='GET'+'&'+Titanium.Yahoo.percentEscape(theUrl)+'&'+Titanium.Yahoo.percentEscape(theHead)+Titanium.Yahoo.percentEscape(theBody);var theSig=Titanium.Yahoo.b64_hmac_sha1(secret+'&',theData);return apiEndpoint+theBody+'&oauth_signature='+Titanium.Yahoo.percentEscape(theSig)};"];
	[self bindCode:@"setOAuthParameters" code:@"function(consumerKey,sharedSecret){Titanium.Yahoo._consumerKey=consumerKey;Titanium.Yahoo._sharedSecret=sharedSecret};"];
	[self bindCode:@"yql" code:@"function(apiQuery,callback){var apiEndpoint='http://query.yahooapis.com/v1/yql?format=json';var url=Titanium.Yahoo.oauthRequest(Titanium.Yahoo._consumerKey,Titanium.Yahoo._sharedSecret,apiEndpoint,apiQuery);var xhr=Titanium.Network.createHTTPClient();xhr.onload=function(){callback(eval('('+this.responseText+')').query.results)};xhr.open('GET',url);xhr.send()};"];
}

@end
