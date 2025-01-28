import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public struct FileDataRequest: Codable {
    let image: Data
    let description: String?
    
    public init(image: Data, description: String? = nil) {
        self.image = image
        self.description = description
    }
    
    private enum CodingKeys: String, CodingKey {
        case image, description
    }
}

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

extension FileDataRequest {
    /// Convert our domain type into the generated multipart enum array.
    func toMultipart() -> MultipartBody<Components.Schemas.FileDataRequest> {
        var parts: [Components.Schemas.FileDataRequest] = []
        
        // If we have a description, add a `.description` part:
        if let description = description {
            parts.append(
                .description(
                    .init(payload: .init(body: .init(description)))
                )
            )
        }
        
        // Always add the image as an `.image` part:
        parts.append(
            .image(
                .init(
                    payload: .init(body: .init(image)),
                    filename: "test.png"      // optional
                    // contentType: "image/png"  // if needed
                )
            )
        )
        let multipartBody:MultipartBody = MultipartBody<Components.Schemas.FileDataRequest>(parts)

        return multipartBody
    }
}

public struct MultipartClient {
    private let client: Client
         
    public init(serverURL: URL) {
        self.client = Client(serverURL: serverURL, transport: URLSessionTransport())
    }
    
    public func upload(filePath: String, fileDiscription: String) async throws -> FileDataResponse {
        let data = try! Data(contentsOf: URL(filePath: filePath))
        
        let dataRequest: FileDataRequest = FileDataRequest(image: data, description: fileDiscription)
        
        let response = try await client.upload(body: .multipartForm(dataRequest.toMultipart()))
        let fileDataResponse = FileDataResponse(component: try response.ok.body.json)
        return fileDataResponse
    }
}
