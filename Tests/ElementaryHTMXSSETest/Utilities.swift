import Elementary
import XCTest

func HTMLAttributeAssertEqual(_ attribute: HTMLAttribute<HTMLTag.div>, _ name: String, _ value: String?, file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertEqual(name, attribute.name, file: file, line: line)
    XCTAssertEqual(value, attribute.value, file: file, line: line)
}
