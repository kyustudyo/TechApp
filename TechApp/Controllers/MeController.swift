//
//  MeController.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//


import Foundation
import Firebase
import UIKit

class MeViewController: UIViewController {//디스크에서 가져오기.
   
    // MARK - Properties
    
    @IBOutlet weak var imageVIew: UIImageView!
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
    
    @IBAction func GoRxSwift(_ sender: UIButton) {
        let controller = RxSwiftViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    
    @IBAction func fetchAccident(_ sender: UIButton) {
        showLoader(true)
        self.fetchAccidentFromFirebase{
            self.showLoader(false)
        }
        //showLoader(false)
    }

    private func fetchAccidentFromFirebase(completion : @escaping () -> Void){
        FirebaseWebservice.fetchAccident {  accident in
                self.locationAndInjuredVM = LocationAndInjuredViewModel(accident: accident)
            self.contents.text = self.contents.text +  "\n\(self.locationAndInjuredVM!.location)에서\n\(self.locationAndInjuredVM!.injured)명 사고 발생했습니다."
            completion()
            //self.showLoader(false)
            
        }
    }
}

extension MeViewController : AccidentControllerDelegate {
    func controller( vm: AccidentViewModel) {
        guard let resultInjured = vm.resultInjured , let resultLocation = vm.resultLocation else {return}
        let data = ["location":resultLocation,"injured":resultInjured] as [String:Any]
        //hash형태로
       COLLECTION_ACCIDENT.document("data").setData(data) { error in
            if let error = error { print(error.localizedDescription)
                return
            }
        }
    }
}







