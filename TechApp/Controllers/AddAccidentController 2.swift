//
//  AddAccident.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import UIKit

protocol AddAcidentDelegate : class {
    func addAccidentAndSave(vm: AccidentViewModel)
}

class AddAcidentController :UIViewController {
    
    // MARK - Properties
    
    private var accidentVM :AccidentViewModel?
    var delegate : AddAcidentDelegate?
    
    private let addLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.text = "추가 될 내용: "
        return lbl
    }()
    
    private let addContents : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = ""
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let yearTextField = CustomTextField(placeholder: " 예시) 2013")
    private var yearContainerView : InputContainerView {//lazy가능
        return InputContainerView(textField: yearTextField)
    }
    
    private let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setWidth(width: 100)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkAccident), for: .touchUpInside)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setWidth(width: 100)
        button.setTitle("추가", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(addAccident), for: .touchUpInside)
        return button
    }()
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        helperFunction()
    }
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar(withTitle: "Add Accidents")
    }
    
    // MARK - Selector
    
    @objc func dismissal(){
        dismiss(animated: true, completion: nil)
    }
    @objc func checkAccident(){
        guard let year = yearTextField.text else {return}
        guard let year = Int(year) else {
            self.addContents.text = "Only number allowded"
            self.addButton.isHidden = true
            return}
        showLoader(true)
        JsonWebservice.getitem(year: year) { [weak self] vm in
            self?.showLoader(false)
            self?.addButton.isHidden = vm.isThereData!//데이터가 있으면 보이기.
            self?.accidentVM = vm
            self?.addContents.text = vm.resultLocation
        }
    }
    
    @objc func addAccident(){
        guard let vm = accidentVM else {return}
        self.delegate?.addAccidentAndSave(vm: vm )
        print("this is vm")
        print(vm)
        
    }
    
    // MARK - Helper
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissal))
        let vStack = UIStackView(arrangedSubviews: [yearContainerView])
        vStack.axis = .vertical
        vStack.spacing = 16
        view.addSubview(vStack)
        vStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.safeAreaLayoutGuide.leftAnchor,right: view.rightAnchor,paddingTop: 16,paddingLeft: 16,paddingRight: 32)
        view.addSubview(checkButton)
        checkButton.centerY(inView: vStack)
        checkButton.anchor(right:view.safeAreaLayoutGuide.rightAnchor, paddingRight: 10)
        let Hstack = UIStackView(arrangedSubviews: [addLabel,addContents])
        
        Hstack.axis = .horizontal
        Hstack.spacing = 5
        view.addSubview(Hstack)
        Hstack.setHeight(height: 50)
        Hstack.anchor(top:vStack.bottomAnchor,left: view.safeAreaLayoutGuide.leftAnchor, right: view.rightAnchor,paddingTop: 20,paddingLeft: 16,paddingRight: 10)
        view.addSubview(addButton)
        addButton.centerX(inView: Hstack)
        addButton.anchor(top:Hstack.bottomAnchor,paddingTop: 16)
    }
    
    func helperFunction() {
        yearTextField.delegate = self
    }
}

extension AddAcidentController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let currentString: NSString = textField.text! as NSString
           let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
           return newString.length <= 8
       }
}
