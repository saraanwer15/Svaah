//
//  SecondView.swift
//  
//
//  Created by user181178 on 9/17/20.
//

import UIKit

class SecondView: UIViewController {

    
    
    @IBOutlet weak var Greetings: UILabel!
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let infoListPath = "/Users/user181178/Desktop/Login Page/Login Page/Fetched_Data.plist"
        var plistData: [String : Any] = self.read_data(atPath: infoListPath)
        Greetings.text = "Hi, " + (plistData["First_Name"] as! String)


    }


}
