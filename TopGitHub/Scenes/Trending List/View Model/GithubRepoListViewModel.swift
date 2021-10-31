//
//  GithubRepoListViewModel.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//

import Foundation


protocol FilterProtocol {
    var language_Name: String? { get }
    var isSelected: Bool { get set }
}

class GithubRepoListViewModel {
    var model: GithubRepoListModel.Response?
    var timemodel: [TimeResponse]?
    var languageModel: [LanguageResponse]?
    var filterByLanguage: String = ""
    var filterByTime: String = ""
    
    func setDefaultData() {
        filterByLanguage = "java"
        filterByTime = "Yearly"
        getTimeList()
        getLanguagesList()
    }
    
    func callListApi(completionHandler: @escaping (_ status: Bool) -> Void) {
        let request = GithubRepoListModel.Request(lang: filterByLanguage, since: filterByTime)
        let param = CommonFunctions.sharedInstance.convertModelObjectToJson(request)
        let url = CommonFunctions.sharedInstance.getUrlByAppendingBaseUrl("")
        BaseServiceClass.sharedInstance.connectURLEncoding(url: url, httpMethod: .get, headers: nil, parameters: param) { [weak self] (response) in
            let responseDict = response.result as! [String: Any]
            print(responseDict)
            let modelObj = CommonFunctions.sharedInstance.convertJsonObjectToModel(responseDict, modelType: GithubRepoListModel.Response.self)
            if let obj = modelObj, !(obj.items?.isEmpty ?? false) {
                self?.model = obj
                
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    func getTimeList() {
        if let url = Bundle.main.url(forResource: JsonFileNames.timeJson, withExtension: JsonFileNames.jsonExtension) {
            let timeData = NSData(contentsOf: url)
            let time = CommonFunctions.sharedInstance.convertDataToModel(timeData! as Data, modelType: [TimeResponse].self)
            timemodel = time ?? nil
        }
    }
    
    func getLanguagesList() {
        if let url = Bundle.main.url(forResource: JsonFileNames.languageJson, withExtension: JsonFileNames.jsonExtension) {
            let languageData = NSData(contentsOf: url)
            let lang = CommonFunctions.sharedInstance.convertDataToModel(languageData! as Data, modelType: [LanguageResponse].self)
            languageModel = lang  ?? nil
        }
    }
    
    func setSelectedFilters(selectedIndex: Int, completionHandler: @escaping (_ status: Bool) -> Void) {
        guard let languageData = languageModel else { return }
        languageData.forEach({$0.isSelected = false})
        let selectedLanguage = languageData.getElement(at: selectedIndex)
        selectedLanguage?.isSelected = true
        filterByLanguage = selectedLanguage?.language_Name ?? "Java"
        completionHandler(true)
    }
}
