//
//  CustomView.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//



import UIKit
import SDWebImage

class AccidentCell: UITableViewCell {
    
    // MARK : Properties
    
    var accidentViewModel: AccidentViewModel? {
        didSet{ configure()}
    }
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = " "
        return label
    }()
    
    private let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = " "
        return label
    }()
    
    // MARK : Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let stack = UIStackView(arrangedSubviews: [usernameLabel,fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 5
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK : Helpers
    
    func configure(){
        guard let viewModel = accidentViewModel else {return}
        usernameLabel.text = viewModel.resultLocation
        fullnameLabel.text = "중상자 수: \(viewModel.resultInjured ?? 0) 명"
        
    }
}
