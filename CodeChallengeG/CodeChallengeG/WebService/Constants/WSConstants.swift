//
//  WSConstants.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

//You can set the 250ms extra point in this line, but testing I found the request all the times takes more than 250 ms so I tried with 10 seconds
public let TIMEOUT: TimeInterval = 10.0
///Main url to access the services
public let mainURL = "https://api.imgur.com/3/gallery/"
///Enum of name of the service to consume
public enum WSNAME: String {
    case consumeImages = "toConsumeImageData"
}
///Struct with the complete link of the service
public struct URLImage {
    let WSIMAGESDOWNLOAD = mainURL + "search/time/"
}
