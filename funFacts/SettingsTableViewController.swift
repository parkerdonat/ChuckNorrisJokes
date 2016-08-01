//
//  SettingsTableViewController.swift
//  funFacts
//
//  Created by Parker Donat on 8/1/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var randomColorSwitch: UISwitch!
    @IBOutlet var soundSwitch: UISwitch!
    @IBOutlet var switchAnimation: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let alarm = alarmPin {
//            updateViewWithAlarm(alarm)
//        }
    }

    @IBAction func randomSwitchTapped(sender: AnyObject) {
        print("Random Switch tapped")
    }
}