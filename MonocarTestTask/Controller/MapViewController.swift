//
//  MapViewController.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet private weak var mapView: MapViewInfo!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    struct Constants {
        static let driverCell = "DriverCollectionViewCell"
        static let cellHeight = 230
        static let distanceBetweenCell = 50
    }
    
    private let requestManager = DIContainer.defaultResolver.resolve(RequestManager.self)!
    private var startLocation: Coordinate?
    private var endLocation: Coordinate?
    private var drivers: [Driver] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        getRequestTest()
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let tableItemCell = UINib(nibName: Constants.driverCell, bundle: nil)
        collectionView.register(tableItemCell, forCellWithReuseIdentifier: Constants.driverCell)
    }

    private func getRequestTest() {
        requestManager.getRequestTest() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(route):
                self.startLocation = route.start.geo
                self.endLocation = route.end.geo
                self.drivers = route.results.values.map { $0 }.sorted(by: { $0.rating > $1.rating })
                self.title = "Знайдено (\(self.drivers.count))"
                self.collectionView.reloadData()
                
                self.getDirection()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getDirection() {
        guard let start = startLocation, let end = endLocation else { return }
        self.requestManager.getDirection(start: start, end: end) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(points):
                guard let points = points, let startLocation = self.startLocation,
                    let endLocation = self.endLocation, let driver = self.drivers.first else {
                        return
                }
                self.mapView.setup(startLocation: startLocation,
                                   endLocation: endLocation,
                                   points: points,
                                   driver: driver)
            case let .failure(error):
                print(error)
           }
        }
    }
}

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drivers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.driverCell, for: indexPath) as? DriverCollectionViewCell,
            drivers.indices.contains(indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.setup(with: drivers[indexPath.row])
        return cell
    }
}
    
extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.size.width
        return CGSize(width: Int(width) - Constants.distanceBetweenCell, height: Constants.cellHeight)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var indexes = self.collectionView.indexPathsForVisibleItems
        indexes.sort()
        guard var index = indexes.first, let cell = self.collectionView.cellForItem(at: index),
            drivers.indices.contains(index.row) else {
            return
        }
        let position = self.collectionView.contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width / 2 {
           index.row = index.row + 1
        }
        
        self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        mapView.createPolylines(driver: drivers[index.row])
    }
}
