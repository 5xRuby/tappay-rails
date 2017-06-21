(function(){var e,t,n,i,o,s,r,p,c,l,u,d,h,m,y={}.hasOwnProperty;if(o="https://js.tappaysdk.com",s="https://js.tappaysdk.com",r=!!/tappayapis\.com$/.test("undefined"!=typeof window&&null!==window?window.location.host:void 0),c=document.querySelectorAll('script[src^="'+o+'"]'),c.length<=0){return console.warn("[TapPay] It looks like TPDirect.js is not being loaded from https://js.tappaysdk.com.")}if("withCredentials"in new XMLHttpRequest){l=true}else if(window.XDomainRequest){l=true}else{l=false;return console.warn("[TapPay] It looks like browser not support cors.")}if(this.TPDirect){this.TPDirect.isDoubleLoaded=true;return console.warn("[TapPay] It looks like TPDirect.js was loaded more than one time.")}this.TPDirect=function(t){return d=window.location.hostname,h=window.location.origin,m=window.location.port,y=window.location.protocol,t={},t.version=1,t.isDoubleLoaded=false,t.setPublishableKey=function(e,n,a){t.appID=e;t.appKey=n;t.endPoint=a=="production"?"https://prod.tappayapis.com":"https://sandbox.tappayapis.com"},t.setupSDK=function(e,n,a){t.appID=e;t.appKey=n;t.endPoint=a=="production"?"https://prod.tappayapis.com":"https://sandbox.tappayapis.com"},e=t}(e);this.TPDirect.card=function(e,n){return n={},n.createToken=function(t,n,a,i,o){if(!e.validate.cardNumber(t)){return o({card:{},clientip:"",msg:"Wrong Card Format",status:41})}if(!e.validate.expiry(n,a)){return o({card:{},clientip:"",msg:"Expired Card",status:2013})}if(!e.validate.ccv(i)){return o({card:{},clientip:"",msg:"Wrong Card Format",status:41})}if(!e.validate.sdkError()){return o({card:{},clientip:"",msg:"SDK Loading Error",status:-1})}var s={appid:e.appID,appkey:e.appKey,appname:d,cardnumber:t,cardduedate:"20"+a+n,cardccv:i,url:h,port:m,protocol:y};var r="jsonString="+JSON.stringify(s);getPrimeRequest(r).then(function(e){if(e.status!=0){return o(e)}o({status:e.status,msg:e.msg,card:{prime:e.card.prime,issuer:e.cardinfo.issuer,lastfour:e.cardinfo.lastfour,bincode:e.cardinfo.bincode,funding:e.cardinfo.funding,type:e.cardinfo.type},clientip:e.clientip})})},t=n}(e,t);this.TPDirect.consumer=function(){this.requiredShippingContactFields={};this.requiredBillingContactFields={};this.shippingContact=null;this.billingContact=null};this.TPDirect.merchant=function(){this.merchantCapabilities=["supports3DS"];this.acquirerMerchantID="";this.applePayMerchantIdentifier="";this.countryCode="TW";this.currencyCode="TWD";this.supportedNetworks=["amex","discover","masterCard","visa"];this.shippingMethods=null;this.merchantName=""};this.TPDirect.cart=function(){this.shippingType="shipping";this.paymentItems=[]};this.TPDirect.applePay=function(t,a){a={};a.nowShippingMethod=null;a.sessionCallback={};a.paymentRequest=null;a.merchant={};a.consumer={};a.cart={};a.getSessionEndpoint=o;a.applePayMerchantID="";a.checkAvailability=function(){if(!window.ApplePaySession){console.warn("[TapPay] Your Browser Did Not Support Apple Pay");return false}if(!ApplePaySession.canMakePayments){console.warn("[TapPay] User Can Not Use Apple Pay");return false}if(location.protocol!="https:"){console.warn("[TapPay] Trying to call an ApplePaySession API from an insecure document.");return false}return true};a.buildSession=function(t,n){if(location.protocol!="https:"){return console.warn("[TapPay] Trying to call an ApplePaySession API from an insecure document.")}a.applePayMerchantID=n||"";a.session=new ApplePaySession(1,t);a.session.onvalidatemerchant=function(t){const n=t.validationURL;var i="appId="+e.appID+"&"+"appKey="+e.appKey+"&"+"appName="+d+"&"+"appleMerchantId="+a.applePayMerchantID+"&"+"merchant_domain="+d+"&"+"validationURL="+n+"&"+"tappay_endpoint="+e.endPoint;a.getApplePaySession(i).then(function(e){a.session.completeMerchantValidation(e)})};return a.session};a.setupPayment=function(e,t,n){if(e==null&&t==null&&n==null){return console.warn("[TapPay] TPDirect.applePay.setupPayment(merchant, consumer, cart), Lost Parameter")}a.merchant=e;a.consumer=t;a.cart=n;a.paymentRequest=a.preparePaymentRequest();if(a.merchant.shippingMethods!=null&&a.merchant.shippingMethods.length>0){a.nowShippingMethod=a.merchant.shippingMethods[0]}return a};a.startPayment=function(){if(location.protocol!="https:"){if(a.sessionCallback.onFailure){a.sessionCallback.onFailure(-1,"Trying to call an ApplePaySession API from an insecure document")}return console.warn("[TapPay] Trying to call an ApplePaySession API from an insecure document.")}a.session=new ApplePaySession(1,a.paymentRequest);a.session.onvalidatemerchant=function(e){if(a.sessionCallback.onValidateMerchant==null){return console.warn("[TapPay] You Need To Implement 'TPDirect.applePay.onValidateMerchant' For Validate Merchant And Use Url To Send Apple Pay Session By Your Server.")}a.sessionCallback.onValidateMerchant(e)};a.session.onpaymentauthorized=function(e){if(a.sessionCallback.onPaymentAuthorized==null){return console.warn("[TapPay] You Need To Implement 'TPDirect.applePay.onPaymentAuthorized' Get Payment Data, Shipping Contact And Send Payment Data To TapPay Server Finished Payment")}a.sessionCallback.onPaymentAuthorized(e)};a.session.onshippingmethodselected=function(e){if(a.merchant.shippingMethods.length>0){a.nowShippingMethod=e.shippingMethod}if(a.merchant.shippingMethods!=null&&a.merchant.shippingMethods.length>0&&a.sessionCallback.onShippingMethodSelected==null){console.log("[TapPay] You Can Implement 'TPDirect.applePay.onShippingMethodSelected' And Listen User Select Shipping Method Behavior");return a.completeShippingMethodSelection(ApplePaySession.STATUS_SUCCESS,a.cart)}a.sessionCallback.onShippingMethodSelected(e)};a.session.onshippingcontactselected=function(e){if(a.sessionCallback.onShippingContactSelected==null){console.log("[TapPay] You Can Implement 'TPDirect.applePay.onShippingContactSelected' And Listen User Select Shipping Contact Behavior");return a.completeShippingContactSelection(ApplePaySession.STATUS_SUCCESS,a.nowShippingMethod,a.cart)}a.sessionCallback.onShippingContactSelected(e)};a.session.onpaymentmethodselected=function(e){if(a.sessionCallback.onPaymentMethodSelected==null){console.log("[TapPay] You Can Implement 'TPDirect.applePay.onPaymentMethodSelected' And Linsten User Select PaymentMethod Behavior");return a.completePaymentMethodSelection(a.cart)}a.sessionCallback.onPaymentMethodSelected(e)};a.session.oncancel=function(e){if(a.sessionCallback.onCancel==null){return console.log("[TapPay] You Can Implement 'TPDirect.applePay.onCancel' And Listen User Cancel Behavior")}a.sessionCallback.onCancel(e)};a.session.begin()};a.getApplePaySession=function(t){return new Promise(function(i,o){var s=new XMLHttpRequest;s.addEventListener("load",function(e){if(this.status>=200&&this.status<300){i(JSON.parse(s.response))}else{o({status:this.status,statusText:s.statusText})}},false);s.addEventListener("error",function(e){o({status:this.status,statusText:s.statusText})},false);s.addEventListener("abort",function(e){o({status:this.status,statusText:s.statusText})},false);s.open("POST",a.getSessionEndpoint+n.getApplePaySaeesion,true);s.setRequestHeader("x-api-key",e.appKey);s.setRequestHeader("Content-Type","application/x-www-form-urlencoded");s.send(t)})};a.onValidateMerchant=function(e){a.sessionCallback.onValidateMerchant=e;return a};a.onPaymentAuthorized=function(e){a.sessionCallback.onPaymentAuthorized=e;return a};a.onShippingMethodSelected=function(e){a.sessionCallback.onShippingMethodSelected=e;return a};a.onShippingContactSelected=function(e){a.sessionCallback.onShippingContactSelected=e;return a};a.onPaymentMethodSelected=function(e){a.sessionCallback.onPaymentMethodSelected=e;return a};a.onFailure=function(e){a.sessionCallback.onFailure=callback;return a};a.onCancel=function(e){a.sessionCallback.onCancel=e;return a};a.completePayment=function(e){a.session.completePayment(e)};a.completePaymentMethodSelection=function(e){a.cart=e||a.cart;var t=a.preparePaymentItems(a.cart.paymentItems,a.nowShippingMethod);a.session.completePaymentMethodSelection(t.total,t.lineItems)};a.completeShippingContactSelection=function(e,t,n){if(e==ApplePaySession.STATUS_SUCCESS){a.cart=n||a.cart;a.nowShippingMethod=t||a.nowShippingMethod}var i=a.preparePaymentItems(a.cart.paymentItems,a.nowShippingMethod);a.session.completeShippingContactSelection(e,a.nowShippingMethod,i.total,i.lineItems)};a.completeShippingMethodSelection=function(e,t){if(e==ApplePaySession.STATUS_SUCCESS){a.cart=t||a.cart}var n=a.preparePaymentItems(a.cart.paymentItems,a.nowShippingMethod);a.session.completeShippingMethodSelection(e,n.total,n.lineItems)};a.completeMerchantValidation=function(e){a.session.completeMerchantValidation(e)};a.preparePaymentRequest=function(){var e=a.preparePaymentItems(a.cart.paymentItems,a.nowShippingMethod);var t={};t.countryCode=a.merchant.countryCode||"TW";t.currencyCode=a.merchant.currencyCode||"TWD";t.shippingMethods=a.merchant.shippingMethods;t.lineItems=e.lineItems;t.total=e.total;t.supportedNetworks=a.merchant.supportedNetworks;t.merchantCapabilities=a.merchant.merchantCapabilities;t.requiredShippingContactFields=a.consumer.requiredShippingContactFields;t.requiredBillingContactFields=a.consumer.requiredBillingContactFields;if(a.consumer.billingContact!=null){t.billingContact=a.consumer.billingContact}if(a.consumer.shippingContact!=null){t.shippingContact=a.consumer.shippingContact}return t};a.preparePaymentItems=function(e,t){var n=0;var i=[];for(var o=0;o<e.length;o++){var s=e[o];i.push(s);n+=parseInt(s.amount)}if(a.nowShippingMethod!=null&&a.nowShippingMethod.amount!=null){var r={label:"Shipping",amount:a.nowShippingMethod.amount};i.push(r);n+=parseInt(r.amount)}return{lineItems:i,total:{label:a.merchant.merchantName,amount:n+""}}};return a}(e,i);this.TPDirect.validate=function(){return{cardNumber:function(e){return e=(e+"").replace(/\s+|-/g,""),e.length>=10&&e.length<=16&&this.luhnCheck(e)},ccv:function(e){return/^\d+$/.test(e)&&e.length>=3&&e.length<=4},expiry:function(e,t){var n,a,i=e;i+="",t+="";return!!/^\d+$/.test(i)&&(!!/^\d+$/.test(t)&&(1<=i&&i<=12&&(2===t.length&&(t=t<70?"20"+t:"19"+t),4===t.length&&(a=new Date(t,i),n=new Date,a.setMonth(a.getMonth()-1),a.setMonth(a.getMonth()+1,1),a>n))))},luhnCheck:function(e){var t,n,a,i,o,s;for(a=!0,i=0,n=(e+"").split("").reverse(),o=0,s=n.length;o<s;o++)t=n[o],t=parseInt(t,10),(a=!a)&&(t*=2),t>9&&(t-=9),i+=t;return i%10===0},cardTypes:function(e){var t,n={},i,o;for(t=o=50;o<=59;t=++o){n[t]="MasterCard"}for(a=i=40;i<=49;t=++i){n[t]="Visa"}return n[34]=n[37]="American Express",n[60]=n[62]=n[64]=n[65]="Discover",n[35]="JCB",n[30]=n[36]=n[38]=n[39]="Diners Club",n}(),cardType:function(e){e+="";return this.cardTypes[e.slice(0,2)]||"Unknown"},sdkError:function(){return!TPDirect.isDoubleLoaded&&c.length>0&&l}}}();this.api=function(e){return e={},e.getPrime="/tpc/directpay/getprime",e.getApplePaySaeesion="/apple-pay/get-session",n=e}(n);this.getPrimeRequest=function(t){return new Promise(function(a,i){var o=new XMLHttpRequest;o.addEventListener("load",function(e){if(this.status>=200&&this.status<300){a(JSON.parse(o.response))}else{a({card:{},clientip:"",msg:e,status:-3})}},false);o.addEventListener("error",function(e){a({card:{},clientip:"",msg:e,status:-3})},false);o.addEventListener("abort",function(e){a({card:{},clientip:"",msg:e,status:-3})},false);o.open("POST",e.endPoint+n.getPrime,true);o.setRequestHeader("x-api-key",e.appKey);o.setRequestHeader("Content-type","application/x-www-form-urlencoded");o.send(t)})}})();