//
//  ViewController.swift
//  egg-timer
//
//  Created by Daria Arisova on 01.08.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = [
        "Soft": 5,
        "Medium": 8,
        "Hard": 12
    ]
    var player: AVAudioPlayer?
    var timer: Timer?
    var totalTime = 0
    var passedTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.titleLabel?.text
        
        totalTime = eggTimes[hardness!]! * 60
        passedTime = 0
        progressBar.progress = 0.0
        timer?.invalidate()
        topLabel.text = "Timer for \(hardness!) started"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        var percentageProgress: Float = 0.0
        
        passedTime += 1
        percentageProgress = Float(passedTime) / Float(totalTime)
        progressBar.progress = percentageProgress
        
        print("Percent: \(percentageProgress)")
     
        if passedTime == totalTime {
            timer?.invalidate()
            timer = nil
            topLabel.text = "DONE!"
            alarmBell()
        }
    }
    
    func alarmBell() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")

        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}

