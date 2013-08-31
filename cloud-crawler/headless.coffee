Browser = require 'zombie'
browser = new Browser

output = {}
browser.visit process.argv[2], ->
    browser.wait process.argv[3], ->
        output.code = browser.statusCode
        output.redirected = browser.redirected

        if browser.success
            output.body = browser.html()

        console.log(JSON.stringify(output))
        process.exit(1)
