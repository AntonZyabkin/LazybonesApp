//
//  SbisEndpiont.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 10.11.2022.
//

import Foundation
import Moya
//MARK: - Moya Sbis methods

enum SbisEndpoint {
    case auth(request: SbisAuthRequest)
    case fetchComingList(request: SbisComingListRequest)
}

extension SbisEndpoint: TargetType {
    
    var headers: [String: String]? {
        switch self {
        case .fetchComingList(let request):
            //Исправить передачу токена в заголовок
            return ["Content-Type": "application/json-rpc;charset=utf-8", "X-SBISSessionID": request.sbisToken]
        case .auth:
            return ["Content-Type": "application/json-rpc;charset=utf-8"]
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://online.sbis.ru")!
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/auth/service/"
        case .fetchComingList:
            return "/service/?srv=1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .auth, .fetchComingList:
            return .post
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .auth:
            return [:]
        case .fetchComingList:
            return [:]
        }
    }
    var task: Task {
        switch self {
        case .auth(let auth):
            return self.requestCompositeParameters(auth.body, parameters)
        case .fetchComingList(let comingList):
            return self.requestCompositeParameters(comingList.body, parameters)
        }
    }
}

//MARK: - asDictionary extention
private extension SbisEndpoint {
    
    func requestCompositeParameters(_ body: Encodable) -> Task {
        var bodyDict: [String: Any] = [:]
        do {
            bodyDict = try body.asDictionary()
        } catch let error {
            print(error.localizedDescription)
        }
        return .requestCompositeParameters(
            bodyParameters: bodyDict,
            bodyEncoding: JSONEncoding(),
            urlParameters: self.parameters)
    }
}
private extension Moya.TargetType {
    func requestCompositeParameters(_ body: Encodable, _ parameters: [String: Any]) -> Task {
        var bodyDict: [String: Any] = [:]
        do {
            bodyDict = try body.asDictionary()
        } catch let error {
            print(error.localizedDescription)
        }
        return .requestCompositeParameters(
            bodyParameters: bodyDict,
            bodyEncoding: JSONEncoding(),
            urlParameters: parameters)
    }
}
