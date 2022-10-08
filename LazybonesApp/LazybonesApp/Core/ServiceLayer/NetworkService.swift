//
//  NetworkService.swift
//  LazybonesApp
//
//  Created by Игорь Дикань on 08.10.2022.
//

protocol Networkable {
    func request()
}

final class NetworkService {}

extension NetworkService: Networkable {
    func request() {
        print("make request")
    }
}
