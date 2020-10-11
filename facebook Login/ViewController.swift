//
//  ViewController.swift
//  facebook Login
//
//  Created by Muhammad Wahab on 10/10/2020.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let token = AccessToken.current,
           !token.isExpired {
            
            let token=token.tokenString
            
            let request=FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
            request.start(completionHandler: {connect,result,error in
                
                print("Result: \(result)")
                
            })
           
        }
        else
        {
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate=self
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
            
        }
    }
    
    
}

extension ViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token=result?.token?.tokenString
        
        let request=FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: {connect,result,error in
            
            print("Result: \(result)")
            
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
}


