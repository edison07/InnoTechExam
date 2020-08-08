//
//  APIManager.swift
//  InnoTechExam
//
//  Created by edisonlin on 2020/8/7.
//  Copyright © 2020 edison. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared: APIManager = APIManager()
    
    func getJSON(url: String, parameters: [String : Any]?, completion: @escaping (AFResult<Any>) ->() ) {

        AF.request(url, parameters: parameters).responseJSON { (response) in

            switch response.result {

            case .success(_):
                completion(.success(response.data ?? Data()))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private init() {}
}
