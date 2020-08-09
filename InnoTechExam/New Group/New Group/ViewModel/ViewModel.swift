//
//  ViewModel.swift
//  InnoTechExam
//
//  Created by edisonlin on 2020/8/7.
//  Copyright © 2020 edison. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func viewModelDidGetData()
}

class ViewModel {
    
    private var dataArray: [DataModel]?
    private var filteredDataArray: [DataModel]?
    var shouldShowSearchResults: Bool = false {
        didSet {
            self.delegate?.viewModelDidGetData()
        }
    }
    private let url = "https://jsonplaceholder.typicode.com/photos"
    var delegate: ViewModelDelegate?
    
    func rowsCount() -> Int {
        return shouldShowSearchResults ? filteredDataArray?.count ?? 0 : dataArray?.count ?? 0
    }
    
    func imageURL(at row: Int) -> URL? {
        return shouldShowSearchResults ? URL(string: filteredDataArray?[row].thumbnailUrl ?? "") : URL(string: dataArray?[row].thumbnailUrl ?? "")
    }
    
    func title(at row: Int) -> String? {
        return shouldShowSearchResults ? filteredDataArray?[row].title : dataArray?[row].title
    }
    
    func didSelectRow(at row: Int) {
        print(shouldShowSearchResults ? filteredDataArray?[row] : dataArray?[row])
    }
    
    func getData() {
        
        APIManager.shared.getJSON(url: url, parameters: nil) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data as? Data else { return }
                do {
                    let jsonData = try JSONDecoder().decode([DataModel].self, from: data)
                    self.dataArray = jsonData
                    self.filteredDataArray = jsonData
                    self.delegate?.viewModelDidGetData()
                }catch let error {
                    assertionFailure("JSON 解析失敗 \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filterData(text: String) {
        filteredDataArray = dataArray?.filter({ (data) -> Bool in
            
            return (data.title.lowercased().contains(text.lowercased()) || data.title.lowercased().contains(text.lowercased()))
        })
        delegate?.viewModelDidGetData()
    }
}
