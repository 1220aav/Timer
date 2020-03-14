//
//  ViewController.swift
//  Timer
//
//  Created by Andrey Andryukhin on 12.03.2020.
//  Copyright © 2020 Andrey Andryukhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    var timer = Timer()
    var isCounting = false
    var (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
    
    var laps = [Lap]()
    
    // MARK: - Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var fractionsLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.tintColor = UIColor.systemBlue
        resetButton.tintColor = UIColor.systemRed
        resetButton.isHidden = true
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Actions
    @IBAction func startStopTimer(_ sender: UIButton) {
        if !isCounting {
            startTimer()
        } else {
            stopTimer()
        }
        
    }
    
    
    @IBAction func resetTimer(_ sender: UIButton) {
        timer.invalidate()
        (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
        timerLabel.text = "00:00:00"
        fractionsLabel.text = ".00"
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.tintColor = UIColor.systemBlue
        resetButton.isHidden = true
        
        laps = []
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(keepTimer), userInfo: nil, repeats: true)
        self.isCounting = true
        keepTimer()
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.tintColor = UIColor.systemRed
        resetButton.isHidden = true
    }
    
    func stopTimer() {
        timer.invalidate()
        isCounting = false
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.tintColor = UIColor.systemBlue
        resetButton.isHidden = false
        
        let lapTime = timerLabel.text!
        let lap = Lap(lapTime: lapTime)
        laps.append(lap)
        
        tableView.insertRows(at: [IndexPath(row: laps.count-1, section: 0)], with: .automatic)
    }
    
    @objc func keepTimer() {
        let fractionsString = ".\(fractions)"
        let secondsString = seconds <= 9 ? "0\(seconds)" : "\(seconds)"
        let minutesString = minutes <= 9 ? "0\(minutes)" : "\(minutes)"
        let hoursString = hours <= 9 ? "0\(hours)" : "\(hours)"
        
        fractions += 1
        fractionsLabel.text = fractionsString
        if fractions > 99 {
            seconds += 1
            fractions = 0
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        if minutes == 60 {
            hours += 1
            minutes = 0
        }
        timerLabel.text = "\(hoursString):\(minutesString):\(secondsString)"
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForLap", for: indexPath)
        
        let lap = laps[indexPath.row]
        cell.textLabel?.text = lap.lapTime
        
        
        return cell
    }
    
    
}
