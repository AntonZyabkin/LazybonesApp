//
//  SceneDelegate.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 05.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupRootViewController(windowScene: windowScene)
    }
    
    private func setupRootViewController(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        
        // TODO: -
        let viewController = MainViewController()
        let decoderService = DecoderServise()
        let networkService = NetworkService(decoderService: decoderService)
        let presenter = MainPresenter(networkService: networkService)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
//        window.rootViewController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = ModuleBuilder.lounchDashboardVC()
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
