//
//  ViewController.swift
//  funFacts
//
//  Created by Parker Donat on 1/27/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class JokeViewController: UIViewController, UIGestureRecognizerDelegate {
    var colorModel = ColorModel()
    
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!
    @IBOutlet weak var punchImage: UIImageView!
    @IBOutlet weak var chuckTitle: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var lineBreak: UIView!
    @IBOutlet weak var starButton: DOFavoriteButton!
    
    let chuckModel = ChuckModel()
    var isLight = false
    var punchSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLightColor()
        
        // Fixes tap animation and adds kerning to text
        let title = chuckTitle.titleForState(.Normal)
        let attributedTitle = NSAttributedString(string: title!, attributes: [NSKernAttributeName: 2.5])
        chuckTitle.setAttributedTitle(attributedTitle, forState: .Normal)
        
        let randomColor: UIColor = .randomColor()
        view.backgroundColor = randomColor
        
        funFactLabel.text = chuckModel.getRandomJoke()
        funFactLabel.textColor = .whiteColor()
        
        addTapGesture()
        addSwipeGesture()
        
        // Star stapped animation
        starButton.addTarget(self, action: #selector(starButtonTappedForAnimation), forControlEvents: .TouchUpInside)
    }
    
    // HIDE STATUS BAR
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TAP GESTURE FOR JOKE FOR MENU
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(jokeTapped))
        funFactLabel.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    // MARK: -  SWIPE FOR NEW JOKE
    func addSwipeGesture() {
        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            funFactLabel.addGestureRecognizer(gesture)
        }
    }
    
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        print(sender.direction)
        showFunFact()
    }
    
    // MARK: - SHAKE FOR NEW JOKE
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if(motion == .MotionShake) {
            print("iPhone Shake Detected!")
            
            showFunFact()
        }
    }
    
    // MARK: - BUTTON TAP FOR NEW JOKE
    @IBAction func showFunFact() {
        let randomColor: UIColor = .randomColor()
        
        view.backgroundColor = randomColor
        funFactLabel.text = chuckModel.getRandomJoke()
        
        isLightColor()
        punchAnimation()
        playPunchSound()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    // MARK: - TAP TEXT FOR UIMENUCONTROLLER
    func jokeTapped(sender: UITapGestureRecognizer) {
        becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        let dismiss = UIMenuItem(title: "❌", action: #selector(dismissMenu))
        //let share = UIMenuItem(title: "Share", action: #selector(shareButtonTapped))
        let favorite = UIMenuItem(title: "⭐️", action: #selector(favoriteButtonTapped))
        //let trash = UIMenuItem(title: "🗑", action: #selector(trashJoke))
        menu.menuItems = [dismiss, favorite]
        menu.setTargetRect(CGRectMake(100, 0, 100, 100), inView: self.funFactLabel)
        menu.setMenuVisible(true, animated: true)
    }
    
    func dismissMenu() {
        // Cancel the menu
        // No extra code needed, dismisses automatically
    }
    
//    func shareButtonTapped(sourceView: UIView) {
//        if let text = funFactLabel.text {
//            let share = UIActivityViewController(activityItems: [text], applicationActivities: nil)
//            
//            //Excluded Activities
//            share.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeOpenInIBooks, UIActivityTypePrint, UIActivityTypePostToVimeo, UIActivityTypePostToWeibo, UIActivityTypePostToFlickr, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]
//            
//            //if iPhone
//            if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//                self.presentViewController(share, animated: true, completion: nil)
//            } else {
//                //if iPad
//                if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
//                    if share.respondsToSelector(Selector("popoverPresentationController")) {
//                        share.popoverPresentationController?.sourceView = self.view
//                    }
//                }
//            }
//            
//            self.presentViewController(share, animated: true, completion: nil)
//        }
//    }
    
    func favoriteButtonTapped(sender: DOFavoriteButton) {
        // Save favorite joke
        let favJoke = Joke(joke: self.funFactLabel.text!)
        JokeController.sharedInstance.addJoke(favJoke)
        
        // Star animation
        starButton.hidden = false
        starButton.sendActionsForControlEvents(.TouchUpInside)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: #selector(hideTheStar), userInfo: nil, repeats: false)
    }
    
    func hideTheStar() {
        starButton.sendActionsForControlEvents(.TouchUpInside)
        starButton.hidden = true
    }
    
    func starButtonTappedForAnimation(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
        }
    }
    
    //    func trashJoke() {
    //        // Prompt to make sure to permanantly delete
    //        // Delete Joke from joke array
    //    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        
        if action == #selector(dismissMenu) {
            return true
        }
//        if action == #selector(shareButtonTapped) {
//            return true
//        }
        if action == #selector(favoriteButtonTapped) {
            return true
        }
        //        if action == #selector(trashJoke) {
        //            return true
        //        }
        return false
    }
    
    // MARK: - BUTTON FOR FAV LIST
    @IBAction func favListButtonTapped(sender: AnyObject) {
        
    }
    
    // MARK: -  BUTTON FOR SHARING
    @IBAction func settingButtonTapped(sender: AnyObject) {
        if let text = funFactLabel.text {
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
            chuckTitle.titleLabel!.textColor = .blackColor()
            funFactLabel.textColor = .blackColor()
            lineBreak.backgroundColor = .blackColor()
            listButton.setImage(UIImage(named: "favorite_list_black"), forState: UIControlState.Normal)
            settingsButton.setImage(UIImage(named: "share_black"), forState: UIControlState.Normal)
        } else {
            isLight = false
            NSLog("Background color is dark \(colorBrightness)")
            chuckTitle.titleLabel!.textColor = .whiteColor()
            funFactLabel.textColor = .whiteColor()
            lineBreak.backgroundColor = .whiteColor()
            listButton.setImage(UIImage(named: "favorite_list_white"), forState: UIControlState.Normal)
            settingsButton.setImage(UIImage(named: "share_white"), forState: UIControlState.Normal)
        }
    }
    
    // MARK: - TAP ANIMATIONS
    @IBAction func chuckTitleAnimation(sender: AnyObject) {
        
        chuckTitle.transform = CGAffineTransformMakeScale(0.1, 0.1)
        lineBreak.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(2.0,
                                   delay: 0,
                                   usingSpringWithDamping: 0.2,
                                   initialSpringVelocity: 6.0,
                                   options: UIViewAnimationOptions.AllowUserInteraction,
                                   animations: {
                                    self.chuckTitle.transform = CGAffineTransformIdentity
                                    self.lineBreak.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    func punchAnimation() {
        
        punchImage.hidden = false
        funFactLabel.hidden = true
        funFactButton.userInteractionEnabled = false
        funFactLabel.userInteractionEnabled = false
        self.punchImage.alpha = 1.0
        punchImage.frame = CGRect(x: 250, y: 250, width: 0, height: 0)
        
        let scaleTransform1 = CGAffineTransformMakeScale(50, 50)
        let scaleTransform2 = CGAffineTransformMakeScale(1, 1)
        
        UIView.animateWithDuration(0.5, animations: {
            self.punchImage.transform = CGAffineTransformConcat(scaleTransform1, scaleTransform2)
            self.punchImage.frame = CGRect(x: 0, y: 100, width: 500, height: 350)
            self.punchImage.transform = CGAffineTransformIdentity
        }) { (_) in
            self.punchImage.hidden = true
            self.funFactLabel.hidden = false
            self.funFactButton.userInteractionEnabled = true
            self.funFactLabel.userInteractionEnabled = true
        }
    }
    
    // MARK: - SOUNDS
    func playPunchSound() {
        let path = NSBundle.mainBundle().pathForResource("punch_edit.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            punchSound = sound
            sound.play()
        } catch {
            print("Couldn't load file :(")
        }
    }
    
    func getCurrentBackgroundColor() -> UIColor {
        let currentColor = view.backgroundColor
        return currentColor!
    }
    
    // MARK: - NAVIGATION
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toList" {
            guard let favsListTableViewController = segue.destinationViewController as? FavsListTableViewController else { return }
            favsListTableViewController.navigationItem.title = "Favorites"
            favsListTableViewController.currentColor = getCurrentBackgroundColor()
        }
    }
}

