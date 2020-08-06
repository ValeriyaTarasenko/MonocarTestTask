//
//  RequestProvider.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Foundation
import Moya
import GooglePlaces
import GoogleMaps

let RequestsProvider = MoyaProvider<Requests>()

public enum Requests {
    case getRequestTest
    case getDirection(Coordinate, Coordinate)
}

extension Requests: TargetType {
   
    public var baseURL: URL {
        switch self {
        case .getRequestTest:
            return URL(string: "https://europe-west3-fb-monocar.cloudfunctions.net")!
        case .getDirection:
            return URL(string: "https://maps.googleapis.com")!
        }
    }
    
    public var path: String {
        switch self {
        case .getRequestTest: return "/getRequestTest"
        case .getDirection: return "/maps/api/directions/json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getRequestTest, .getDirection:
            return .get
        }
    }
    
    public var parameters: [String : Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .getRequestTest:
            params = [:]
        case .getDirection(let start, let end):
            params = ["origin": "\(start.latitude), \(start.longitude)", "destination": "\(end.latitude), \(end.longitude)", "key": Constants.googleApiKey]
        }
        return params
    }
    
    public var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}

