//
//  RequestManager.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Foundation

protocol RequestManager {
    func getRequestTest(completionHandler: @escaping (Result<Route, AppError>) -> Void)
    func getDirection(start: Coordinate, end: Coordinate, completionHandler: @escaping (Result<String?, AppError>) -> Void) 
}

class RequestManagerImplementation: RequestManager {
    func getRequestTest(completionHandler: @escaping (Result<Route, AppError>) -> Void) {
        let parameter: Requests = .getRequestTest
        RequestsProvider.request(parameter) { result in
            let response = try? result.get()
            guard let data = response?.data else { return completionHandler(.failure(.unknown))}
            do {
                let route = try Route.decode(data: data)
                completionHandler(.success(route))
            } catch let error {
                completionHandler(.failure(.custom(error.localizedDescription)))
            }
        }
    }
    
    func getDirection(start: Coordinate, end: Coordinate, completionHandler: @escaping (Result<String?, AppError>) -> Void) {
        let parameter: Requests = .getDirection(start,end)
         RequestsProvider.request(parameter) { result in
            let response = try? result.get()
            guard let data = response?.data else { return completionHandler(.failure(.unknown))}
            do {
                let googleRoute = try GoogleRoute.decode(data: data)
                completionHandler(.success(googleRoute.routes.first?.overview_polyline.points))
            } catch let error {
                completionHandler(.failure(.custom(error.localizedDescription)))
            }
        }
    }
}

