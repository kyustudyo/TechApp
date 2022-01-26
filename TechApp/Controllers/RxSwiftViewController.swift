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
        createConstraints()
        configureRxSwift()
        
        
    }
    
    private func configureNavigationBar(){
        navigationItem.title = "RxSwift + SnapKit"
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
        
        ProgressView.snp.makeConstraints{
            $0.top.equalTo(countLabel.snp_bottomMargin).offset(8)
            $0.width.equalToSuperview().multipliedBy(0.1)
            $0.height.equalTo(16)
            $0.leading.equalToSuperview()
        }
    }
    
// MARK: - Helpers
    
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

