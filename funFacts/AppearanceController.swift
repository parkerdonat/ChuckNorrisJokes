//
//  AppearanceController.swift
//  UIAppearance
//
//  Created by Parker Donat on 2/9/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import Foundation
import UIKit


class AppearanceController {
    
    static func initializeAppearanceDefaults() {
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Adventure", size: 22)!]
        UINavigationBar.appearance().titleTextAttributes = titleDict as? [String : AnyObject]
        
        UIToolbar.appearance().barTintColor = UIColor.blackColor()
        
    }
    
    
}









