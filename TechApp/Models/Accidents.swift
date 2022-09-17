//
//  Accidents.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//

import Foundation

struct Accident : Decodable {
    var resultCode: String?
    var resultMsg:String?
    var items: Items
}

struct Items:Decodable {
    var item: [LocationInjuredDTO]
}

struct LocationInjuredDTO: Decodable {//simple sample
    
    var spot_nm :String
    var sl_dnv_cnt : Int
    
    init(dictionary: [String: Any]) {
        self.spot_nm = dictionary["location"] as? String ?? ""//type casting
        self.sl_dnv_cnt = dictionary["injured"] as? Int ?? 0
    }
    
    init(name: String, number: Int) {
        self.spot_nm = name
        self.sl_dnv_cnt = number
    }
}

extension LocationInjuredDTO {
    static let Dummy: LocationInjuredDTO = LocationInjuredDTO(dictionary: { [ "location": "", "injured": 0]}())
}

//"resultCode":"00",
//"resultMsg":"NORMAL_CODE",
//"items":
//    {"item":[
//        {
//        "afos_fid":6713451,
//        "afos_id":"01",
//        "bjd_cd":"1165010200",
//        "spot_cd":"11650001",
//        "sido_sgg_nm":"서울특별시 서초구1",
//        "spot_nm":"서울특별시 서초구 양재동(트럭터미널앞교차로 부근)",
//        "occrrnc_cnt":15,
//        "caslt_cnt":19,
//        "dth_dnv_cnt":0,
//        "se_dnv_cnt":5,
//        "sl_dnv_cnt":14,
//        "wnd_dnv_cnt":0,
//        "geom_json":"{\"type\":\"Polygon\",\"coordinates\":
//        [
//        [[127.03812077,37.46159398],[127.03810351,37.46145488],[127.03805239,37.46132111],[127.03796937,37.46119783],[127.03785766,37.46108978],[127.03772153,37.4610011],[127.03756622,37.46093521],[127.0373977,37.46089463],[127.03722245,37.46088093],[127.0370472,37.46089463],[127.03687868,37.46093521],[127.03672337,37.4610011],[127.03658725,37.46108978],[127.03647553,37.46119783],[127.03639252,37.46132111],[127.0363414,37.46145488],[127.03632414,37.46159398],[127.0363414,37.46173309],[127.03639252,37.46186686],[127.03647553,37.46199013],[127.03658725,37.46209818],[127.03672337,37.46218686],[127.03687868,37.46225275],[127.0370472,37.46229333],[127.03722245,37.46230703],[127.0373977,37.46229333],[127.03756622,37.46225275],[127.03772153,37.46218686],[127.03785766,37.46209818],[127.03796937,37.46199013],[127.03805239,37.46186686],[127.03810351,37.46173309],[127.03812077,37.46159398]]
//        ]
//
//        }",
//        "lo_crd":"127.037222451056",
//        "la_crd":"37.461593984176"}]
//    },
//    "totalCount":6,
//    "numOfRows":1,
//    "pageNo":1
//}
