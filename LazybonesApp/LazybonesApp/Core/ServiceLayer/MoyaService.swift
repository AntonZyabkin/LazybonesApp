//
//  MoyaService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 17.10.2022.
//

import Foundation
import Moya

//MARK: - Moya JSONPlaceHolder methods(Actions)
extension Action: TargetType {
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .Post:
            return "/posts"
        case .User:
            return "/users"
        case .Comment:
            return "/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Post, .User, .Comment:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .Post, .User, .Comment:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

//MARK: - Moya Sbis methods

enum SbisRequests {
    case auth(AuthRequest)
    case fetchDocList(DocList)
}

extension SbisRequests: TargetType {
    
    var parameters: [String: Any] {
        switch self {
        case .auth(let request):
            return [:]
        case .fetchDocList:
            return [:]
        }
    }
    var baseURL: URL {
        return URL(string: "https://online.sbis.ru")!
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/auth/service/"
        case .fetchDocList:
            return "/service/?srv=1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .auth, .fetchDocList:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .auth(let auth):
            return self.requestCompositeParameters(auth.body)
        case .fetchDocList(let docList):
            return self.requestCompositeParameters(docList.body)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchDocList:
            //Исправить передачу токена в заголовок
            return ["Content-Type": "application/json-rpc;charset=utf-8", "X-SBISSessionID": "00d2f6d4-00d2f6d5-0bba-e97ca3f7a748f868"]
        case .auth:
            return ["Content-Type": "application/json-rpc;charset=utf-8"]
        }
    }
}

//MARK: - asDictionary extention
private extension SbisRequests {
    
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
            urlParameters: parameters)
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
