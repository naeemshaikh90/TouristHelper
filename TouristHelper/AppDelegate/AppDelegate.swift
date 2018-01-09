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
 
  func initGMSServices() {
    // Google Key
    GMSServices.provideAPIKey("AIzaSyAm5kZPbrSvRL29nmHxR7tdWWLF95gK7E8")
  }
}

