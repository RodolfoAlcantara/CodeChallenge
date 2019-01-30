//
//  WSImageFacade.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//
import Foundation

public class WSImageFacade: NSObject, WSDelegate {
    public var serviceProtocolDelegate: ServiceProtocol?
    
    public func getImagesWithPage(requestImage: RequestImage) {
        let wes = URLImage()
        let haders = ["Authorization": "Client-ID 126701cd8332f32"]
        let connection = BBConnectionManager()
        guard let searchWord = requestImage.nameToSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let request = connection.getURLCustom(urlRequest: wes.WSIMAGESDOWNLOAD + "\(requestImage.page)?q=\(searchWord)", urlMethod: .get, headers: haders)
        connection.delegate = self
        connection.startConnectionWithCustomRequest(urlRequest: request, serviceName: .consumeImages)
    }
    func didReceiveData(data: Data, serviceName: WSNAME) {
        switch serviceName {
        case .consumeImages:
            do {
                print("Inside")
                let activeImages = try JSONDecoder().decode(ImageDataResponse.self, from: data)
                self.serviceProtocolDelegate?.didRecieveEntity(serviceName: serviceName, entity: activeImages)
            } catch {
                print("Catched Error")
            }
        }
    }
    
    func didReceiveError(error: Error, serviceName: WSNAME) {
        print(error.localizedDescription)
    }
}
