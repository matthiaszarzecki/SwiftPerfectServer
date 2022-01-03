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
routes.add(method: .get, uri: "/") {
  request, response in
  response.setHeader(.contentType, value: "text/html")
  response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    .completed()
}

do {
  // Launch the HTTP server.
  try HTTPServer.launch(
    .server(name: "localhost", port: 8182, routes: routes))
} catch {
  fatalError("\(error)") // fatal error launching one of the servers
}
