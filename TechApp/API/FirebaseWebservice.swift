//
//  FirebaseWebservice.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import Foundation
import Firebase

//result 이용하자.
class FirebaseWebservice {
    static func fetchMyInfo(completion: @escaping (MyInformation)->Void) {
        let query = COLLECTION_MYINFO.document("itsMe").getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            //print(dictionary)
            let info = MyInformation.init(dictionary: dictionary)
            //print(info)
            
            completion(info)
        }
    }
    
    static func fetchAccident(completion: @escaping (multipleInfo)->Void){
        let query = COLLECTION_ACCIDENT.document("data").getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let accident = multipleInfo(dictionary: dictionary)
            completion(accident)
            
        }
    }
}
