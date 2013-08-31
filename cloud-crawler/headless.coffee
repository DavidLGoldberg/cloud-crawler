Browser = require 'zombie'
browser = new Browser

browser.visit process.argv[2], ->
    console.log (browser.statusCode)
    console.log(browser.redirected)

    if browser.success
        browser.wait(process.argv[3], ->
            console.log(browser.html())
            process.exit(1)
        )

