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
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    var colorCanvasView: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialSettings()
        setupSlidersValues(for: redColorSlider, greenColorSlider, blueColorSlider)
        setupLabelsValues(for: redColorValueLabel, greenColorValueLabel, blueColorValueLabel)
        setupTextFields(for: redColorTextField, greenColorTextField, blueColorTextField)
        setupColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func SliderAction(_ sender: UISlider) {
        setupColor()
        switch sender {
        case redColorSlider:
            redColorValueLabel.text = string(from: sender)
            redColorTextField.text = string(from: sender)
        case greenColorSlider:
            greenColorValueLabel.text = string(from: sender)
            greenColorTextField.text = string(from: sender)
        default:
            blueColorValueLabel.text = string(from: sender)
            blueColorTextField.text = string(from: sender)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        if let color = canvasView.backgroundColor {
            delegate.setNewColor(for: color)
        }
        dismiss(animated: true)
    }
}
    
// MARK: - Private Methods
private extension SettingsViewController {
    
    func setupColor() {
        canvasView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    func setupLabelsValues(for colorLabels: UILabel...) {
        colorLabels.forEach { label in
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
    
    func setupTextFields(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redColorTextField:
                redColorTextField.text = string(from: redColorSlider)
            case greenColorTextField:
                greenColorTextField.text = string(from: greenColorSlider)
            default:
                blueColorTextField.text = string(from: blueColorSlider)
            }
        }
    }
    
    func setupSlidersValues(for sliders: UISlider...) {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        guard let color = canvasView.backgroundColor else { return }
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        sliders.forEach { slider in
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
    
    func setInitialSettings() {
        canvasView.layer.cornerRadius = 15
        canvasView.backgroundColor = colorCanvasView
        textFieldDelegate(for: redColorTextField, greenColorTextField, blueColorTextField)
        addToolBar(for: redColorTextField, greenColorTextField, blueColorTextField)
    }
    
    func textFieldDelegate(for textfields: UITextField...) {
        for textField in textfields {
            textField.delegate = self
        }
    }
    
    func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
    
    func sliderAnimation(for value: Float) {
        UIView.animate(withDuration: 0.3, animations: {
          self.redColorSlider.setValue(value, animated:true)
        })
    }
    
    func addToolBar(for textFields: UITextField...) {
        let toolBar = createToolBar()
        for textField in textFields {
            textField.inputAccessoryView = toolBar
        }
    }
    
    func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: UIScreen.main.bounds.size.width,
                height: 38.0
            )
        )
        let flexible = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(donePressed)
        )
        
        toolBar.setItems([flexible, doneButton], animated: false)
        
        return toolBar
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
}

//MARK: UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            
        switch textField {
        case redColorTextField:
            guard let redColorTF = redColorTextField.text else { return }
            guard let redTF = Float(redColorTF) else { return }
            sliderAnimation(for: redTF)
            redColorValueLabel.text = String(redColorTF)
        case greenColorTextField:
            guard let greenColorTF = greenColorTextField.text else { return }
            guard let greenTF = Float(greenColorTF) else { return }
            sliderAnimation(for: greenTF)
            greenColorValueLabel.text = String(greenColorTF)
        default:
            guard let blueColorTF = blueColorTextField.text else { return }
            guard let blueTF = Float(blueColorTF) else { return }
            sliderAnimation(for: blueTF)
            blueColorValueLabel.text = String(blueColorTF)
        }
        setupColor()
    }
}

// MARK: - UIAlertController
extension SettingsViewController {
    private func showAlert(withTitle title: String, andMessage message: String, for textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
