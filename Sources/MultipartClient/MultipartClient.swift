import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public struct FileDataResponse: Codable {
    let name: String?
    let filetype: String?
    let filename: String?
    let filepath: String?
    let timestamp: Date?
//    let meta: [String: String]?
    
    private enum CodingKeys: String, CodingKey {
        case name, filetype, filename, filepath, timestamp/*, meta*/
    }
}

extension FileDataResponse {
    internal init(component: Components.Schemas.FileDataResponse) {
        self.init(
            name: component.name,
            filetype: component.filetype,
            filename: component.filename,
            filepath: component.filepath,
            timestamp: Date(timeIntervalSince1970: TimeInterval(component.timestamp!))
        )
    }
}

public struct MultipartClient {
    private let client: Client
         
    public init(serverURL: URL) {
        self.client = Client(serverURL: serverURL, transport: URLSessionTransport())
    }
    
    public func upload(filePath: String, fileDiscription: String) async throws -> FileDataResponse {
        let data = try! Data(contentsOf: URL(filePath: filePath))
        
        let response = try await client.upload(body: .multipartForm([
            .description(.init(
                payload: .init(body: .init(fileDiscription))
            )),
            .image(.init(
                payload: .init(body: .init(data)),
                filename: "test.png"
            ))            
        ]))
        let fileDataResponse = FileDataResponse(component: try response.ok.body.json)
        return fileDataResponse
    }
}
