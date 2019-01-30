//
//  ServiceProtocol.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

public protocol ServiceProtocol {
    func didRecieveEntity<T>(serviceName: WSNAME, entity: T)
}
