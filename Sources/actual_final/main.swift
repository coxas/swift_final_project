import Foundation

// error handling for user input
enum InputError: Error {
    case noInput
}
// The results that will come back from the API
public struct SearchResults: Codable {
    let total: Int
    var domains: [String]?
}

// doing equatable and comparable by number of urls only, not actually comparing urls because was not sure how to compare the "value" of urls
extension SearchResults: Equatable, Comparable {
    public static func == (lhs: SearchResults, rhs: SearchResults) -> Bool {
        if lhs.total == rhs.total {
            return true
        }
        else {
            return false
        }
    }
    public static func < (lhs: SearchResults, rhs: SearchResults) -> Bool {
        if lhs.total < rhs.total {
            return true
        }
        else {
            return false
        }
    }
    public static func > (lhs: SearchResults, rhs: SearchResults) -> Bool {
        if lhs.total > rhs.total {
            return true
        }
        else {
            return false
        }
    }
}
extension SearchResults: CustomStringConvertible {
    public var description: String {
        var result = "Number of results: "
        result += String(self.total)
        result += "\n"
        if self.domains != nil {
            for domain in self.domains! {
                result += domain
                result += "\n"
            }
        }
        else {
            result += "Sorry, there were no domains that matched your search."
        }
        return result
    }
}

// Implement sorting algoritm to sort by length of domain
func bubbleSort(array:inout [String]) -> [String] {
    let length = array.count
    for index in 0...length {
        for value in 1...length - 1 {
            if array[value-1].count > array[value].count {
                let longerValue = array[value-1]
                array[value-1] = array[value]
                array[value] = longerValue
            }
        }
    }
    return array
}

func runAPIquery(searchTerm: String, sort: Bool) throws -> String {
    if searchTerm == "" {
        throw InputError.noInput
    }
    else {
        let urlString = "https://api.domainsdb.info/search?query=\(searchTerm)"
        getTopDomains(url: urlString, sort: sort) { (results) in
            print(results)
        }
    }
    print("\n")
    dispatchMain()
    exit(0)
}

var again = "y"

do {
    while again == "y" {
        print("\n***Note: Type '--help' for instructions.***\n")
        print("What is your search term?")
        let userInputWrapped = readLine()
        var userInput = userInputWrapped!
        if userInput == "--help" {
            print("Instructions: This program calls an API that returns currently registered internet domains that contain a given search term. The raw results include the number of registered domains and a list of the first 50, in alphabetical order. However, the resulting legnth of the list might be less than 50 because my program filters out domains with over 40 characters. The user can search for a keyword or for an entire url. The user will also be prompted to answer how they would like to sort the URLs. The default sorting is alphabetically due to the API, but users can choose to sort domains based on length, which uses a bubble sort algorithm.")
            again = "n"
        }
        else {
            userInput = userInput.replacingOccurrences(of: " ", with: "")
            var result = ""
            print("Would you like to sort the domains by length? (Default sorting is alphabetical) [y/n]?")
            let sort = readLine()
            let sort_result = sort!
            if sort_result == "n" {
                try result = runAPIquery(searchTerm: userInput, sort: false)
                print(result)
            }
            else if sort_result == "y" {
                try result = runAPIquery(searchTerm: userInput, sort: true)
                print(result)
            }
            else {
                print("Please only input 'y' or 'n'.")
            }
            
//            try result = runAPIquery(searchTerm: userInput, sort: false)
//            print(result)
            print("Would you like to try another search? [y/n]")
            let againWrapped = readLine()
            again = againWrapped!
        }
    }
} catch InputError.noInput {
    print("Please input a search term")
} catch {
    print("There was an error retrieving the data.")
}
// You need to call exit() to stop the execution or it will run forever...forever...forever
// exit()


