//
//  DIContainer.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Swinject

private let _container = Container()

public struct DIContainer {
    // MARK: - Public
    
    public static var defaultResolver: Container {
        return _container
    }
}
