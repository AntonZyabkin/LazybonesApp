//
//  TochkaEndpoints.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation
import Moya

enum TochkaEndpoints {
    case getTochkaAccessToken(request: TochkaAccessTokenRequest)
}

extension TochkaEndpoints: TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .getTochkaAccessToken:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getTochkaAccessToken:
            return URL(string: "https://enter.tochka.com")!
        }
    }
    
    var path: String {
        switch self {
        case .getTochkaAccessToken:
            return "/connect/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTochkaAccessToken:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getTochkaAccessToken(let request):
            return .requestPlain
        }
    }
}
