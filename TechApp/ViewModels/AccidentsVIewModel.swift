//
//  AccidentsVIewModel.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//

import Foundation

class LocationAndInjuredViewModel {
    
    private let locationInjured: LocationInjuredDTO?
    
    var location : String {
        return locationInjured?.spot_nm ?? ""
    }
    var injured : Int  {
        return locationInjured?.sl_dnv_cnt ?? 0
    }
    init(locationInjured: LocationInjuredDTO){
        self.locationInjured = locationInjured
    }
}

class AccidentViewModel {
    
    private let accident : Accident?
    //lazy var isThereData = false//
    var resultCode: String {
        return accident?.resultCode ?? ""
    }
    var resultMsg:String{
        return accident?.resultMsg ?? ""
    }
    var resultLocation:String {
        return accident?.items.item.first?.spot_nm ?? "no data"
        // 그당시 데이터 없을경우.
    }
    var resultInjured: Int {
        return accident?.items.item.first?.sl_dnv_cnt ?? 0
    }
    var isThereData: Bool {
        if let _ = accident?.items.item.first?.spot_nm {
            return false
        } else { return true }
    }
    
    
    init(accident:Accident) {
        self.accident = accident
    }
}

