//
//  Info.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//

import Foundation

struct MyInformation {
    let name: String
    let field: String
    let company: String
    let contents: String
    //이미지를 위해 any로 두자.
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""//type casting
        self.field = dictionary["field"] as? String ?? ""
        self.company = dictionary["company"] as? String ?? ""
        self.contents = dictionary["contents"] as? String ?? ""
    }
}//가고 오게될 모형.

