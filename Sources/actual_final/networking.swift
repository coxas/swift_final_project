//
//  networking.swift
//  actual_finalPackageDescription
//
//  Created by Alyssa Cox on 12/7/17.
//

import Foundation

enum NetworkingError: Error {
    case urlError
}

// Query the api for first 50 domains
// This line includes the required trailing closure
func getTopDomains(url gitHubURL: String, sort: Bool, completion: @escaping (SearchResults) -> Void) {
    
    // Convert the String into a URL
    guard let url = URL(string: gitHubURL) else {
        fatalError("Unable to create NSURL from string")
    }
    
    // Create a default url session
    let session = URLSession.shared
    
    // Create a data task
    let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
        
        // Ensure there were no errors returned from the request
        guard error == nil else {
            fatalError("Error: \(error!.localizedDescription)")
        }
        
        // Ensure there is data and unwrap it
        guard let data = data else {
            fatalError("Data Error: \(error!.localizedDescription)")
        }
        
        let dataDecoder = JSONDecoder()
        do {
            var results = try dataDecoder.decode(SearchResults.self, from: data)
            if sort {
                var domains = [String]()
                for domain in results.domains! {
                    domains.append(domain)
                }
                results.domains = []
                var sorted = [String]()
//              Here is the call to the required sorting algorithm
                sorted = bubbleSort(array: &domains)
                for domain in sorted {
                    results.domains!.append(domain)
                }
            }
//          This line includes the required higher order function
            results.domains = results.domains!.filter {$0.count < 40}
            completion(results)
            
        } catch {
            print("error serializing JSON: \(error)")
        }
    })
    task.resume()
}


