//
//  ViewController.swift
//  funFacts
//
//  Created by Parker Donat on 1/27/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var colorModel = ColorModel()
    let gradientLayer = CAGradientLayer()

    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!
    let chuckModel = ChuckModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funFactLabel.text = chuckModel.getRandomJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showFunFact() {
        //let randomColor: UIColor = ColorModel().getRandomColor()
        let randomColor: UIColor = colorModel.getRandomColor()

        view.backgroundColor = randomColor
        funFactButton.setTitleColor(randomColor, forState: .Normal)
        funFactLabel.text = chuckModel.getRandomJoke()
    }
}
