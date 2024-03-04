//
//  File.swift
//  
//
//  Created by Erin Sparling on 3/1/24.
//

import Foundation
import MultipartClient
import ArgumentParser

// https://www.swift.org/getting-started/cli-swiftpm/

@main
struct MultipartCli: AsyncParsableCommand {
    
    @Option(name: .long, help: "--image path to image plz")
    var image: String
    
    @Option(name: .long, help: "--description file description")
    var description: String
    
    @Option(name: .long, help: "--endpoint url to multipart/form-data POST endpoint")
    var endpoint: String?
    
    func run() async throws {
        let serverURL = try URL(string: endpoint ?? "") ?? Servers.server1()
        let client = MultipartClient(serverURL: serverURL)
        let response = try await client.upload(filePath: image, fileDiscription: description)
        print(response)
    }
}
