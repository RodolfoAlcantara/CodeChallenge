//
//  TableViewCellConfigurator.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

/**
 Protocol to configure cell with an associated type
 */
protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}
/**
 Cell configurator
 */
protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
}
/**
  Auxiliar class to configurate cell
 */
class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    static var reuseId: String { return String(describing: CellType.self) }
    ///Associated type
    let item: DataType
    /**
     Internal init with type date
     */
    init(item: DataType) {
        self.item = item
    }
    /**
     Función para configurar celda
     - parameters:
     - cell: UIView to configurate the cell associated with a date type
     */
    func configure(cell: UIView) {
        guard let cellView = cell as? CellType else { return }
        cellView.configure(data: item)
    }
}
