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
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Adventure", size: 24)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
    }
}









