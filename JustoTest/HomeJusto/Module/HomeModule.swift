//
//  HomeModule.swift
//  JustoTest
//
//  Created by David Guia on 14/08/21.
//

import UIKit
import Foundation

final class HomeModule {
     
    static func building() -> UIViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let router = HomeRouter(viewController: viewController)
        let presenter = HomePresenter(viewController: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
}
