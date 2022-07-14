//
//  ServiceListViewControllerTests.swift
//  vkServicesAppTests
//
//  Created by Дмитрий Миронов on 12.07.2022.
//

import XCTest
@testable import vkServicesApp

class ServiceListViewControllerTests: XCTestCase {

    var sut: ServiceListViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ServiceListViewController.self))
            
        sut = vc as? ServiceListViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testNumberOfRowsIsServiceCount() {
        let tableView = UITableView()
        tableView.dataSource = sut
        
        sut.services.append(Service(name: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.services.append(Service(name: "Bar"))
        tableView.reloadData()

        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNameAndDescriptionInCell() {
        sut.loadViewIfNeeded()
        sut.services.append(Service(name: "Foo",description: "Bar"))
        let tableView = sut.tableView
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView!.dataSource?.tableView(tableView!, cellForRowAt: index) as? ServiceCell
        XCTAssertEqual(cell?.nameLabel.text, "Foo")
        XCTAssertEqual(cell?.descriptionLabel.text, "Bar")
    }

}
