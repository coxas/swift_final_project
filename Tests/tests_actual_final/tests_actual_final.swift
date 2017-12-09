//
//  tests_actual_final.swift
//  tests_actual_final
//
//  Created by Alyssa Cox on 12/8/17.
//

import XCTest
//@testable import actual_final

class tests_actual_final: XCTestCase {
    func test_results_creation() {
        let example1 = SearchResults(total:100, domains:["abc.com", "abcd.com", "abcde.com"])
        XCTAssertEqual(example1.total, 100)
        XCTAssertEqual(example1.domains!, ["abc.com", "abcd.com", "abcde.com"])
    }
    func test_equatable() {
        let example1 = SearchResults(total:100, domains:["abc.com", "abcd.com", "abcde.com"])
        let example2 = SearchResults(total:100, domains:["xyz.com"])
        XCTAssertEqual(example1, example2)
    }
    func test_comparable() {
        let example1 = SearchResults(total:100, domains:["abc.com", "abcd.com", "abcde.com"])
        let example2 = SearchResults(total:153, domains:["xyz.com"])
        let result = example2 > example1
        XCTAssert(result)
    }
    func test_bubbleSort() {
        var example1 = ["abcd.com", "xyz.com", "swiftisgreat.com", "bc.io"]
        let example2 = ["bc.io", "xyz.com", "abcd.com", "swiftisgreat.com"]
        let test1 = bubbleSort(array: &example1)
        XCTAssertEqual(example2, test1)
    }
}
