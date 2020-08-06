//
//  MapViewInfo.swift
//  MonocarTestTask
//
//  Created by User on 06.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Foundation
import GoogleMaps

class MapViewInfo: GMSMapView, GMSMapViewDelegate {
    var startLocation: Coordinate?
    var endLocation: Coordinate?
    var points: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
        isMyLocationEnabled = true
    }
    
    func setup(startLocation: Coordinate, endLocation: Coordinate, points: String, driver: Driver) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.points = points
        createPolylines(driver: driver)
    }
    
     func createPolylines(driver: Driver) {
        guard let points = points else { return }
        clear()
        createMarkers()
        createMainPolyline(points: points)
        createDottPolyline(driver: driver)
     }
    
    private func createMarkers() {
        guard let start = startLocation, let end = endLocation else { return }
        
        let startMark = GMSMarker(position: start.CLLocation)
        startMark.icon = #imageLiteral(resourceName: "Start marker")
        startMark.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        startMark.map = self
        
        let endMark = GMSMarker(position: end.CLLocation)
        endMark.icon = #imageLiteral(resourceName: "End marker")
        endMark.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        endMark.map = self
    }
    
    private func createMainPolyline(points: String) {
        guard let path = GMSPath.init(fromEncodedPath: points) else { return }

        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = #colorLiteral(red: 0.01176470588, green: 0.5058823529, blue: 0.9960784314, alpha: 1)
        polyline.strokeWidth = 2.0
        polyline.map = self
        
        let bounds = GMSCoordinateBounds(path: path)
        animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 20, left: 20, bottom: 250, right: 20)))
    }
    
    private func createDottPolyline(driver: Driver) {
        let route_start = driver.route_start
        let route_end = driver.route_end
        let startPolyline = GMSPolyline(path: GMSPath(fromEncodedPath: route_start))
        let endPolyline = GMSPolyline(path: GMSPath(fromEncodedPath: route_end))
        updateLine(line: startPolyline, color: #colorLiteral(red: 0, green: 0.8, blue: 0.2, alpha: 1))
        updateLine(line: endPolyline, color: #colorLiteral(red: 0.01176470588, green: 0.5058823529, blue: 0.9960784314, alpha: 1))
    }
    
    private func updateLine(line: GMSPolyline, color: UIColor) {
        let styles: [GMSStrokeStyle] = [.solidColor(color), .solidColor(.clear)]
        let scale = 1.0 / projection.points(forMeters: 1, at: camera.target)
        let solidLine = NSNumber(value: 15.0 * Float(scale))
        let gap = NSNumber(value: 15.0 * Float(scale))
        line.geodesic = true
        line.strokeWidth = 2.0
        line.spans = GMSStyleSpans(line.path!, styles, [solidLine, gap], GMSLengthKind.rhumb)
        line.map = self
    }
}
