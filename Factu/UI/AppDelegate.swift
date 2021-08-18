//
//  AppDelegate.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 19/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let container = DIContainer(part:
                   DIGroup {
                        UIAssembly()
                        CoreAssembly()
                   })
                    
               
       SwiftDI.useContainer(container)
        
        return true
    }
}
