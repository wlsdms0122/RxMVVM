//
//  NetworkService.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol NetworkServiceProtocol {
    func fetchColors() -> Single<[Color]>
}

class NetworkService: NetworkServiceProtocol {
    func fetchColors() -> Single<[Color]> {
        ApiProvider<GithubApiTarget>.request(.colors)
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .do(onSuccess: { _ in
                // Random error occur (25%)
                if arc4random() % 5 == 0 {
                    throw NetworkError.badRequest
                }
            })
    }
}

enum NetworkError: Error {
    case badRequest
    case emptyData
    case missingRequiredPrameters
    case parseError
    case unknown
}

// MARK: - API Provider
fileprivate struct ApiProvider<API: ApiType> {
    static func request<Model: Codable>(_ api: API) -> Single<Model> {
        Logger.info(
            """
            API Request - \(api)
             🐶  URL: \(api.url.absoluteString)
             🐱  METHOD: \(api.method)
             🐭  PARAMETERS: \(api.parameters ?? [:])
             🐹  HEADER: \(api.headers ?? [])
            """,
            tag: "NETWORK"
        )
        
        return Single.create { emitter in
            AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers)
                .response { result in
                    // Check network error
                    if let error = result.error {
                        Logger.error(error, tag: "NETWORK")
                        emitter(.error(NetworkError.unknown))
                        return
                    }
                    
                    // Unwrap response data
                    guard let data = result.data else {
                        emitter(.error(NetworkError.emptyData))
                        return
                    }
                    
                    Logger.debug(String(bytes: data, encoding: .utf8) ?? "", tag: "NETWORK")
                    
                    // Parse json data to model object
                    guard let model = JSONCodec.decode(data, type: Model.self) else {
                        emitter(.error(NetworkError.parseError))
                        return
                    }
                    
                    // Emit succes through main thread
                    emitter(.success(model))
            }
            
            return Disposables.create()
        }
    }
}

// MARK: - API Type
protocol ApiType {
    /// Base url of api
    var baseUrl: URL { get }
    
    /// Specific path of api
    var path: String { get }
    
    /// Request method of http api
    var method: HTTPMethod { get }
    
    /// Parameters of http api
    var parameters: Parameters? { get }
    
    /// Header of http api
    var headers: HTTPHeaders? { get }
}

extension ApiType {
    var url: URL { baseUrl.appendingPathComponent(path) }
}

// MARK: - API Target
enum GithubApiTarget: ApiType {
    case colors
    
    var baseUrl: URL {
        URL(string: "https://raw.githubusercontent.com/wlsdms0122/RxMVVM/develop")!
    }
    
    var path: String {
        switch self {
        case .colors:
            return "API/colors.json"
        }
    }
    
    var method: HTTPMethod { .get }
    
    var parameters: Parameters? { nil }
    
    var headers: HTTPHeaders? { nil }
}
