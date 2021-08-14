//
//  ViewController.swift
//  JustoTest
//
//  Created by David Guia on 14/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import Scrollable

protocol HomeViewProtocol: AnyObject {
    var arr_info: [TestModelConsult]? { get }
}

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var pictureIMage: UIImageView!
    @IBOutlet private weak var nameTextLabel: UILabel!
    @IBOutlet private weak var hiTextLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel! {
        didSet {
            emailLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var seeDetailButton: UIButton!
    @IBOutlet private weak var stackViewDetail: UIStackView! {
        didSet {
            stackViewDetail.isHidden = true
        }
    }
    
    var presenter: HomePresenterProtocol?
    private var arrInfo: [TestModelConsult]?
    private var isShowViewDetail: Bool = true
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backGroundView
        self.presenter?.viewDidLoad()
        bind()
    }
}

extension HomeViewController: HomeViewProtocol {
    var arr_info: [TestModelConsult]? {
        return []
    }
    
    func bind() {
        presenter?.dataInfoObserver
            .subscribe(onNext: { [weak self] info in
                guard let self = self else { return }
                self.arrInfo = info
                self.setDataInfo()
            }).disposed(by: disposeBag)
        
        seeDetailButton.rx.tap
            .throttle(.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.showAndHiddeView()
            }.disposed(by: disposeBag)
    }
}

extension HomeViewController {
    func setDataInfo() {
        guard let name = arrInfo?[0].name?.title else { return }
        guard let firstName = arrInfo?[0].name?.first else { return }
        guard let lastName = arrInfo?[0].name?.last else { return }
        let person = String(format: "%@ %@ %@", name, firstName, lastName)
        setImage(urlImage: arrInfo?[0].picture?.large ?? "")
        hiTextLabel.text = "Hy my name is"
        nameTextLabel.text = person
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.setFormButton()
        }
        setDetailView()
    }
    
    func setImage(urlImage: String) {
        guard let url = URL(string: urlImage) else { return }
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: imageData)
            pictureIMage.image = image
        }
    }
    
    func setFormButton() {
        seeDetailButton.backgroundColor = UIColor.backGroundButton
        seeDetailButton.setTitleColor(UIColor.white, for: .normal)
        seeDetailButton.setTitle("See detail", for: .normal)
        seeDetailButton.layer.cornerRadius = 5.0
    }
    
    func setDetailView() {
        cityLabel.text = arrInfo?[0].location?.city
        emailLabel.text = arrInfo?[0].email
        phoneLabel.text = arrInfo?[0].phone
    }
}

extension HomeViewController {
    
    func showAndHiddeView() {
        if isShowViewDetail{
            isShowViewDetail = false
            showViewDetail()
            seeDetailButton.setTitle("Hide detail", for: .normal)
        } else {
            isShowViewDetail = true
            hiddeViewDetail()
            seeDetailButton.setTitle("See detail", for: .normal)
        }
    }
    
    func showViewDetail() {
        UIView.transition(with: stackViewDetail, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.stackViewDetail.isHidden = false
                          })
    }
    
    func hiddeViewDetail() {
        UIView.transition(with: stackViewDetail, duration: 1.3,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.stackViewDetail.isHidden = true
                          })
    }
}

extension UIColor {
    static var backGroundButton: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
    }
    
    static var backGroundView: UIColor {
        return UIColor(red: 244.0 / 255.0, green: 243.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
}
