//
//  AppDelegate.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 09/09/20.
//  Copyright © 2020 Mobilecoderz. All rights reserved.
//

import UIKit
import CoreLogic
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    
    override init() {
        print("override init")
        CoreLogicServices.shared.initWith(config: CoreLogicConfig(clientId: "SLyuDWJrw78WAhquFIEVIPsuLSJnaya0", clientSecret: "zzjgjwdooi6eGA5p"))
        super.init()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }



}

