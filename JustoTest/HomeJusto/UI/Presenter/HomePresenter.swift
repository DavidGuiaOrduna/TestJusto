//
//  HomePresenter.swift
//  JustoTest
//
//  Created by David Guia on 14/08/21.
//

import Foundation
import RxSwift

protocol HomePresenterProtocol {
    func viewDidLoad() -> Void
    var dataInfoObserver: Observable<[TestModelConsult]> { get }
}

final class HomePresenter {
    weak var viewController: HomeViewProtocol?
    private var router: HomeRouterProtocol
    private let dataInfoSubject: PublishSubject = PublishSubject<[TestModelConsult]>()
    
    init(viewController: HomeViewProtocol, router: HomeRouterProtocol) {
        self.router = router
        self.viewController = viewController
    }
}

extension HomePresenter: HomePresenterProtocol, HomeInteractorProtocol {
    
    func viewDidLoad() {
        callService() 
    }
    
    func callService() {
        let service = HomeInteractor()
        service.delegate = self
        service.getAllTestData()
    }
    
    func didGetResponseModel(response: [TestModelConsult]) {
        dataInfoSubject.onNext(response)
    }
    
    var dataInfoObserver: Observable<[TestModelConsult]> {
        return dataInfoSubject.asObserver()
    }
}
