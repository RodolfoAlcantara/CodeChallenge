//
//  ViewController.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/30/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ///Search bar
    @IBOutlet weak var searchBar: UISearchBar!
    ///Principal outlet for TableView
    @IBOutlet weak var tableViewImages: UITableView!
    ///Variable to access to the model
    internal var viewModel = TableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    /**
     Function to create a request for the image API
     - parameters:
     - request: Struct with the page and the word to search
     */
    func takeImagesFromServer(request: RequestImage) {
        SVProgressHUD.show(withStatus: "Working ...")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ImageCell else { return }
        ImageDisplayRouting.toShowImageRouting(title: cell.lblTitleImage.text ?? "", image: cell.imgPrincipalImage.image ?? UIImage(), fromViewController: self)
    }
}

extension ViewController: ServiceProtocol {
    func didRecieveEntity<T>(serviceName: WSNAME, entity: T) {
        switch serviceName {
        case .consumeImages:
            guard let entityRecieved: ImageDataResponse = entity as? ImageDataResponse else { return }
            viewModel.cells.removeAll()
            for item in entityRecieved.data {
                viewModel.fillImages(toExtract: item)
            }
            self.tableViewImages.reloadData()
            SVProgressHUD.dismiss()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let textToSearch = self.searchBar.text else { return }
        let request = RequestImage(page: 1, nameToSearch: textToSearch)
        takeImagesFromServer(request: request)
    }
}

