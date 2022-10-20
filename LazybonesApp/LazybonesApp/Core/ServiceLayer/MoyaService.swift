//
//  MoyaService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 17.10.2022.
//

import Foundation
import Moya

extension Action: TargetType {
    var baseURL: URL {
        //TODO: - Fix this force unwrap
        URL(string: "https://jsonplaceholder.typicode.com1")!
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
