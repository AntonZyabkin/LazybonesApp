//
//  LazybonesAppTests.swift
//  LazybonesAppTests
//
//  Created by Anton Zyabkin on 05.10.2022.
//

import XCTest
@testable import LazybonesApp

class LazybonesAppTests: XCTestCase {
	
	
	func testSbisAuthPresenter() {
		//given
		let mockKeyChainService = MockKeychainService()
		let mockSbisAPIservise = SbisAuthSuccessService()
		let presenter = SbisAuthPresenter(sbisAPIService: mockSbisAPIservise, keychainService: MockKeychainService())
		let viewController = SpySbisAuthViewcontroller()
		
		presenter.view = viewController

		//when
		presenter.authButtonDidPressed("", "")
		presenter.viewWasLoaded()
		
		
		//then
		
		
		XCTAssertTrue(viewController.isRunShowError)
		XCTAssert(viewController.errorMessage.isEmpty)
	}
}


extension SbisAuthResponse {
	static var stub: Self = {
		SbisAuthResponse(jsonrpc: "", result: "", id: "", error: nil)
	}()
}


final class SpySbisAuthViewcontroller: UIViewController, SbisAuthViewProtocol {
	
	var isRunShowError = false
	var isRunShowData = false
	var errorMessage = ""
	func showErrorMessage(_ message: String) {
		isRunShowError = true
		errorMessage = message
	}
	func showAuthData(login: String, password: String) {
		isRunShowData = true
	}
}

import SwiftKeychainWrapper

final class MockKeychainService: KeychainServicable {
	func save(_ value: String, for key: SwiftKeychainWrapper.KeychainWrapper.Keys) -> Bool {
		true
	}
	
	func fetch(for key: SwiftKeychainWrapper.KeychainWrapper.Keys) -> String? {
		""
	}
	
	func deleteItem(for key: SwiftKeychainWrapper.KeychainWrapper.Keys) -> Bool {
		true
	}
	
	func deleteAll() -> Bool {
		true
	}
	
	func saveCodable<T>(_ value: T, for key: String) -> Bool where T : Decodable, T : Encodable {
		true
	}
	
	func fetchTochkaPaymentForSignRequest(key: String, complition: @escaping (Result<LazybonesApp.TochkaPaymentForSignRequest, Error>) -> Void) {
		
	}
	
	
}

final class SbisAuthSuccessService: SbisAuthApiServicable {
	func sendAuthRequest(request: LazybonesApp.SbisAuthRequest, complition: @escaping (Result<LazybonesApp.SbisAuthResponse, Error>) -> Void) {
		complition(.success(SbisAuthResponse.stub))
	}
}
final class SbisAuthFailureService: SbisAuthApiServicable {
	func sendAuthRequest(request: LazybonesApp.SbisAuthRequest, complition: @escaping (Result<LazybonesApp.SbisAuthResponse, Error>) -> Void) {
		complition(.failure(NSError(domain: "test", code: -1)))
	}
}
