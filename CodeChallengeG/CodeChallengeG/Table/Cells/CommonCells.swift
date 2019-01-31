//
//  CommonCells.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/30/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit
import AVFoundation

/**
 Class to describe the main and general cell for image
 */
class ImageCell: UITableViewCell, ConfigurableCell {    
    ///Label to set Title of image
    @IBOutlet weak var lblTitleImage: UILabel!
    ///ImageView to set image from data
    @IBOutlet weak var imgPrincipalImage: UIImageView!
    /**
     Function to configure the cell
     - parameters:
     - image: Type data with image information
     */
    func configure(data image: Datum) {
        self.lblTitleImage.text = image.title ?? image.description ?? "Not Titled"
        setImage(imageData: image)
    }    
    /**
     Function to set imagen and distinguish if its a video or an image
     - parameters:
     - imageData: Type data with image information
     */
    func setImage(imageData: Datum) {
        guard let url = URL(string: imageData.link ?? "") else { return }
        if imageData.type == TypeEnum.videoMp4 {
            guard let imageVideo = thumbnailForVideoAtURL(url: url) else { return }
            self.imgPrincipalImage.image = imageVideo
        } else {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imgPrincipalImage.image = UIImage(data: data!)
                }
            }
        }
    }
    /**
     Function to get the thubnail if its a video
     - parametes:
     - url: URL with the link of the video
    */
    func thumbnailForVideoAtURL(url: URL) -> UIImage? {
        let asset = AVAsset(url: url as URL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        var time = asset.duration
        time.value = min(time.value, 2)
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch { return nil }
    }
}
