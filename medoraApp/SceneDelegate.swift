//
//  SceneDelegate.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 07.11.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        if UserDefaultManager.shared.isLogged() {
            tabbarRoot()
        } else {
            onboardingRoot()
        }
    }
    
    func tabbarRoot() {
        window?.rootViewController = TabbarController()
        window?.makeKeyAndVisible()
    }
    
    func registerRoot() {
        guard let window = window else { return }
        
        let loginNav = UINavigationController(rootViewController: RegisterController(vm: RegisterViewModel(manager: AuthManager())))
        
        UIView.transition(with: window,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            window.rootViewController = loginNav
            window.makeKeyAndVisible()
        },
        completion: nil)
    }
        
    func onboardingRoot() {
        UserDefaultManager.shared.removeAll()
        window?.rootViewController = OnboardingController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    
}

