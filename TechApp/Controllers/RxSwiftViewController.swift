//
//  RxSwiftViewController.swift
//  TechApp
//
//  Created by 이한규 on 2022/01/26.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxBinding

class RxSwiftViewController : UIViewController{
    private let disposeBag = DisposeBag()
    private let textFeild: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Input text here."
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.becomeFirstResponder()
        return textField
    }()
    private let countLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let viewModel = RxSwiftViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureRxSwift()
        view.backgroundColor = .white
        view.addSubview(textFeild)
        view.addSubview(countLabel)
        createConstraints()
        
    }
    private func configureNavigationBar(){
        navigationItem.title = "RxSwift + SnapKit"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
    }
    private func configureRxSwift(){
        textFeild.rx.text ~> viewModel.text ~
        viewModel.textCount ~> countLabel.rx.text ~
        disposeBag
    }
    @objc private func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    private func createConstraints(){
       
        textFeild.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(80)
            $0.height.equalTo(50)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textFeild.snp.bottom).offset(10)
        }
        
        
    }
    
    
}

