//
//  SceneDelegate.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        let assemblerBuilder = AssemblerModuleBuilder()
        let router = Router(navigationController: navigationController, assemblerBuilder: assemblerBuilder)
        router.initialTabBarViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


