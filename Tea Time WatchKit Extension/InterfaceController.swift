//
//  InterfaceController.swift
//  Tea Time WatchKit Extension
//
//  Created by Michael Harper on 6/17/15.
//  Copyright © 2015 Standalone Code LLC. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

  static let blackTeaSeconds: NSTimeInterval = 300
  static let greenTeaSeconds: NSTimeInterval = 240
  static let coffeeSeconds: NSTimeInterval = 300
  
  let timers: [String : NSTimeInterval] = [
    "Black Tea" : blackTeaSeconds,
    "Green Tea" : greenTeaSeconds,
    "Coffee"    : coffeeSeconds
  ]
  
  var alertTimer: NSTimer?
  
  @IBOutlet var teaTimer: WKInterfaceTimer!
  
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
  
  @IBAction func blackTeaAction() {
    startTimer("Black Tea")
  }

  @IBAction func greenTeaAction() {
    startTimer("Green Tea")
  }

  @IBAction func coffeeAction() {
    startTimer("Coffee")
  }
  
  @IBAction func stopAction() {
    stopWatchTimer()
    stopAlertTimer()
  }
  
  func startTimer(timerName: String) {
    // Only start a timer if one isn't already running.
    if (alertTimer == nil) {
      let interval = timers[timerName]
      startWatchTimer(interval)
      startAlertTimer(interval)
    }
  }
  
  func startWatchTimer(interval: NSTimeInterval?) {
    if let interval = interval {
      teaTimer.setDate(NSDate(timeIntervalSinceNow: interval))
      teaTimer.start()
    }
  }
  
  func stopWatchTimer() {
    teaTimer.stop()
  }
  
  func startAlertTimer(interval: NSTimeInterval?) {
    if let interval = interval {
      alertTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "alertTimerFired:", userInfo: "Tea's done!", repeats: false)
    }
  }
  
  func stopAlertTimer() {
    alertTimer?.invalidate()
    alertTimer = nil
  }
  
  func alertTimerFired(timer: NSTimer) {
    WKInterfaceDevice.currentDevice().playHaptic(.Success)
    alertTimer = nil
  }
}
