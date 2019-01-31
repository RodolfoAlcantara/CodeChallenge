//
//  ImageDisplayViewController.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/30/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBAction func closeAction(_ sender: Any) {
        ImageDisplayRouting.removeImageDisplayRouting(fromViewController: self)
    }
    public var titleImage: String = String()
    public var imageToShow: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyles()
    }
    
    fileprivate func setStyles() {
        self.title = titleImage
        self.lblTitle.text = titleImage
        self.imageView.image = imageToShow
    }
}
