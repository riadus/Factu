//
//  AppDelegate.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 19/07/2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let container = DIContainer(part:
                   DIGroup {
                        UIAssembly()
                        CoreAssembly()
                        DomainAssembly()
                        RepositoryAssembly()
                   })
                    
               
       SwiftDI.useContainer(container)
        
        return true
    }
}
