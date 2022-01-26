//
//  RxSwiftViewModel.swift
//  TechApp
//
//  Created by 이한규 on 2022/01/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxBinding

struct RxSwiftViewModel {
    var text = BehaviorRelay<String?>(value: nil)
    
    var textCount : Observable<String> {
        text.map {
            guard let text = $0 else {return "0" }
            return text.count.ToString()
        }
    }
}
