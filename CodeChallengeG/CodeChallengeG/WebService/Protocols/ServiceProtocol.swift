//
//  ServiceProtocol.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/30/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

/**
 Main protocol to recieve data
 */
public protocol ServiceProtocol {
    func didRecieveEntity<T>(serviceName: WSNAME, entity: T)
}
