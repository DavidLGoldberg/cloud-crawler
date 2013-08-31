var page = require('webpage').create();
var args = require('system').args;
var url = args[1];
var code;

page.onResourceReceived = function(resource) {
    code = resource.status;
    //console.log(code);
}

page.onLoadFinished = function(status) {
    console.log(status);
    if (status === 'success')
        console.log('success');
    else
        console.log('fail');
}

page.open(url, function (status) {
    var doc = page.evaluate(function () {
        return document.body.innerHTML;
    });
    //console.log(doc);
    phantom.exit();
});
