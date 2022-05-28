//
//  ViewController.swift
//  iOS6-HW12.1
//
//  Created by Асхат Джумамуратов on 28.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer = Timer()
    var secondsStart = 1500
    var isWorkTime: Bool = true
    var isStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "25:00"
        label.textColor = .systemGreen
        button.setTitleColor(UIColor.green, for: .normal)
    }

    @IBAction func resetButton(_ sender: Any) {
        secondsStart = 1500
        label.text = "25:00"
        timer.invalidate()
        label.textColor = .systemGreen
        button.setTitleColor(UIColor.green, for: .normal)
        button.setTitle("Start", for: .normal)
        isStarted = false
    }
    
    @IBAction func buttonStart(_ sender: Any) {
        if(isStarted) {
            isStarted = false
            timer.invalidate()
            button.setTitle("Start", for: .normal)
            button.setTitleColor(UIColor.green, for: .normal)
        } else {
            isStarted = true
            button.setTitle("Stop", for: .normal)
            button.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerClass), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerClass() {
        let time = secondsToMinutesSeconds(seconds: secondsStart)
        let timeSring = makeTimeString(minutes: time.0, seconds: time.1)
        label.text = timeSring
        secondsStart -= 1
        if(secondsStart < 0) {
            isWorkTimeControl(isWorkBool: isWorkTime)
        }
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return((seconds % 3600) / 60, ((seconds % 3600) % 60))
    }
    
    func makeTimeString(minutes: Int, seconds: Int) -> (String) {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func isWorkTimeControl (isWorkBool: Bool){
        if (isWorkTime == true) {
            isWorkTime = false
            label.textColor = .systemBlue
            secondsStart = 300
        } else {
            timer.invalidate()
        }
    }
}

