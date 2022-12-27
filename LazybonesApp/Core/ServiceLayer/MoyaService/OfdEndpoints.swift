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
    case fetch(request: OfdGetReportsRequest)
}

extension OfdEndpoints: TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .ofdAuth:
            return ["Content-Type": "application/json"]
        case .fetch:
            return [:]
//            return ["Content-Type": "application/json"]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .ofdAuth, .fetch:
            return URL(string: "https://ofd.ru/api")!
        }
    }
    
    var path: String {
        switch self {
        case .ofdAuth:
            return "/Authorization/CreateAuthToken"
        case .fetch:
//            return "/integration/v1/inn/\(request.inn)/zreports?dateFrom=\(request.dateFrom)&dateTo=\(request.dateTo)&AuthToken=\(request.authToken)"
            return "/integration/v1/inn/5024198006/zreports?dateFrom=2022-12-01T09:28:51&dateTo=2022-12-10T15:47:36&AuthToken=ec12dabddd0f40ebb9f5c5f1f49a495c"
        }
    }
    var method: Moya.Method {
        switch self {
        case .ofdAuth:
            return .post
        case .fetch:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .ofdAuth(let requset):
            return self.requestCompositeParameters(requset, [:])
        case .fetch:
            return .requestPlain
        }
    }
}
