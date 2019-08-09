//
//  WeatherViewController.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 07/08/2019.
//  Copyright (c) 2019 rowkaxl. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

protocol WeatherDisplayLogic: class {
    func displayDarkSkyWeather(viewModel: Weather.Info.ViewModel)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic, MapKitProtocol {
    var interactor: WeatherBusinessLogic?
    var router: (NSObjectProtocol & WeatherRoutingLogic & WeatherDataPassing)?
    
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
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let router = WeatherRouter()
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
        
        configure()
        interactor?.doCurrentLocation()
    }
    
    // MARK: Do something
    
    private let disposeBag = DisposeBag()
    
    var searchController: UISearchController!
    let searchTableViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
    
    
    func displayDarkSkyWeather(viewModel: Weather.Info.ViewModel) {
    
    }
}

extension WeatherViewController: UITableViewDelegate {
    
    private func configure() {
        configureUI()
        configureRx()
    }
    
    private func configureUI() {
        
        searchController = UISearchController(searchResultsController: searchTableViewController)
        searchController.searchResultsUpdater = searchTableViewController
        searchTableViewController.mapKitDelegate = self
        
        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    private func configureRx() {
        
        router?.dataStore?.currentPlacemark
            .skip(1)
            .asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self](placeMark) in
                guard let self = self else { return }
                
                print(placeMark)
                
                self.interactor?.doSavedPlaces()
                
//                // 저장되어 있는 장소가 없을 경우만 현재 위치정보로 날씨 정보 요청
//                if self.router?.dataStore?.recentPlace == nil {
//                    self.doDarkSkyWeather(placeMark: placeMark)
//                }
//
//                // 검색 테이블에 현재 위치 셋 (검색 리스트 거리별순 정렬 위해)
//                if let location = placeMark.location {
//                    self.searchTableViewController.location = location
//                }
            })
            .disposed(by: disposeBag)
    }
}

extension WeatherViewController {
    
    private func doDarkSkyWeather(placeMark: MKPlacemark) {
        let request = Weather.Info.Request(placeMark: placeMark, keyword: placeMark.name ?? "")
        self.interactor?.doDarkSkyWeather(request: request)
    }
}

extension WeatherViewController {
    
    // 검색한 정보
    func selectedLocation(mkMapItem: MKMapItem) {
        self.doDarkSkyWeather(placeMark: mkMapItem.placemark)
        self.interactor?.doSaveLocation(mkMapItem: mkMapItem)
    }
}
