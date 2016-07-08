import XCTest
import Onigmo

class OnigmoTests: XCTestCase {
    func testOnigmo() {
        do {
            let onigmoRegex = try OnigmoRegularExpression(pattern: "a(.*)b|[e-f]+", options: .Default)
            let matches = try onigmoRegex.matchesInString("zzzzaffffffffb")
            XCTAssertEqual(matches["0"]?.rangeValue.location, 4)
            XCTAssertEqual(matches["0"]?.rangeValue.length, 10)
            XCTAssertEqual(matches["1"]?.rangeValue.location, 5)
            XCTAssertEqual(matches["1"]?.rangeValue.length, 8)
        } catch {
            XCTAssertNil(error)
        }
    }

    func testThrowsAnErrorWhenInvalidRegex() {
        do {
            let regex = try OnigmoRegularExpression(pattern: "^\\1$", options: .Default)
            XCTAssertNil(regex)
        } catch {
            XCTAssertEqual((error as NSError).code, -208)
            XCTAssertEqual((error as NSError).localizedDescription, "invalid backref number/name")
        }
    }

    func testHelloWorldRegex() {
        do {
            let regex = try OnigmoRegularExpression(pattern: "world(!?)", options: .FindLongest)
            let matches = try regex.matchesInString("hello world!")
            XCTAssertEqual(matches["0"]?.rangeValue.location, 6)
            XCTAssertEqual(matches["0"]?.rangeValue.length, 5)
            XCTAssertEqual(matches["1"]?.rangeValue.location, 11)
            XCTAssertEqual(matches["1"]?.rangeValue.length, 1)
        } catch {
            XCTAssertNil(error)
        }
    }
}
