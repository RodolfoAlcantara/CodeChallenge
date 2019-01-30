//
//  WSConstants.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

//You can set the 250ms extra point in this line, but testing I found the request all the times takes more than 250 ms so I tried with 1 second
public let TIMEOUT: TimeInterval = 30.0
public let mainURL = "https://api.imgur.com/3/gallery/"

public enum WSNAME: String {
    case consumeImages = "toConsumeImageData"
}

public struct URLImage {
    let WSIMAGESDOWNLOAD = mainURL + "search/time/"
}
