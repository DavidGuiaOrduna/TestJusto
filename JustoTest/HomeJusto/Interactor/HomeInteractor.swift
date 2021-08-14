//
//  HomeInteractor.swift
//  JustoTest
//
//  Created by David Guia on 14/08/21.
//

import Foundation
import Alamofire

protocol HomeInteractorProtocol: AnyObject {
    func didGetResponseModel(response : [TestModelConsult] )
}

final class HomeInteractor {
    private var baseUrl = "https://randomuser.me/api/"
    weak var delegate: HomeInteractorProtocol?
    typealias testCallBack = (_ testData: ResultModel?, _ status: Bool, _ message:String) -> Void
    var callBack: testCallBack?
    
    func getAllTestData() {
        AF.request(self.baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: nil, interceptor: nil).response { (responseData) in
                    guard let data = responseData.data else {
                        self.callBack?(nil, false, "")
                        return }
                    do {
                        let testData = try JSONDecoder().decode(ResultModel.self, from: data)
                        self.callBack?(testData, true,"")
                        self.delegate?.didGetResponseModel(response: testData.results)
                    } catch {
                        self.callBack?(nil, false, error.localizedDescription)
                        print("error = \(error)")
                    }
                   }
    }
    
    func completionHandler(callBack: @escaping testCallBack) {
        self.callBack = callBack
    }
}
