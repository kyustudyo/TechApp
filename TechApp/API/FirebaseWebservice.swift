//
//  FirebaseWebservice.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import Foundation
import Firebase

class FirebaseWebservice {
    static func fetchMyInfo(completion: @escaping (MyInformation)->Void) {
        let _ = COLLECTION_MYINFO.document("itsMe").getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let info = MyInformation.init(dictionary: dictionary)
            completion(info)
        }
    }
    
    static func fetchAccident(completion: @escaping (LocationInjured)->Void) {
        let _ = COLLECTION_ACCIDENT.document("data").getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let accident = LocationInjured(dictionary: dictionary)
            completion(accident)
        }
    }
}
