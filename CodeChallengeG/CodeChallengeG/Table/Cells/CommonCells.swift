//
//  CommonCells.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell, ConfigurableCell {    
    @IBOutlet weak var lblTitleImage: UILabel!
    /**
     Función para configuración de celda
     */
    func configure(data image: Datum) {
        self.lblTitleImage.text = image.title ?? image.description ?? "Not Titled"
        guard let url = URL(string: image.link) else { return }
        let data = try? Data(contentsOf: url)
        //cell.myImage.image = UIImage(data: data!)
    }
}
