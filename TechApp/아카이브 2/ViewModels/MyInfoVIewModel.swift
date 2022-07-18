//
//  MyInfoVIewModel.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/28.
//

import Foundation
struct MyInfoViewModel {
    private let myInformation: MyInformation
}

extension MyInfoViewModel {
    init(_ myInformation: MyInformation) {
        self.myInformation = myInformation
    }
}

extension MyInfoViewModel {
    
    var name: String {
        return self.myInformation.name
    }//nil 발생안하므로 (?? "") 하지 않는다.
    
    var company: String {
        return self.myInformation.company
    }
    var contents: String {
        return self.myInformation.contents
    }
    var field: String {
        return self.myInformation.field 
    }
}
