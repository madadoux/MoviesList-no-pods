//
//  APIProvider.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
    //

import Foundation
enum PostType {
    case json
    case formdata
}
class APIProvider {
    
    static let shared = APIProvider()
    let defaultSession = URLSession(configuration: .default)
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        defaultSession.dataTask(with: url, completionHandler: completion).resume()
    }
    
   
    func  postURLRequest(url:String , type : PostType)-> URLRequest{
        var postReq = URLRequest(url: URL(string : url)!)
        postReq.httpMethod = "POST"
        switch type {
        case .json:
            postReq.setValue(  "application/json; charset=UTF-8", forHTTPHeaderField: "Content-type"  )
        case .formdata:
            postReq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
        return postReq
        
    }
    fileprivate func handleResponse<T:Codable>(_ error: Error?, _ data: Data?, _ response: URLResponse?, _ onComplete: @escaping (T)->Void , _ onError:@escaping (String?)->Void) {
        // 5
        if let error = error {
            onError(error.localizedDescription)
        } else if let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 , response.statusCode < 300 {
            if let obj = try? JSONDecoder().decode(T.self, from: data)
            {
                onComplete(obj)
            }else {
                onError("err.parsingError")
            }
        }
        else {
            onError("status code : \((response as? HTTPURLResponse )?.statusCode)")
            
        }
    }
    
    func get<T:Codable>(url : String , onComplete: @escaping (T)->Void , onError:@escaping (String?)->Void ){
        
        let dataTask = defaultSession.dataTask(with: URL(string:url)!) { data, response, error in
            self.handleResponse(error, data, response,onComplete,onError)
        }
        dataTask.resume()
    }
    
    func post<T:Codable>(url : String ,type:PostType, dic: [String : String], onComplete: @escaping (T)->Void , onError:@escaping (String?)->Void ){
        
        var request = postURLRequest(url:url,type: type)
        switch type {
        case .formdata:
            var querableURL = URLComponents(string: url)
            querableURL?.queryItems = dic.map({ (a,b) in
                return URLQueryItem(name: a, value: b)
            })
            request.url =  querableURL?.url
        case .json:
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: []) {
                request.httpBody = data
            }
            
        }
        defaultSession.dataTask(with: request, completionHandler:  { (data,response,error) in
            self.handleResponse(error, data, response,onComplete,onError)

        }).resume()
        
    }
}
