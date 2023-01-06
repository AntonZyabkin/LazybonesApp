//
//  OfdEndpoints.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation
import Moya

enum OfdEndpoints {
    case ofdAuth(request: OfdAuthRequest)
}

extension OfdEndpoints: TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .ofdAuth:
            return ["Content-Type": "application/json"]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .ofdAuth:
            return URL(string: "https://ofd.ru/api")!
        }
    }
    
    var path: String {
        switch self {
        case .ofdAuth:
            return "/Authorization/CreateAuthToken"
        }
    }
    var method: Moya.Method {
        switch self {
        case .ofdAuth:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .ofdAuth(let requset):
            return self.requestCompositeParameters(requset, [:])
        }
    }
}
