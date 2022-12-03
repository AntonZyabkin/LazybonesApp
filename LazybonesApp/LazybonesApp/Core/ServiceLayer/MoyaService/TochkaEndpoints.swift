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
    case initStatement(request: TochkaInitStatementRequest)
    case getStatement(request: TochkaGetStatementRequest)
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
        case .initStatement(let request):
            return ["Authorization": "Bearer \(request.JWT)", "Content-Type": "application/json"]
        case .getStatement(let request):
            return ["Authorization": "Bearer \(request.jwt)", "Content-Type": "application/json"]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getTochkaAccessToken, .createPermissionsList, .getBalanceInfo, .initStatement, .getStatement:
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
        case .initStatement:
            return "/uapi/open-banking/v1.0/statements"
        case .getStatement(let request):
            return "/uapi/open-banking/v1.0/accounts/\(request.accountId)/statements/\(request.statementId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTochkaAccessToken, .createPermissionsList, .initStatement:
            return .post
        case .getBalanceInfo, .getStatement:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getTochkaAccessToken(let request):
            return request.asParameters()
        case .createPermissionsList, .getBalanceInfo, .initStatement, .getStatement:
            return [:]
        }
    }
    
    var task: Task {
        switch self {
        case .getTochkaAccessToken:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .createPermissionsList(let request):
            return .requestParameters(parameters: ["Data": ["permissions": request.body.data.permissions]], encoding: JSONEncoding.default)
        case .getBalanceInfo, .getStatement:
            return .requestPlain
        case .initStatement(let request):
            return self.requestCompositeParameters(request.data, parameters)
        }
    }
}
