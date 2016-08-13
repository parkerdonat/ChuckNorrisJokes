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
    @IBOutlet weak var shareButton: UIButton!
    
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
    
    // HIDE STATUS BAR
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        if let text = favJokeLabel.text {
            let share = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            
            //Excluded Activities
            share.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeOpenInIBooks, UIActivityTypePrint, UIActivityTypePostToVimeo, UIActivityTypePostToWeibo, UIActivityTypePostToFlickr, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]
            
            share.popoverPresentationController?.sourceView = sender as? UIView
            self.presentViewController(share, animated: true, completion: nil)
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
            shareButton.setImage(UIImage(named: "share_black"), forState: UIControlState.Normal)
        } else {
            isLight = false
            NSLog("Background color is dark \(colorBrightness)")
            favJokeLabel.textColor = .whiteColor()
            shareButton.setImage(UIImage(named: "share_white"), forState: UIControlState.Normal)
        }
    }
    
    func updateWithJoke(joke: Joke) {
        self.joke = joke
        self.favJokeLabel.text = joke.text
    }
}
