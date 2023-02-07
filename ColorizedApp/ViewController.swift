//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Roman Lantsov on 06.02.2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var canvasView: UIView!
    
    @IBOutlet var redColorValueLabel: UILabel!
    @IBOutlet var greenColorValueLabel: UILabel!
    @IBOutlet var blueColorValueLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redColorSlider.value = 0.05
        greenColorSlider.value = 0.27
        blueColorSlider.value = 0.49
        canvasView.layer.cornerRadius = 15
        setupColor()
    }

    @IBAction func redColorSliderAction() {
        redColorValueLabel.text = String(format: "%.2f", redColorSlider.value)
        setupColor()
    }

    @IBAction func greenColorSliderAction() {
        greenColorValueLabel.text = String(format: "%.2f", greenColorSlider.value)
        setupColor()
    }
    
    @IBAction func blueColorSliderAction() {
        blueColorValueLabel.text = String(format: "%.2f", blueColorSlider.value)
        setupColor()
    }
    
    // MARK: - Private Methods
    private func setupColor() {
        canvasView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
            )
    }
    
}



