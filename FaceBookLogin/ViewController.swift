//
//  ViewController.swift
//  FaceBookLogin
//
//  Created by Tops on 6/23/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var btnLogin: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       //self.btnLogin.readPermissions=["email","public_profile"]
        self.btnLogin.delegate = self
        
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if ((error) != nil) {

        }
        else if result.isCancelled {
            println("cancell by user")
        }
        else {
             println(result.token.tokenString)
             self.loginCallWithTokan(result.token.tokenString)
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        self.imgProfile.image=nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnCustomClick(sender: AnyObject)
    {
//        let login = FBSDKLoginManager()
//        login.loginBehavior = FBSDKLoginBehavior.SystemAccount;
//        
//        login.logInWithReadPermissions(["public_profile"],handler: { (response:FBSDKLoginManagerLoginResult!, error: NSError!) in
//            if(error != nil){
//            }
//            else if(response.isCancelled){
//                println("cancell by user")
//            }
//            else {
//               // println(response.token.tokenString)
//               // println(response.description)
//               // let string = "https://graph.facebook.com/v2.4/me?&access_token=\(response.token.tokenString)"
//                self.loginCallWithTokan(response.token.tokenString)
//            }
//        })
    }
    
    func loginCallWithTokan(token :String){
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue("608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: "X-Auth-Token")
        manager.GET("https://graph.facebook.com/v2.4/me?&access_token=\(token)",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                //println("\(responseObject)")
                let dis:NSDictionary = (responseObject as? NSDictionary)!
                println( String(format: "Some words %@ some more words", dis["id"] as! String))
                self.profileImageCall(dis["id"] as! String)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
               
            }
        )
    }
    
    func profileImageCall(strid:String){
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue("608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: "X-Auth-Token")
        manager.GET("https://graph.facebook.com/v2.4/\(strid)/picture?type=large&redirect=false",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                //println("\(responseObject)")
                let dis:NSDictionary = (responseObject as? NSDictionary)!
                let dic:NSDictionary = (dis["data"] as? NSDictionary)!
                println( String(format: "Some words %@ some more words", dic["url"] as! String))
                self.imgProfile.setImageWithURL(NSURL(string:String(format: "%@", dic["url"] as! String)))
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                
            }
        )
    }
}

