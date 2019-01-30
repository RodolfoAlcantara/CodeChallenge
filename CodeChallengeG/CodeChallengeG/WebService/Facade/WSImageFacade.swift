//
//  WSImageFacade.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//
import Foundation

/**
 Facade class of the flow of consume image information
 */
public class WSImageFacade: NSObject, WSDelegate {
    ///Service protocol
    public var serviceProtocolDelegate: ServiceProtocol?
    /**
     Function to request data from the api
     - parameters:
     - requestImage: Data to complete the request
     */
    public func getImagesWithPage(requestImage: RequestImage) {
        let wes = URLImage()
        let haders = ["Authorization": "Client-ID 126701cd8332f32"]
        let connection = ConnectionManager()
        guard let searchWord = requestImage.nameToSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let request = connection.getURLCustom(urlRequest: wes.WSIMAGESDOWNLOAD + "\(requestImage.page)?q=\(searchWord)", urlMethod: .get, headers: haders)
        connection.delegate = self
        connection.startConnectionWithCustomRequest(urlRequest: request, serviceName: .consumeImages)
    }
    /**
     Function with the posible response of the service
     */
    func didReceiveData(data: Data, serviceName: WSNAME) {
        switch serviceName {
        case .consumeImages:
            do {
                let activeImages = try JSONDecoder().decode(ImageDataResponse.self, from: data)
                self.serviceProtocolDelegate?.didRecieveEntity(serviceName: serviceName, entity: activeImages)
            } catch {
                print("Catched Error")
            }
        }
    }
    /**
     Simple function to print/catch the error
     */
    func didReceiveError(error: Error, serviceName: WSNAME) {
        print(error.localizedDescription)
    }
}
