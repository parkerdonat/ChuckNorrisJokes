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
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var animationLabel: UILabel!
    
    var currentColor = UIColor()
    var isLight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = currentColor
        tableView.backgroundColor = currentColor
        
        isLightColor()
        
        //        if let alarm = alarmPin {
        //            updateViewWithAlarm(alarm)
        //        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = currentColor
    }
    
    @IBAction func randomSwitchTapped(sender: AnyObject) {
        print("Random Switch tapped")
    }
    
    // MARK: - LOGIC FOR CHANGING ELEMENTS TO WHITE OR BLACK BASED ON RANDOM COLOR
    func isLightColor() {
        
        let color = view.backgroundColor
        
        let componentColors = CGColorGetComponents(color!.CGColor)
        
        let colorBrightness: CGFloat = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000
        
        if (colorBrightness >= 0.5) {
            isLight = true
            NSLog("Background color is light \(colorBrightness)")
            randomLabel.textColor = .blackColor()
            soundLabel.textColor = .blackColor()
            animationLabel.textColor = .blackColor()
            
            randomColorSwitch.onTintColor = .whiteColor()
            randomColorSwitch.tintColor = .whiteColor()
            randomColorSwitch.thumbTintColor = .blackColor()
            
            soundSwitch.onTintColor = .whiteColor()
            soundSwitch.tintColor = .whiteColor()
            soundSwitch.thumbTintColor = .blackColor()
            
            switchAnimation.onTintColor = .whiteColor()
            switchAnimation.tintColor = .whiteColor()
            switchAnimation.thumbTintColor = .blackColor()
            
        } else {
            isLight = false
            NSLog("Background color is dark \(colorBrightness)")
            randomLabel.textColor = .whiteColor()
            soundLabel.textColor = .whiteColor()
            animationLabel.textColor = .whiteColor()
            
            randomColorSwitch.onTintColor = .blackColor()
            randomColorSwitch.tintColor = .blackColor()
            randomColorSwitch.thumbTintColor = .whiteColor()
            
            soundSwitch.onTintColor = .blackColor()
            soundSwitch.tintColor = .blackColor()
            soundSwitch.thumbTintColor = .whiteColor()
            
            switchAnimation.onTintColor = .blackColor()
            switchAnimation.tintColor = .blackColor()
            switchAnimation.thumbTintColor = .whiteColor()
        }
    }
}