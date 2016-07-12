//
//  ColorModel.swift
//  funFacts
//
//  Created by Parker Donat on 1/28/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit
import GameKit

struct ColorModel {
//    let colors = [
//        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
//        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
//        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
//        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
//        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
//        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
//        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
//        UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0), // black color
//        UIColor(red:0.35, green:0.78, blue:0.98, alpha:1.0), // light blue color
//        UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0), // gold color
//        UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0), // bluish color
//        UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0), // light green color
//        UIColor(red:0.82, green:0.00, blue:0.00, alpha:1.0), // Dark red
//        UIColor(red:0.18, green:0.31, blue:0.31, alpha:1.0), // Dark blue grey
//        UIColor(red:0.44, green:0.50, blue:0.56, alpha:1.0), // Dark Grey
//        UIColor(red:0.41, green:0.41, blue:0.41, alpha:1.0), // light grey
//        UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)  // orange red color
//    ]
    
//    mutating func getRandomColor() -> UIColor  {
//        let randomRed = GKRandomSource.sharedRandom().nextIntWithUpperBound(255)
//        let randomGreen = GKRandomSource.sharedRandom().nextIntWithUpperBound(255)
//        let randomBlue = GKRandomSource.sharedRandom().nextIntWithUpperBound(255)
//        let finalColor = UIColor(red: CGFloat(randomRed/255), green: CGFloat(randomGreen/255), blue: CGFloat(randomBlue/255), alpha: 1.0)
//        return finalColor
//    }
    
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random() - (hue: 0.1),
                       green: .random() - (hue: 0.0),
                       blue:  .random() - (hue: 0.4),
                       alpha: 1.0)
    }
}