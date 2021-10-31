//
//  BaseServiceClass.swift
//  AnujApp
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//

import Foundation
import Alamofire


class BaseServiceClass: NSObject {
    
    // MARK: - Properties
    static let sharedInstance = BaseServiceClass()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    // MARK: - Initialization
    private override init() {}
    
    // MARK: - Methods
    /**
     Call this function to check if the internet is active or not.
     */
    
    func isConnectedToInternet() -> Bool {
        return reachabilityManager!.isReachable
    }
    
    /**
     Call this function to hit api with headers and parameters
     */
    
    func connect(url: String, httpMethod: HTTPMethod, headers: HTTPHeaders?, parameters: [String: Any?]?, apiResponse: @escaping(ResponseHandler)) {
        
        let validUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if isConnectedToInternet() {
            AF.request(validUrlString!, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let code = response.response?.statusCode {
                        switch code {
                        case 200...299, 304:
                            apiResponse(ApiResponse(error: nil, result: value, isSuccess: true))
                        case 403, 401:
                        print("Relogin Needed")
                        case 400, 412:
                            apiResponse(ApiResponse(error: "Somethig else went wrong", result: value, isSuccess: false))
                        default:
                            apiResponse(ApiResponse(error: "Somethig else went wrong", result: value, isSuccess: false))
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            apiResponse(ApiResponse(error: "No Network Available", result: nil, isSuccess: false))
        }
    }

    func connectURLEncoding(url: String, httpMethod: HTTPMethod, headers: HTTPHeaders?, parameters: [String: Any]?, apiResponse: @escaping(ResponseHandler)) {
        
        let validUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if isConnectedToInternet() {
            AF.request(validUrlString!, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let code = response.response?.statusCode {
                        switch code {
                        case 200...299, 304:
                            apiResponse(ApiResponse(error: nil, result: value, isSuccess: true))
                        case 403, 401:
                        print("Relogin Needed")
                        case 400, 412:
                            apiResponse(ApiResponse(error: "Somethig else went wrong", result: value, isSuccess: false))
                        default:
                            apiResponse(ApiResponse(error: "Somethig else went wrong", result: value, isSuccess: false))
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            apiResponse(ApiResponse(error: "No Network Available", result: nil, isSuccess: false))
        }
    }
    /**
     Get body from response
     */
    
    func bodyFromResponse(url: String, httpMethod: HTTPMethod, headers: HTTPHeaders?, parameters: [String: Any]?, apiResponse: @escaping(ResponseHandler)) {
        
        let validUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if isConnectedToInternet() {
            AF.request(validUrlString!, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    apiResponse(ApiResponse(error: nil, result: json, isSuccess: true))
                }
            }
        } else {
            apiResponse(ApiResponse(error: "No Network Available", result: nil, isSuccess: false))
        }
    }
    
    /**
     Call this function to hit api without headers and with parameters
     */
    
    func connect(url: String, httpMethod: HTTPMethod, parameters: [String: Any]?, apiResponse: @escaping(ResponseHandler)) {
        connect(url: url, httpMethod: httpMethod, headers: nil, parameters: parameters) { (response) in
            apiResponse(response)
        }
    }
    
    /**
     Call this function to hit api with headers and without parameters
     */
    
    func connect(url: String, httpMethod: HTTPMethod, headers: HTTPHeaders?, apiResponse: @escaping(ResponseHandler)) {
        connect(url: url, httpMethod: httpMethod, headers: headers, parameters: nil) { (response) in
            apiResponse(response)
        }
    }
    
    /**
     Call this function to hit api without headers and without parameters
     */
    
    func connect(url: String, httpMethod: HTTPMethod, apiResponse: @escaping(ResponseHandler)) {
        connect(url: url, httpMethod: httpMethod, headers: nil, parameters: nil) { (response) in
            apiResponse(response)
        }
    }
    
}

typealias ResponseHandler = (_ response: ApiResponse) -> Void

struct ApiResponse {
    var error: String?
    var result: Any?
    var isSuccess: Bool?
}

struct ApiResponseModel<T : Decodable> {
    var error: String?
    var result: T
    var isSuccess: Bool?
}
