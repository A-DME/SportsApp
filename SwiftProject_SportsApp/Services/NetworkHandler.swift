//
//  NetworkHandler.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 29/01/2024.
//

import Foundation
import Alamofire


class NetworkHandler{
    func fetch<T: Codable>(url: String, type: T.Type, complitionHandler: @escaping (T?)->Void) {
        let url = URL(string:url)
        guard let newURL = url else {
            complitionHandler(nil)
            return  }
        AF.request(newURL).response { data in
            guard let data = data.data else {
                complitionHandler(nil)
                return  }
            print("fetching in background")
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                complitionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                complitionHandler(nil)
            }
        }
//        let request = URLRequest(url: newURL)
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                complitionHandler(nil)
//                return  }
//            print("fetching in background")
//            do{
//                let result = try JSONDecoder().decode(T.self, from: data)
//                complitionHandler(result)
//            }catch let error{
//                print(error.localizedDescription)
//                complitionHandler(nil)
//            }
//        }
//        task.resume()
    }
    
}
