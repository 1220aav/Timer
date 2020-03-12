//
//  ViewController.swift
//  Timer
//
//  Created by Andrey Andryukhin on 12.03.2020.
//  Copyright © 2020 Andrey Andryukhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var timerOutlet: UILabel!
    
    var counter = 0.0
    var timer = Timer()
    var isCounterON = false

    override func viewDidLoad() {
        super.viewDidLoad()
        timerOutlet.text = String(counter)
    }
    
    // MARK: - Actions
    
    @IBAction func switchTimer(_ sender: UIButton) {
        if !isCounterON {
            startTimer()
            sender.setTitle("Pause", for: .normal)
            sender.tintColor = UIColor.systemRed
        } else {
            stopTimer()
            sender.setTitle("Play", for: .normal)
            sender.tintColor = UIColor.systemBlue
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isCounterON = true
    }
    
    private func stopTimer() {
        timer.invalidate()
        isCounterON = false
    }
    
    @objc private func updateTimer() {
        counter += 0.1
        timerOutlet.text = String(format: "%.1f", counter)
    }
}
