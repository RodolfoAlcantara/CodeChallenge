//
//  ConnectionManager.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/30/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import Alamofire

/**
 Main protocol to recieve data and errors from a service
 */
protocol WSDelegate {
    func didReceiveData(data: Data, serviceName: WSNAME)
    func didReceiveError(error: Error, serviceName: WSNAME)
}
/**
 Main class to define the conection manager for the application
 */
class ConnectionManager: NSObject {
    ///Service Delegate
    public var delegate: WSDelegate?
    ///Default manager
    private var manager: SessionManager = SessionManager.default
    /**
     Init from the manager
     */
    override init() {
        super.init()
        let serverTrustPolicies: [String: ServerTrustPolicy] = ["api.imgur.com": .disableEvaluation]
        self.manager = Alamofire.SessionManager(
            configuration: loadConfigurationManager(), delegate: SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    /**
     Function ton configure extra parameters, as the timeout for the request
     */
    private func loadConfigurationManager() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = TIMEOUT
        return sessionConfiguration
    }
    /**
     Main function to create and custom request based in an object
     - parameters:
     - urlRequest: Data type URL with the detail of the request
     - serviceName: Name of the service to do the request
     */
    internal func startConnectionWithCustomRequest(urlRequest: URLRequest, serviceName: WSNAME) {
        self.manager.request(urlRequest).responseData { (response) -> Void in
            #if DEBUG
            print("Request: \(String(describing: response.request))")
            let responseS = String(data: response.data!, encoding: .utf8)
            print("Response: \(String(describing: responseS))")
            print("Response Time: \(response.timeline)")
            #endif
            switch response.result {
            case .success:
                self.delegate?.didReceiveData(data: response.data!, serviceName: serviceName)
            case .failure(let error):
                #if DEBUG
                print("Error \(error.localizedDescription)")
                #endif
                self.delegate?.didReceiveError(error: error, serviceName: serviceName)
                return
            }
        }
    }
    /**
     Auxiliar function to create the URL Custom for request
     - parameters:
     - urlRequest: The link o url string to do the request
     - urlMethod: HTTPS Verbose
     - headers: Array of headers for request
     */
    internal func getURLCustom(urlRequest: String, urlMethod: HTTPMethod, headers: [String: String]) -> URLRequest {
        let url = URL(string: urlRequest)
        var request = URLRequest(url: url!)
        request.httpMethod = urlMethod.rawValue
        for header in headers { request.setValue(header.value, forHTTPHeaderField: header.key) }
        return request
    }
}
