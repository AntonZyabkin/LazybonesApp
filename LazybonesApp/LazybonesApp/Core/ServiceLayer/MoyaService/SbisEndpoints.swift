//
//  SbisEndpiont.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 10.11.2022.
//

import Foundation
import Moya
//MARK: - Moya Sbis methods

enum SbisEndpoints {
    case sbisAuth(request: SbisAuthRequest)
    case fetchSbisComingList(request: SbisComingListRequest)
}

extension SbisEndpoints: TargetType {
    
    var headers: [String: String]? {
        switch self {
        case .fetchSbisComingList(let request):
            //Исправить передачу токена в заголовок
            return ["Content-Type": "application/json-rpc;charset=utf-8", "X-SBISSessionID": request.sbisToken]
        case .sbisAuth:
            return ["Content-Type": "application/json-rpc;charset=utf-8"]
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://online.sbis.ru")!
    }
    
    var path: String {
        switch self {
        case .sbisAuth:
            return "/auth/service/"
        case .fetchSbisComingList:
            return "/service/?srv=1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sbisAuth, .fetchSbisComingList:
            return .post
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .sbisAuth:
            return [:]
        case .fetchSbisComingList:
            return [:]
        }
    }
    var task: Task {
        switch self {
        case .sbisAuth(let auth):
            return self.requestCompositeParameters(auth.body, parameters)
        case .fetchSbisComingList(let comingList):
            return self.requestCompositeParameters(comingList.body, parameters)
        }
    }
}

//MARK: - asDictionary extention
private extension SbisEndpoints {
    
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
