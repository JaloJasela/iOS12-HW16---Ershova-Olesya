//
//  SceneDelegate.swift
//  iOS12-HW16 - Ershova Olesya
//
//  Created by IMac on 19.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let myModule = ModuleBulder.mainModule()
        let navigationController = UINavigationController(rootViewController: myModule)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

