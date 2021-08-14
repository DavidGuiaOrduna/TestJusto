//
//  HomeRouter.swift
//  JustoTest
//
//  Created by David Guia on 14/08/21.
//

import UIKit
import Foundation

protocol HomeRouterProtocol {
    
}

final class HomeRouter {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeRouterProtocol { }
