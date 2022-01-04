//
//  main.swift
//  PerfectTemplate
//
//  Created by Matthias Zarzecki on 13.12.21.
//

import PerfectHTTP
import PerfectHTTPServer

/// Sets the basic URI that is seen without parameters,
/// in this case a html page.
private func addBasicRoute() {
  routes.add(method: .get, uri: "/") { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(
      string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>"
    )
      .completed()
  }
}

/// Sets an html page on a different URI.
private func addSecondScreenRoute() {
  routes.add(method: .get, uri: "/test") { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(
      string: "<html><title>Hello, world 2!</title><body>Hello, world 2!</body></html>"
    )
      .completed()
  }
}

/// Returns JSON data.
private func addJsonRoute() {
  routes.add(method: .get, uri: "/json") { request, response in
    response.setHeader(.contentType, value: "application/json")
    let jsonResponse: [String: Any] = [
      "isServeAlive": true,
      "a": 1,
      "b": 0.1,
      "c": true,
      "d": [2, 4, 5, 7, 8]
    ]

    do {
      try response.setBody(json: jsonResponse)
    } catch {
      print("\(error)")
    }
    response.completed()
  }
}

/// Post Method which takes the data from the URI and
/// adds it together. Cannot be run from browser.
/// Example Call: "http://localhost:8182/add?operandOne=30&operandTwo=23"
private func addPostRoute() {
  routes.add(method: .post, uri: "/add") { request, response in
    response.setHeader(.contentType, value: "application/json")

    // Set basic response payload
    var responsePayload: [String: Any] = ["sum": 0]

    // Get parameters from request, parse them, and calculate them
    if let operandOne = request.param(name: "operandOne"),
       let operandTwo = request.param(name: "operandTwo") {
      if let leftSide = Int(operandOne),
         let rightSide = Int(operandTwo) {
        responsePayload["sum"] = leftSide + rightSide
      }
    }

    do {
      try response.setBody(json: responsePayload)
    } catch {
      print("\(error)")
    }
    response.completed()
  }
}

private func launchServer(on port: Int, with routes: Routes) {
  do {
    try HTTPServer.launch(
      .server(name: "localhost", port: port, routes: routes)
    )
  } catch {
    fatalError("\(error)")
  }
}

var routes = Routes()
addBasicRoute()
addSecondScreenRoute()
addJsonRoute()
addPostRoute()
launchServer(on: 8182, with: routes)
