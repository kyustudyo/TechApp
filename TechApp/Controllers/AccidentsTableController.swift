//
//  AccidentsTableView.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import Foundation
import UIKit



private let reuseIdentifier = "AccidentCell"

protocol AccidentControllerDelegate: AnyObject {
    func controller(vm : LocationAndInjuredViewModel)
}

class AccidentsTableController : UIViewController {
    
    // MARK : Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var locationAndInjuredViewModels :[LocationAndInjuredViewModel] = [LocationAndInjuredViewModel(locationInjured: LocationInjuredDTO.Dummy)]
    weak var delegate:AccidentControllerDelegate?
    
    // MARK : Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
        FirebaseWebservice.fetchAllAccident { [weak self] accidents in
            self?.showLoader(false)
            self?.locationAndInjuredViewModels = accidents.map{LocationAndInjuredViewModel(locationInjured: $0)}
            self?.tableView.reloadData()
        }
        
//        JsonWebservice.getitem(year: 2018) { [weak self] vm in
//            self?.showLoader(false)
//            self?.accidentViewModels.append(vm)
//            self?.tableView.reloadData()
//        }
    }
    
    // MARK : Helpers
    
    func configureUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addAccident))
    }
    
    func configureTableView(){
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccidentCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.rowHeight = 80
    }
}

extension AccidentsTableController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationAndInjuredViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccidentCell
        cell.accidentViewModel = locationAndInjuredViewModels[indexPath.row]
        
        let label = UILabel.init(frame: CGRect(x:0,y:0,width:50,height:cell.frame.height/3))
        label.text = "saved"
        cell.accessoryView = label
        cell.accessoryView?.isHidden = true
        cell.selectionStyle = .none
        
        return cell
    }
}

extension AccidentsTableController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryView?.isHidden == false {
            cell?.accessoryView?.isHidden.toggle()
        } else {
            cell?.accessoryView?.isHidden = false
        }
        
        delegate?.controller(vm: locationAndInjuredViewModels[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryView?.isHidden = true
    }
    
}

extension AccidentsTableController: UITableViewDelegate, UITableViewDataSource {
}

//Delegate를 통한 data 전달.
extension AccidentsTableController: AddAcidentDelegate {
    func addAccidentAndSave( vm: LocationAndInjuredViewModel) {
        dismiss(animated: true, completion: nil)
        
        let data = ["location":vm.location, "injured":vm.injured] as [String:Any]
        let uuid = UUID().uuidString
        COLLECTION_ACCIDENT.document(uuid).setData(data) { error in
            if let error = error { print(error.localizedDescription)
                return
            }
        }
        self.fetchAccidents()
        
    }
}
