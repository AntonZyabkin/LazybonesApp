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
    case createPermissionsList(request: TochkaPermissionsListRequest)
    case getBalanceInfo(request: TochkaBalanceRequest)
}

extension TochkaEndpoints: TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .getTochkaAccessToken:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .createPermissionsList(let request):
            return ["Authorization": request.tochkaAccessToken, "Content-Type": "application/json"]
        case .getBalanceInfo(let request):
            return ["Authorization": "Bearer \(request.JWT)"]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getTochkaAccessToken, .createPermissionsList, .getBalanceInfo:
            return URL(string: "https://enter.tochka.com")!
        }
    }
    
    var path: String {
        switch self {
        case .getTochkaAccessToken:
            return "/connect/token"
        case .createPermissionsList:
            return "/uapi/v1.0/consents"
        case .getBalanceInfo:
            return "/uapi/open-banking/v1.0/balances"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTochkaAccessToken, .createPermissionsList:
            return .post
        case .getBalanceInfo:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getTochkaAccessToken(let request):
            return request.asParameters()
        case .createPermissionsList, .getBalanceInfo:
            return [:]
        }
    }
    
    var task: Task {
        switch self {
        case .getTochkaAccessToken:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .createPermissionsList(let request):
            return .requestParameters(parameters: ["Data": ["permissions": request.body.data.permissions]], encoding: JSONEncoding.default)
        case .getBalanceInfo:
            return .requestPlain
        }
    }
}
