//
//  TableViewModel.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

typealias ImageCellConfigurator = TableCellConfigurator<ImageCell, Datum>

class TableViewModel {
    var cells: [CellConfigurator] = [CellConfigurator]()
    
    func fillImages(toExtract: Datum) {
        guard let images = toExtract.images else { return }
        for item in images { self.cells.append(ImageCellConfigurator.init(item: item)) }
    }
}
