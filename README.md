# swift-openapi-genenerator-multipart-formdata
## An example of using POST endpoints with multipart/form-data

The primary purpose of this project is to illustrate how to properly create multipart/form-data POST requests with an api client, as generated from an openapi document using the `swift-openapi-generator` library. This project isn't necessarily useful inandof itself, but it should serve as a helpful starter to building client libraries that can POST efficiently.

This project is currently configured to use a sample glitch backend:
- Running project: `https://swift-openapi-generator-multipart-formdata.glitch.me`
- Server code: `https://glitch.com/edit/#!/swift-openapi-generator-multipart-formdata`

To run:
`swift run MultipartCli --image "path/to/image" --description "File description"`

There is an optional additional parameter `--endpoint`, which allows the setting of an arbitrary endpoint. This is useful for testing against localhost or another backend besides the above sample glitch.com host.

Prior art:
- [swift-openapi-generator ContentTypesClient example](https://github.com/apple/swift-openapi-generator/blob/7992d77065f2787e7651cf6d9be9b99ad38f5166/Examples/various-content-types-client-example/Sources/ContentTypesClient/ContentTypesClient.swift)
- [runway's great article](https://www.runway.team/blog/how-to-build-an-app-store-connect-api-client-in-swift-using-openapi) talking about generating clients
- [brightdigit's blog post](https://brightdigit.com/tutorials/swift-openapi-generator/) which clearly illustrates the value of curated responses
- [Simon Støvring's blog post](https://shape.dk/news-and-knowledge/leveraging-apples-new-swift-openapi-generator) on how shape.dk has adjusted to using clients, and the challenges of auto-generation
- [Denis Dzyubenko's multipart example](https://elk.zone/mastodon.social/@ddenis/112028263644485215) of posting to Lemmy's backend, pointing to [his sample repo](https://github.com/shadone/Lemmy-OpenAPI-Spec-Swift-Example/blob/main/Sources/lemmy-openapi-example/Main.swift#L50-L56).
