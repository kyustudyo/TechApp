//
//  Webservice.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class JsonWebservice {
    
    static func getitem(year:Int, completion: @escaping (AccidentViewModel)->Void) {
        let url = Constants.Urls.urlForAccidents(year: year)
        let resource = Resource<Accident>(url: url) { data in
            let accidentResponse = try? JSONDecoder().decode(Accident.self, from: data)
            return accidentResponse//디코딩,파싱.
        }
        
        JsonWebservice.load(resource: resource) { result in
            if let accidentResource = result {
                //print(result)
                let vm = AccidentViewModel(accident: accidentResource)
                //print(vm)
                //print(vm.resultCode)
                completion(vm)
            }
            
            
        }
    }
    
    static func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {//비동기처리
                     completion(resource.parse(data))//decode
                }
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
    
    
    
}
