//
//  ServiceTests.swift
//  vkServicesAppTests
//
//  Created by Дмитрий Миронов on 12.07.2022.
//

import XCTest
@testable import vkServicesApp

class ServiceTests: XCTestCase {

    func testInitServiceWithTitle() {
        let service = Service(name: "Foo")
        XCTAssertNotNil(service)
    }
    
    func testInitServiceWithTitleAndDescription() {
        let service = Service(name: "Foo", description: "Bar")
        XCTAssertNotNil(service)
    }
    
    func testWhenGivenNameSetsName() {
        let service = Service(name: "Foo")
        
        XCTAssertEqual(service.name, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let service = Service(name: "Foo", description: "Bar")
        
        XCTAssertEqual(service.description, "Bar")
    }
    
    func testInitServiceWithLink() {
        let service = Service(name: "Foo", link: "Bar")
        XCTAssertNotNil(service.link)
    }
    
    func testInitServiceWithIconUrl() {
        let service = Service(name: "Foo", iconUrl: "Bar")
        XCTAssertNotNil(service.iconUrl)
    }

}
