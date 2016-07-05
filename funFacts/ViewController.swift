//
//  ViewController.swift
//  funFacts
//
//  Created by Parker Donat on 1/27/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    let randomColor: UIColor = ColorModel().getRandomColor()

    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!
    let factModel = FactModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funFactLabel.text = factModel.getRandomFact()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showFunFact() {
        //let randomColor: UIColor = ColorModel().getRandomColor()
        view.backgroundColor = randomColor
        funFactButton.setTitleColor(randomColor, forState: .Normal)
        funFactLabel.text = factModel.getRandomFact()
    }
}
