//
//  ConnectionManager.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/29/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import Alamofire

protocol WSDelegate {
    func didReceiveData(data: Data, serviceName: WSNAME)
    func didReceiveError(error: Error, serviceName: WSNAME)
}
class BBConnectionManager: NSObject {
    public var delegate: WSDelegate?
    private var manager: SessionManager = SessionManager.default
    override init() {
        super.init()
        let serverTrustPolicies: [String: ServerTrustPolicy] = ["api.imgur.com": .disableEvaluation]
        self.manager = Alamofire.SessionManager(
            configuration: loadConfigurationManager(), delegate: SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    private func loadConfigurationManager() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = TIMEOUT
        return sessionConfiguration
    }
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
    internal func getURLCustom(urlRequest: String, urlMethod: HTTPMethod, headers: [String: String]) -> URLRequest {
        let url = URL(string: urlRequest)
        var request = URLRequest(url: url!)
        request.httpMethod = urlMethod.rawValue
        for header in headers { request.setValue(header.value, forHTTPHeaderField: header.key) }
        return request
    }
}
