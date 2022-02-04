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
    
    var topConstraint: Constraint? = nil
    var leftConstraint: Constraint? = nil
    
    private let textFeild: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Input text here."
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
//        textField.becomeFirstResponder()
        return textField
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let constraintLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.backgroundColor = .red
        label.text = "test label"
        return label
    }()
    
    private let deactivateConstraintButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray
        button.setTitle("deactivate", for: .normal)
//        button.addTarget(self, action: #selector(applyConstraint), for: .touchUpInside)
        button.titleLabel?.textColor = .black
        return button
    }()
    
    private let activateConstraintButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .brown
        button.setTitle("activate", for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(applyConstraint2), for: .touchUpInside)
        return button
    }()
    
    private let updateConstraintButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .cyan
        button.setTitle("update", for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(applyConstraint3), for: .touchUpInside)
        return button
    }()
    
    private let remakeConstraintButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .magenta
        button.setTitle("remake", for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(applyConstraint4), for: .touchUpInside)
        return button
    }()
    
    
    lazy var ProgressView: UIView = {
      let v = UIView(frame: .zero)
      v.backgroundColor = .systemGray
      return v
    }()
    
    private let viewModel = RxSwiftViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        view.backgroundColor = .white
        view.addSubview(textFeild)
        view.addSubview(countLabel)
        view.addSubview(ProgressView)
        view.addSubview(constraintLabel)
        
        createConstraints()
        configureRxSwift()
        
    }
    
    private func configureNavigationBar(){
        navigationItem.title = "RxSwift + SnapKit experiment"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
    }
    
    private func configureRxSwift(){
        textFeild.rx.text ~> viewModel.text ~
        viewModel.textCount ~> countLabel.rx.text
        ~
        disposeBag
        
        viewModel.textCount.subscribe(onNext:{
            self.updateProgress(to: $0)
        }).disposed(by: disposeBag)
        
        //rx instead of adding target.
        deactivateConstraintButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .subscribe(onNext:{
                self.topConstraint?.deactivate()
                self.leftConstraint?.deactivate()
            }).disposed(by: disposeBag)
    }
    
    
    
    private func createConstraints(){
        
        textFeild.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(160)
            $0.height.equalTo(50)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textFeild.snp.bottom).offset(10)
        }
        
        ProgressView.snp.makeConstraints{
            $0.top.equalTo(countLabel.snp_bottomMargin).offset(8)
            $0.width.equalToSuperview().multipliedBy(0.1)
            $0.height.equalTo(16)
            $0.leading.equalToSuperview()
        }
        constraintLabel.snp.makeConstraints { (make) -> Void in
            self.topConstraint = make.top.equalTo(ProgressView.snp_bottomMargin).offset(20).constraint
            
            self.leftConstraint =  make.left.equalTo(ProgressView.snp_leftMargin).offset(50).constraint
            
            make.height.equalTo(80)
        }
        let stack = UIStackView(arrangedSubviews: [deactivateConstraintButton,activateConstraintButton,updateConstraintButton,remakeConstraintButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        view.addSubview(stack)
        
        stack.snp.makeConstraints{
            $0.top.equalTo(constraintLabel.snp_bottomMargin).offset(80)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
                    }
        
        
    }
    
// MARK: - Helpers
//    @objc func applyConstraint(){
//        topConstraint?.deactivate()
//        leftConstraint?.deactivate()
//    }
    @objc func applyConstraint2(){
        topConstraint?.activate()
        leftConstraint?.activate()
    }
    @objc func applyConstraint3(){
        topConstraint?.update(offset: 10)
    }
    @objc func applyConstraint4(){//remove original one and make new
        constraintLabel.snp.remakeConstraints{make in
            self.topConstraint = make.top.equalTo(ProgressView.snp_bottomMargin).offset(120).constraint
            
            self.leftConstraint =  make.left.equalTo(ProgressView.snp_leftMargin).offset(120).constraint
        }
        
    }
    private func updateProgress(to progress: String) {
        let value = progress.ToDouble()
        ProgressView.snp.remakeConstraints{ make in
            make.top.equalTo(countLabel.snp_bottomMargin).offset(8)
            make.width.equalToSuperview().multipliedBy(value/30)
            make.height.equalTo(16)
            make.leading.equalToSuperview()
        }
    }
    
    @objc private func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
}




//// when making constraints
//
//
//...
//// then later you can call
//self.topConstraint.deactivate()
//
//// or if you want to update the constraint
//self.topConstraint.updateOffset(5)
