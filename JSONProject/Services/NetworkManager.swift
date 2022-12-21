//
//  NetworkManager.swift
//  JSONProject
//
//  Created by Lepestok Jora on 21.12.2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager {
    
    static var shared = NetworkManager()
      
    let urlJson: String = "https://go-apod.herokuapp.com/apod"
    
    func startJson(completion: @escaping (ResponseData) -> Void, errorCompletion: @escaping (Error) -> Void) {
        
        AF.request(urlJson).responseJSON { response in
            print(response)
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            //to get JSON return value
            guard let data = response.data else {
                print("No data received:", response.error ?? URLError(.badServerResponse))
               // self.startButton.isUserInteractionEnabled = true
                errorCompletion(response.error ?? URLError(.badServerResponse))
                return
            }
            var json = try! JSON(data: data)
            
            let url = json["url"].stringValue
            let title = json["title"].stringValue
            let service_version = json["service_version"].stringValue
            let media_type = json["media_type"].stringValue
            let hdurl = json["hdurl"].stringValue
            let explanation = json["explanation"].stringValue
            let date = json["date"].stringValue
            let copyright = json["copyright"].stringValue
            
            print("\(url), \(title), \(service_version), \(media_type), \(hdurl), \(explanation), \(date), \(copyright)")
            
            let jsonModel: ResponseData = ResponseData(url: url,
                                                       title: title,
                                                       service_version: service_version,
                                                       media_type: media_type,
                                                       hdurl: hdurl,
                                                       explanation: explanation,
                                                       date: date,
                                                       copyright: copyright)
            
            completion(jsonModel)
            
        }
    }
    
}
