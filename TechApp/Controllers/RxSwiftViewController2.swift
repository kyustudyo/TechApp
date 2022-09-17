//
//  RxSwiftViewController2.swift
//  TechApp
//
//  Created by 이한규 on 2022/02/04.
//

import Foundation
import UIKit
import SnapKit

class RxSwiftViewController2: UITableViewController {
    
    private let reuseIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .brown
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
        
        tableView.register(RxSwift2Cell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 50
    }
    
    @objc private func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? RxSwift2Cell else {return UITableViewCell()}
        cell.label1.text = "q"
        cell.label2.text = "vv"
        return cell
    }
}
class RxSwift2Cell:UITableViewCell {
    
    var label1: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "hi"
        return label
    }()
    
    var label2: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "bye"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [label1,label2])
        label1.snp.makeConstraints{
            $0.leading.equalTo(stack.snp_leadingMargin).offset(16)
        }
        label2.snp.makeConstraints{
            $0.leading.equalTo(stack.snp_leadingMargin).offset(16)
        }
        stack.axis = .vertical
        stack.spacing = 8
        addSubview(stack)
        stack.snp.makeConstraints{
            $0.center.equalTo(contentView.center)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
