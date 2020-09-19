//
//  ViewController.swift
//  Login Page
//
//  Created by user181178 on 9/13/20.
//  Copyright © 2020 user181178. All rights reserved.
//

import UIKit
import FacebookLogin
import SwiftyJSON

// Add this to the body
class ViewController: UIViewController, LoginButtonDelegate {
    
    func read_data(atPath path: String) -> [String : Any]{
        var plistData: [String : Any] = [:]
        guard let plistFileData = FileManager.default.contents(atPath: path) else{
            print("file doesnt exist")
            return plistData
        }
        do{
            plistData = try PropertyListSerialization.propertyList(from: plistFileData, options: [], format: nil) as! [String : Any]
        }
        catch{
            print("error fetching list file")
        }
        return plistData
    }
    
    func write_data(withData data: NSDictionary, atPath path: String) -> Bool {
        guard FileManager.default.fileExists(atPath: path) else{
            return false
        }
        return data.write(toFile: path, atomically: false)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("User Logged IN")
        let nvc = storyboard?.instantiateViewController(identifier: "Second") as! SecondView
        let connection = GraphRequestConnection()
            connection.add(GraphRequest(graphPath: "/me", parameters: ["fields" : "id,first_name,about,birthday"], httpMethod: .get)) { (connection, response, error) in
            if let error = error {
                print("Error getting user info = \(error.localizedDescription)")
            }
            else {
                guard let userInfo = response as? Dictionary<String,Any> else {
                    return
            }
                if let userName = userInfo["first_name"] as? String {
                    print("Logged in user facebook name == \(userName)")
                    if let userId = userInfo["id"] as? String {
                        print("Logged in user facebook name == \(userId)")
                        let infoListPath = "/Users/user181178/Desktop/Login Page/Login Page/Fetched_Data.plist"
                        var plistData: [String : Any] = self.read_data(atPath: infoListPath)
                        plistData["First_Name"] = userName
                        plistData["User_ID"] = userId
                        if(!self.write_data(withData: plistData as NSDictionary, atPath: infoListPath)){
                            print("Error writing plist data \(infoListPath)")
                        }
                    }
                    
                }
            }
        }
        connection.start()
        self.present(nvc,animated: true)
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User Logged Out")

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.permissions = ["public_profile", "email"]
        loginButton.delegate = self
        view.addSubview(loginButton)
        if let token = AccessToken.current,
            !token.isExpired {
            let nvc = storyboard?.instantiateViewController(identifier: "Second") as! SecondView
            /*
            let connection = GraphRequestConnection()
            connection.add(GraphRequest(graphPath: "/me", parameters: ["fields" : "id,first_name,about,birthday"], httpMethod: .get)) { (connection, response, error) in
            if let error = error {
                print("Error getting user info = \(error.localizedDescription)")
            }
            else {
                guard let userInfo = response as? Dictionary<String,Any> else {
                    return
            }
                if let userName = userInfo["first_name"] as? String {
                    print("Logged in user facebook name == \(userName)")
                    nvc.Greetings?.text = "Hi, " + userName
                    
                }

            }
        }
        connection.start()
 */
        self.present(nvc,animated: true)
        }
    }
        
}


