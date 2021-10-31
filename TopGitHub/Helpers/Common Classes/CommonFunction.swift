//
//  CommonFunction.swift
//  AnujApp
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//

import UIKit

class CommonFunctions: NSObject {
    
    // MARK: - Properties
    static let sharedInstance = CommonFunctions()
    private override init() {}

    func convertDataToModel<T : Decodable>(_ data: Data, modelType: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let modelObj = try jsonDecoder.decode(modelType, from: data)
            return modelObj
        } catch {
            print("error \(error)")
        }
        return nil
    }
    /**
     Call this function to convert model object to json
     */
    
    func convertModelObjectToJson<T : Encodable>(_ model: T) -> [String: Any]? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let data = try jsonEncoder.encode(model)
            do {
                if let jsonParameters = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                    return jsonParameters
                }
            } catch {
                print("error \(error)")
            }
        } catch {
            print("error \(error)")
        }
        return nil
    }
    
    /**
     Call this function to convert json object to model
     */
    
    func convertJsonObjectToModel<T : Decodable>(_ object: [String: Any], modelType: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            do {
                let modelObj = try jsonDecoder.decode(modelType, from: data!)
                return modelObj
            } catch {
                print("error \(error)")
            }
        } catch {
            print("error \(error)")
        }
        return nil
    }

    func convertJsonObjectToModel<T : Decodable>(_ object: [[String: Any]], modelType: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            do {
                let modelObj = try jsonDecoder.decode(modelType, from: data!)
                return modelObj
            } catch {
                print("error \(error)")
            }
        } catch {
            print("error \(error)")
        }
        return nil
    }
    
    func getUrlByAppendingBaseUrl(_ apiEndpoint: String) -> String {
        return "https://trendings.herokuapp.com/repo?" + apiEndpoint
    }
    
}
