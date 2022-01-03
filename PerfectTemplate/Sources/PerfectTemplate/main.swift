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

routes.add(method: .get, uri: "/") { request, response in
  response.setHeader(.contentType, value: "text/html")
  response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    .completed()
}

routes.add(method: .get, uri: "/test") { request, response in
  response.setHeader(.contentType, value: "text/html")
  response.appendBody(string: "<html><title>Hello, world 2!</title><body>Hello, world 2!</body></html>")
    .completed()
}

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




// Launch the HTTP server.
do {
  try HTTPServer.launch(
    .server(name: "localhost", port: 8182, routes: routes)
  )
} catch {
  fatalError("\(error)") // fatal error launching one of the servers
}
