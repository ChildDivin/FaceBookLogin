//
//  AppDelegate.swift
//  FaceBookLogin
//
//  Created by Tops on 6/23/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FBSDKAccessToken.currentAccessToken()
        FBSDKLoginButton .classForCoder()
        FBSDKLoginManager.classForCoder()
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    func applicationDidEnterBackground(application: UIApplication) {
    }
    func applicationWillEnterForeground(application: UIApplication){
    }
    func applicationDidBecomeActive(application: UIApplication) {
      FBSDKAppEvents.activateApp()
    }
    func applicationWillTerminate(application: UIApplication) {
    }
}

