//
//  Constants.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//

import Foundation
import Firebase

let COLLECTION_MYINFO = Firestore.firestore().collection("itsMe")
let COLLECTION_ACCIDENT = Firestore.firestore().collection("AccidentData")

struct Constants {
    struct Urls {
        static func urlForAccidents(year:Int) -> URL {
            return URL(string: "http://apis.data.go.kr/B552061/frequentzoneLgrViolt/getRestFrequentzoneLgrViolt?serviceKey=xcraiAie%2B%2BqlR28qjyPHeGg0vqw2LvqRqZ4lap%2Fsg8aS05rGuOBVWiUSVbD%2FMKLWvddDXqw9HZGrgvMHVlc1CQ%3D%3D&searchYearCd=\(year)&siDo=11&guGun=650&type=json&numOfRows=1&pageNo=1")!
        }
    }
}


