//
//  ColorViewController.swift
//  ColorizedApp
//
//  Created by Roman Lantsov on 23.02.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setNewColor(for color: UIColor)
}

final class ColorViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.colorCanvasView = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARL: SettingsViewControllerDelegate
extension ColorViewController: SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        self.view.backgroundColor = color
    }
}
