//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Roman Lantsov on 06.02.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet var canvasView: UIView!
    
    @IBOutlet var redColorValueLabel: UILabel!
    @IBOutlet var greenColorValueLabel: UILabel!
    @IBOutlet var blueColorValueLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    var colorCanvasView: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialSettings()
        setupSlidersValues(for: redColorSlider, greenColorSlider, blueColorSlider)
        setupLabelsValues(for: redColorValueLabel, greenColorValueLabel, blueColorValueLabel)
        setupColor()
    }
    
    @IBAction func SliderAction(_ sender: UISlider) {
        setupColor()
        switch sender {
        case redColorSlider:
            redColorValueLabel.text = string(from: sender)
        case greenColorSlider:
            greenColorValueLabel.text = string(from: sender)
        default:
            blueColorValueLabel.text = string(from: sender)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
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
    
    private func setupLabelsValues(for colorValueLabels: UILabel...) {
        colorValueLabels.forEach { label in
            switch label {
            case redColorValueLabel:
                redColorValueLabel.text = string(from: redColorSlider)
            case greenColorValueLabel:
                greenColorValueLabel.text = string(from: greenColorSlider)
            default:
                blueColorValueLabel.text = string(from: blueColorSlider)
            }
        }
    }
    
    private func setupSlidersValues(for slidersValue: UISlider...) {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        guard let color = canvasView.backgroundColor else { return }
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        slidersValue.forEach { slider in
            switch slider {
            case redColorSlider:
                redColorSlider.value = Float(red)
            case greenColorSlider:
                greenColorSlider.value = Float(green)
            default:
                blueColorSlider.value = Float(blue)
            }
        }
    }
    
    private func setInitialSettings() {
        canvasView.layer.cornerRadius = 15
        canvasView.backgroundColor = colorCanvasView
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }

}



