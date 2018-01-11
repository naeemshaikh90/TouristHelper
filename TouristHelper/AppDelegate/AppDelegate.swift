//
//  AppDelegate.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 08/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    initGMSServices()
    return true
  }
}

extension AppDelegate {
  func initGMSServices() {
    // Google API Key
    GMSServices.provideAPIKey(Utility.googleAPIKey())
  }
}

