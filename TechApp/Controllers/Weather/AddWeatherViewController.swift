//
//  AddCityViewController.swift
//  TechApp
//
//  Created by 이한규 on 2022/02/05.
//

import Foundation
import UIKit
class AddWeatherViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
