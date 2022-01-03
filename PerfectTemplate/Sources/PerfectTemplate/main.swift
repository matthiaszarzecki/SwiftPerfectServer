//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer

// Register your own routes and handlers
var routes = Routes()

/// Sets the basic URI that is seen without parameters,
/// in this case a html page.
routes.add(method: .get, uri: "/") { request, response in
  response.setHeader(.contentType, value: "text/html")
  response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    .completed()
}

/// Sets an html page on a different URI.
routes.add(method: .get, uri: "/test") { request, response in
  response.setHeader(.contentType, value: "text/html")
  response.appendBody(string: "<html><title>Hello, world 2!</title><body>Hello, world 2!</body></html>")
    .completed()
}

/// Returns JSON data.
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
  }
  response.completed()
}

/// Post Method which takes the data from the URI and
/// adds it together. Cannot be run from browser.
/// Example Call: "http://localhost:8182/add?operandOne=30&operandTwo=23"
routes.add(method: .post, uri: "/add") { request, response in
  response.setHeader(.contentType, value: "application/json")

  var responsePayload: [String: Any] = ["sum": 0]
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
  }
  response.completed()
}

// Launch the HTTP server.
do {
  try HTTPServer.launch(
    .server(name: "localhost", port: 8182, routes: routes)
  )
} catch {
  fatalError("\(error)") // fatal error launching one of the servers
}
