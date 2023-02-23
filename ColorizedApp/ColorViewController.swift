//
//  ColorViewController.swift
//  ColorizedApp
//
//  Created by Roman Lantsov on 23.02.2023.
//

import UIKit

class ColorViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.colorCanvasView = view.backgroundColor
    }
    
}
