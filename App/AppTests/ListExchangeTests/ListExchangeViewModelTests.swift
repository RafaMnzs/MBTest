import XCTest
@testable import App

final class ListExchangeViewModelTests: XCTestCase {
    
    private var sut: ListExchangesViewModel!
    private var output: MockListExchangeOutput!
    private var service: MockListExchangeService!

    override func setUpWithError() throws {
        service = MockListExchangeService()
        output = MockListExchangeOutput()
        sut = ListExchangesViewModel(service: service)
        sut.delegate = output
    }

    override func tearDownWithError() throws {
        sut = nil
        service = nil
        try super.tearDownWithError()
    }

    func test_onAPI_Success() {
        let exchange = Exchange(exchangeID: "625364", website: "https://bitcoin.org/en/", name: "BITCOIN", dataSymbolsCount: 967, volume1HrsUsd: 1236787.648, volume1DayUsd: 75694.98, volume1MthUsd: 0885.89)
        var exchanges = [Exchange]()
        exchanges.append(exchange)
        service.mockResult = .success(exchanges)
        sut.fetch()
        XCTAssertNil(output.err)
        XCTAssertEqual(sut.exchanges.count, 1)
    }
    
    func test_onAPI_Failure() {
        let err = NSError(domain: "https://rest.coinapi.io", code: 404)
        service.mockResult = .failure(err)
        sut.fetch()
        XCTAssertNotNil(output.err)
    }

}

class MockListExchangeService:  ListExchangeServiceProtocol {
    var mockResult: Result<[App.Exchange], Error>?
    func fetchExchanges(completion: @escaping (Result<[App.Exchange], Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}

class MockListExchangeOutput: ListExchangesViewModelOutput {
    var err: Error!
    func updateView(err: Error?) {
        self.err = err
    }
}
