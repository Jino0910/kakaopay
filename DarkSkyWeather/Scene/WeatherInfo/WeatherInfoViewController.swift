//
//  WeatherInfoViewController.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 10/08/2019.
//  Copyright (c) 2019 rowkaxl. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WeatherInfoDisplayLogic: class {
    func displaySomething(viewModel: WeatherInfo.Something.ViewModel)
}

class WeatherInfoViewController: UIViewController, WeatherInfoDisplayLogic {
    
    var interactor: WeatherInfoBusinessLogic?
    var router: (NSObjectProtocol & WeatherInfoRoutingLogic & WeatherInfoDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WeatherInfoInteractor()
        let presenter = WeatherInfoPresenter()
        let router = WeatherInfoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        
        label.text = router?.dataStore?.placemark?.locality
    }
    
    // MARK: Do something
    
    var weatherPresentationDelegate: WeatherPresentationLogic?
    @IBOutlet weak var label: UILabel!
    

    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = WeatherInfo.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: WeatherInfo.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

