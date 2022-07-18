//
//  MeController.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//

import Foundation
import Firebase


import UIKit
import Foundation

class MeViewController: UIViewController {
    
    // MARK - Properties
    
    @IBOutlet var name: UILabel?
    @IBOutlet var field: UILabel?
    @IBOutlet var company: UILabel?
    @IBOutlet var contents: UITextView!
    private var locationAndInjuredVM : LocationAndInjuredViewModel?
    private var myInformationVM: MyInfoViewModel?
   
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK - API
    
    func fetchUser() {
        showLoader(true)
        FirebaseWebservice.fetchMyInfo { myInfo in
            self.myInformationVM = MyInfoViewModel(myInfo)
            self.showLoader(false)
            self.name?.text = self.myInformationVM?.name
            self.company?.text = self.myInformationVM?.company
            self.contents?.text = self.myInformationVM?.contents
            self.field?.text = self.myInformationVM?.field
        }
    }

    // MARK  - Helper
    
    @IBAction func goToAccident(_ sender: UIButton) {
        let controller = AccidentsTableController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func fetchAccident(_ sender: UIButton) {
        showLoader(true)
        self.fetchAccidentFromFirebase()
        showLoader(false)
    }

    private func fetchAccidentFromFirebase(){
        FirebaseWebservice.fetchAccident {  accident in
                self.locationAndInjuredVM = LocationAndInjuredViewModel(accident: accident)
            self.contents.text = self.contents.text +  "\n\(self.locationAndInjuredVM!.location)에서\n\(self.locationAndInjuredVM!.injured)명 사고 발생했습니다."
            
        }
    }
}

extension MeViewController : AccidentControllerDelegate {
    func controller( vm: AccidentViewModel) {
        guard let resultInjured = vm.resultInjured , let resultLocation = vm.resultLocation else {return}
        let data = ["location":resultLocation,"injured":resultInjured] as [String:Any]
       COLLECTION_ACCIDENT.document("data").setData(data) { error in
            if let error = error { print(error.localizedDescription)
                return
            }
        }
    }
}







