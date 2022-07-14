//
//  ApiClientTests.swift
//  vkServicesAppTests
//
//  Created by Дмитрий Миронов on 13.07.2022.
//

import XCTest
@testable import vkServicesApp

class ApiClientTests: XCTestCase {

    var sut: NetworkManager!
    var mockURLSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut = NetworkManager()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getDataResponse() {
        let completionHandler = {(data: [Service]?, error: Error?) in}
        sut.getData(completion: completionHandler)
    }
    
    func testGetDataUsesCorrectHost() {
        getDataResponse()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "publicstorage.hb.bizmrg.com")
    }
    
    func testGetDataUsesCorrectPath() {
        getDataResponse()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/sirius/result.json")
    }
    
    func testGetDataUsesExpectedQuery() {
        getDataResponse()
        XCTAssertEqual(mockURLSession.urlComponents?.query, nil)
    }
    
    func testGetDataInvalidDataReturnsError() {
        mockURLSession = MockURLSession(data: Data(), urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.getData { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
    
    func testGetDataWhenDataIsNilReturnsError() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.getData { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }

}

extension ApiClientTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        private let mockDataTask: MockURLSessionDataTask
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
//            return URLSession.shared.dataTask(with: url)
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}

