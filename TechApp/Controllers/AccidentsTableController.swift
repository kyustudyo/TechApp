//
//  AccidentsTableView.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import Foundation
import UIKit



private let reuseIdentifier = "AccidentCell"
protocol AccidentControllerDelegate: class {
    func controller(vm : AccidentViewModel)
}

class AccidentsTableController : UITableViewController {
    
    // MARK : Properties
    
    var accdients : [AccidentViewModel] = [AccidentViewModel]()
    weak var delegate: AccidentControllerDelegate?
    
    // MARK : Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchAccidents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Accidents")
    }
    
    // MARK : Selector
    
    @objc func dismissal(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addAccident(){
        let controller = AddAcidentController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .automatic
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK : API
    
    func fetchAccidents(){
        showLoader(true)
        JsonWebservice.getitem(year: 2018) { [weak self] vm in
            self?.showLoader(false)
            self?.accdients.append(vm)
            self?.tableView.reloadData()
        }
    }
    
    // MARK : Helpers
    
    func configureUI(){
        configureTableView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addAccident))
    
    }
    
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.register(AccidentCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
}

extension AccidentsTableController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accdients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccidentCell
        cell.accidentViewModel = accdients[indexPath.row]
        let label = UILabel.init(frame: CGRect(x:0,y:0,width:50,height:cell.frame.height/3))
            label.text = "saved"
            cell.accessoryView = label
        cell.accessoryView?.isHidden = true
        return cell
    }
}

extension AccidentsTableController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryView?.isHidden == false {
            cell?.accessoryView?.isHidden.toggle()
        } else {
            cell?.accessoryView?.isHidden = false
        }
        delegate?.controller(vm: accdients[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryView?.isHidden = true
    }
    
}

extension AccidentsTableController : AddAcidentDelegate {
    func addAccidentAndSave( vm: AccidentViewModel) {
        dismiss(animated: true, completion: nil)
        self.accdients.append(vm)
        tableView.reloadData()
    }
}
