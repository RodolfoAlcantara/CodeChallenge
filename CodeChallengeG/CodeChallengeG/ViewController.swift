//
//  ViewController.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ///Principal outlet for TableView
    @IBOutlet weak var tableViewImages: UITableView!
    ///Variable to access to the model
    internal var viewModel = TableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = RequestImage(page: 1, nameToSearch: "cats")
        takeImagesFromServer(request: request)
    }
    /**
     Function to create a request for the image API
     - parameters:
     - request: Struct with the page and the word to search
     */
    func takeImagesFromServer(request: RequestImage) {
        let facade = WSImageFacade()
        facade.serviceProtocolDelegate = self
        facade.getImagesWithPage(requestImage: request)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.cells[indexPath.row]
        guard let cell = tableViewImages.dequeueReusableCell(withIdentifier: type(of: item).reuseId) else { return UITableViewCell() }
        item.configure(cell: cell)
        return cell
    }
}

extension ViewController: ServiceProtocol {
    func didRecieveEntity<T>(serviceName: WSNAME, entity: T) {
        switch serviceName {
        case .consumeImages:
            if let entityRecieved: ImageDataResponse = entity as? ImageDataResponse {
                viewModel.cells.removeAll()
                for item in entityRecieved.data {
                    viewModel.fillImages(toExtract: item)
                }
                self.tableViewImages.reloadData()
            } else {
                print("Error")
            }
        }
    }
}

