//
//  File.swift
//  
//
//  Created by Erin Sparling on 3/1/24.
//

import Foundation
import MultipartClient


let client = MultipartClient(serverURL: try Servers.server1())
try await client.upload(filePath: "./test.png")
print("no")