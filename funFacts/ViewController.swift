//
//  ViewController.swift
//  funFacts
//
//  Created by Parker Donat on 1/27/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var colorModel = ColorModel()
    
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!
    @IBOutlet weak var chuckTitle: UILabel!
    @IBOutlet weak var punchImage: UIImageView!
    let chuckModel = ChuckModel()
    var isLight = false
    var punchSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLightColor()
        funFactLabel.text = chuckModel.getRandomJoke()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showFunFact() {
        let randomColor: UIColor = .randomColor()
        
        view.backgroundColor = randomColor
        funFactButton.setTitleColor(randomColor, forState: .Normal)
        funFactLabel.text = chuckModel.getRandomJoke()
        
        isLightColor()
        punchAnimation()
        playPunchSound()
    }
    
    func isLightColor() {
        
        let color = view.backgroundColor
        
        let componentColors = CGColorGetComponents(color!.CGColor)
        
        let colorBrightness: CGFloat = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000
        
        if (colorBrightness >= 0.5) {
            isLight = true
            NSLog("Background color is light \(colorBrightness)")
            chuckTitle.textColor = .blackColor()
            funFactLabel.textColor = .blackColor()
        } else {
            isLight = false
            NSLog("Background color is dark \(colorBrightness)")
            chuckTitle.textColor = .whiteColor()
            funFactLabel.textColor = .whiteColor()
        }
    }
    
    func punchAnimation() {
        
        punchImage.hidden = false
        self.punchImage.alpha = 1.0
        punchImage.frame = CGRect(x: 250, y: 250, width: 0, height: 0)
        
        let rotationTransform = CGAffineTransformMakeRotation(CGFloat(0.5))
        let scaleTransform = CGAffineTransformMakeScale(13, 13)
        
        UIView.animateWithDuration(0.15, delay: 0.0, options: [.CurveEaseIn, .Autoreverse], animations: {
            
            self.punchImage.transform = CGAffineTransformConcat(rotationTransform, scaleTransform)
            self.punchImage.frame = CGRect(x: 0, y: 100, width: 500, height: 350)
            self.punchImage.alpha = 0
            
        }) { (_) in
            self.punchImage.hidden = true
        }
        
    }
    
    func playPunchSound() {
        let path = NSBundle.mainBundle().pathForResource("punch.wav", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            punchSound = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
    }
}

