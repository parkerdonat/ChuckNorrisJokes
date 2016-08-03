//
//  FavedJokeViewController.swift
//  funFacts
//
//  Created by Parker Donat on 8/2/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class FavedJokeViewController: UIViewController {
    
    @IBOutlet weak var favJokeLabel: UILabel!
    
    var joke: Joke?
    var currentColor = UIColor()
    var isLight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = currentColor
        
        isLightColor()
        
        if let joke = self.joke {
           updateWithJoke(joke)
        }
    }
    
    // MARK: - LOGIC FOR CHANGING ELEMENTS TO WHITE OR BLACK BASED ON RANDOM COLOR
    func isLightColor() {
        
        let color = view.backgroundColor
        
        let componentColors = CGColorGetComponents(color!.CGColor)
        
        let colorBrightness: CGFloat = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000
        
        if (colorBrightness >= 0.5) {
            isLight = true
            NSLog("Background color is light \(colorBrightness)")
            favJokeLabel.textColor = .blackColor()
        } else {
            isLight = false
            NSLog("Background color is dark \(colorBrightness)")
            favJokeLabel.textColor = .whiteColor()
        }
    }
    
    func updateWithJoke(joke: Joke) {
        self.joke = joke
        self.favJokeLabel.text = joke.text
    }
}
