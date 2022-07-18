//
//  CustomTextField.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import UIKit

class CustomTextField: UITextField,UITextFieldDelegate {
    
    init(placeholder:String) {
        super.init(frame: .zero)
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .black
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor:UIColor.gray])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
