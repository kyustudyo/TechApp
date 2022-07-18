//
//  inputContainerView.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import UIKit

class InputContainerView : UIView {
    init(textField: UITextField) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let lable = UILabel()
        addSubview(lable)
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textColor = .black
        lable.centerY(inView: self)
        lable.anchor(left:self.leftAnchor,bottom: bottomAnchor,paddingLeft: 4)
        lable.text = "년도입력:"
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: lable.rightAnchor, bottom: bottomAnchor, paddingLeft: 4, paddingBottom:  -4)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
