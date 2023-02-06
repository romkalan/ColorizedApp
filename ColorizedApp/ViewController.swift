//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Roman Lantsov on 06.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var canvasView: UIView!
    
    @IBOutlet var redColorValueLabel: UILabel!
    @IBOutlet var greenColorValueLabel: UILabel!
    @IBOutlet var blueColorValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.layer.cornerRadius = 10
    }


    @IBAction func redColorSlider() {
    }
    
    @IBAction func greenColorSlider() {
    }
    
    @IBAction func blueColorSlider() {
    }
}

