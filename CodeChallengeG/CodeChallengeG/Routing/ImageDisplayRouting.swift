//
//  ImageDisplayRouting.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/30/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

class ImageDisplayRouting: NSObject {
    public static func toShowImageRouting(title: String, image: UIImage, fromViewController: UIViewController) {
        guard let imageDisplay = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageDisplayViewController") as? ImageDisplayViewController else { return }
        imageDisplay.titleImage = title
        imageDisplay.imageToShow = image
        fromViewController.present(imageDisplay, animated: true, completion: nil)
    }
    public static func removeImageDisplayRouting(fromViewController: UIViewController) {
        fromViewController.dismiss(animated: true, completion: nil)
    }
}
