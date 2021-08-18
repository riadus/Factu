//
//  SceneDelegate.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 19/07/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @Inject var coordinator : ICoordinator

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)

            window.rootViewController = coordinator.start()

            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

