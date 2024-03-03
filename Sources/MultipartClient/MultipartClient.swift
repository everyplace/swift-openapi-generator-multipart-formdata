import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

struct FileDataResponse: Codable {
    let name: String
    let filetype: String
    let filename: String
    let filepath: String
    let timestamp: String
    let meta: [String: String]
}

public struct MultipartClient {
    private let client: Client
     
//    private let decoder = JSONDecoder()
    
    public init(serverURL: URL) {
        self.client = Client(serverURL: serverURL, transport: URLSessionTransport())
    }
    
    public func upload(filePath: String) async throws {
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
//        let response = try await client.uploadImage(body: .multipartForm([
//            .images_lbrack__rbrack_(.init(
//                payload: .init(body: .init(data)),
//                /// The filename is meaningless here, but mandatory field to include, without Lemmy rejects the request.
//                filename: "hello.png"
//            ))
//        ]))
        print(response)
    }
    
//    public func getStatus() async throws -> Operations.getStatus.Output.Ok.Body.jsonPayload {
//        let response = try await client.getStatus(Operations.getStatus.Input())
//        switch response {
//        case .ok(let okResponse):
//            switch okResponse.body {
//            case .json(let status):
//                return status
//            }
//        case .undocumented(statusCode: let statusCode, _):
//            throw NSError(domain: "StatusApiError", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Received undocumented status code: \(statusCode)"])
//        }
//    }
}
