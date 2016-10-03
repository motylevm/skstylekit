//
//  AppDelegate.swift
//  StyleKitDemo
//
//  Created by MIHAIL MOTYLEV on 01/10/2016.
//  Copyright © 2016 mmotylev. All rights reserved.
//

import UIKit
import AVStyleKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        StyleKit.initStyleKit()
        
        return true
    }
}

