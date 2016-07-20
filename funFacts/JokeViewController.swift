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
    
    let chuckModel = ChuckModel()
    var isLight = false
    var punchSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLightColor()
        funFactLabel.text = chuckModel.getRandomJoke()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chuckTitleAnimation(sender: AnyObject) {
        
        chuckTitle.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(2.0,
                                   delay: 0,
                                   usingSpringWithDamping: 0.2,
                                   initialSpringVelocity: 6.0,
                                   options: UIViewAnimationOptions.AllowUserInteraction,
                                   animations: {
                                    self.chuckTitle.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        if let text = funFactLabel.text {
            let share = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            presentViewController(share, animated: true, completion: nil)
        }
    }
    
    @IBAction func showFunFact() {
        let randomColor: UIColor = .randomColor()
        
        view.backgroundColor = randomColor
        funFactButton.setTitleColor(randomColor, forState: .Normal)
        funFactLabel.text = chuckModel.getRandomJoke()
        
        isLightColor()
        punchAnimation()
        playPunchSound()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func isLightColor() {
        
        let color = view.backgroundColor
        
        let componentColors = CGColorGetComponents(color!.CGColor)
        
        let colorBrightness: CGFloat = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000
        
        if (colorBrightness >= 0.5) {
            isLight = true
            NSLog("Background color is light \(colorBrightness)")
            chuckTitle.titleLabel!.textColor = .blackColor()
            funFactLabel.textColor = .blackColor()
        } else {
            isLight = false
            NSLog("Background color is dark \(colorBrightness)")
            chuckTitle.titleLabel!.textColor = .whiteColor()
            funFactLabel.textColor = .whiteColor()
        }
    }
    
    func punchAnimation() {
        
        punchImage.hidden = false
        funFactLabel.hidden = true
        funFactButton.userInteractionEnabled = false
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
        }
    }
    
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
}

