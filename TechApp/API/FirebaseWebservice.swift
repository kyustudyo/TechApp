//
//  FirebaseWebservice.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import Foundation
import Firebase

class FirebaseWebservice {
    
    static func saveCurrentAccident(vm: LocationAndInjuredViewModel, completion: @escaping () -> ()) {
        let data = ["location":vm.location, "injured":vm.injured] as [String:Any]
        COLLECTION_CURRENT_ACCIDENT.document("current").setData(data) { error in
            if let error = error { print(error.localizedDescription)
                completion()
                return
            }
        }
        completion()
    }
    
    static func fetchMyInfo(completion: @escaping (MyInformation)->Void) {
        let _ = COLLECTION_MYINFO.document("itsMe").getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let info = MyInformation.init(dictionary: dictionary)
            completion(info)
        }
    }
    
    static func fetchAccident(completion: @escaping (LocationInjuredDTO)->Void) {
        let _ = COLLECTION_ACCIDENT.document("data").getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let accident = LocationInjuredDTO(dictionary: dictionary)
            completion(accident)
        }
    }
    
    static func fetchCurrentAccident(completion: @escaping (LocationInjuredDTO)->Void) {
        let _ = COLLECTION_CURRENT_ACCIDENT.document("current").getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let accident = LocationInjuredDTO(dictionary: dictionary)
            completion(accident)
        }
    }
    
    static func fetchAllAccident(completion: @escaping ([LocationInjuredDTO]) -> Void) {
        COLLECTION_ACCIDENT.getDocuments { snapshot, error in
            print("개수", snapshot?.documents)//3개나왔다는것은 3명이있다는것.
            guard let accidents = snapshot?.documents.map({ s in
                LocationInjuredDTO(dictionary: s.data())
            }) else { return }
            completion(accidents)
        }
    }
}
