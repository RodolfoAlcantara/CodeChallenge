//
//  TableViewModel.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

///Type alias with the generic configurator of an image cell
typealias ImageCellConfigurator = TableCellConfigurator<ImageCell, Datum>

/**
 Class to store the model for the Tableview
 */
class TableViewModel {
    ///Array with de protocols to configurate the cell
    var cells: [CellConfigurator] = [CellConfigurator]()
    /**
     Function to fill the images
     */
    func fillImages(toExtract: Datum) {
        guard let images = toExtract.images else { return }
        for item in images { self.cells.append(ImageCellConfigurator.init(item: item)) }
    }
}
