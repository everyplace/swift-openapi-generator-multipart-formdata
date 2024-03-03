import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public struct FileDataResponse: Codable {
    let name: String?
    let filetype: String?
    let filename: String?
    let filepath: String?
    let timestamp: Date?
    let meta: [String: String]?
    
    private enum CodingKeys: String, CodingKey {
        case name, filetype, filename, filepath, timestamp, meta
    }
}
//
//extension FileDataResponse {
//    internal init(component: Components.Schemas)
//}

public struct MultipartClient {
    private let client: Client
     
//    private let decoder = JSONDecoder()
    
    public init(serverURL: URL) {
        self.client = Client(serverURL: serverURL, transport: URLSessionTransport())
    }
    
    public func upload(filePath: String) async throws/* -> FileDataResponse */{
        let data = try! Data(contentsOf: URL(filePath: filePath))
        
        let response = try await client.upload(body: .multipartForm([
            .description(.init(
                payload: .init(body: "test")
            )),
            .image(.init(
                payload: .init(body: .init(data)),
                filename: "test.png"
            ))
            
        ]))
        let json = try response.ok.body.json
        
        
//
//        let fileDataResponse: FileDataResponse = FileDataResponse(
//            name: json.name,
//            filetype: json.filetype,
//            filename: json.filename,
//            filepath: json.filepath,
//            timestamp: json.timestamp,
//            meta: json.meta?.additionalProperties)
//        return fileDataResponse
    }
}
