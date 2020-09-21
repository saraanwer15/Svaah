//
//  ViewController.swift
//  Shvaas
//
//  Created by user181178 on 9/21/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var Status_of_recording: UILabel!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var time_left = 30
    var timer = Timer()
    func stop(){
        let Load_freetrial_page = storyboard?.instantiateViewController(identifier: "Trial_Page") as! Free_Trial_Page
            self.present(Load_freetrial_page,animated: true)
    }
        
    @objc func start(){
        time_left-=1
        if(time_left<0){
            stop()
            timer.invalidate()
        }
        else{
            print(time_left)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(start), userInfo: nil, repeats: true )
    }
    
    
}

