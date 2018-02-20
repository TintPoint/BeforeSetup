import Apollo

class Checker {
    private var currentRepository: RepositoryQuery.Data.Repository
    private let expectedRepository: Configurations.Repository
    private var mismatchCount: Int = 0
    
    init(expect currentRepository: RepositoryQuery.Data.Repository, equals expectedRepository: Configurations.Repository) {
        self.currentRepository = currentRepository
        self.expectedRepository = expectedRepository
    }
    
    private func checkMismatch(of label: String, expect currentValue: AnyHashable?, equals expectedValue: AnyHashable, outputIndentation numberOfSpaces: Int) {
        let indentation = String(repeating: " ", count: numberOfSpaces)
        if currentValue == expectedValue {
            Terminal.output("\(indentation)☑ \(label): \"\(expectedValue)\"")
        } else {
            Terminal.output("\(indentation)☒ \(label): should be \"\(expectedValue)\" but currently is \"\(currentValue?.description ?? "nil")\"")
            mismatchCount += 1
        }
    }
    
    private func checkMismatch(of label: String, expect currentValue: [AnyHashable]?, equals expectedValue: [AnyHashable], outputIndentation numberOfSpaces: Int) {
        let indentation = String(repeating: " ", count: numberOfSpaces)
        if expectedValue.count == currentValue?.count && zip(expectedValue, currentValue ?? []).reduce(true, { $0 && $1.0 == $1.1 }) {
            Terminal.output("\(indentation)☑ \(label): \"\(expectedValue.map(String.init))\"")
        } else {
            Terminal.output("\(indentation)☒ \(label): should be \"\(expectedValue.map(String.init))\" but currently is \"\(currentValue?.map(String.init) ?? ["nil"])\"")
            mismatchCount += 1
        }
    }
    
    private func checkCountMismatch(of label: String, expect currentCount: Int, equals expectedCount: Int, outputIndentation numberOfSpaces: Int) {
        let indentation = String(repeating: " ", count: numberOfSpaces)
        if currentCount == expectedCount {
            Terminal.output("\(indentation)☑ \(label) (\(expectedCount) item(s)):")
        } else {
            Terminal.output("\(indentation)☒ \(label): should have \(expectedCount) item(s) but currently has \(currentCount) item(s)")
            mismatchCount += 1
        }
    }
    
    private func expect(_ current: JSONObject, equals expected: Mirror, recursiveLevel: Int) {
        let numberOfSpaces = recursiveLevel * 2
        for case (let label?, Optional<Any>.some(let value)) in expected.children {
            switch (value, current[label]) {
            case let (expectedValues, currentValues) as ([AcceptableNonliteral], JSONObject):
                let currentValues = currentValues["nodes"] as? [JSONObject] ?? []
                checkCountMismatch(of: label, expect: currentValues.count, equals: expectedValues.count, outputIndentation: numberOfSpaces)
                for (expectedValue, currentValue) in zip(expectedValues, currentValues) {
                    expect(currentValue, equals: Mirror(reflecting: expectedValue), recursiveLevel: recursiveLevel + 1)
                }
            case let (expectedValue, currentValue) as (AcceptableNonliteral, JSONObject):
                let expectedValue = Mirror(reflecting: expectedValue)
                checkCountMismatch(of: label, expect: currentValue.count - 1, equals: Int(expectedValue.children.count), outputIndentation: numberOfSpaces) // currentValue contains 1 extra type value
                expect(currentValue, equals: expectedValue, recursiveLevel: recursiveLevel + 1)
            case let (expectedValue, currentValue) as ([AnyHashable], [AnyHashable]?):
                checkMismatch(of: label, expect: currentValue, equals: expectedValue, outputIndentation: numberOfSpaces)
            case let (expectedValue, currentValue) as (AnyHashable, AnyHashable?):
                checkMismatch(of: label, expect: currentValue, equals: expectedValue, outputIndentation: numberOfSpaces)
            case let (expectedValue, currentValue):
                let expectedValue = String(describing: expectedValue)
                let currentValue = String(describing: currentValue)
                checkMismatch(of: label, expect: currentValue, equals: expectedValue, outputIndentation: numberOfSpaces)
            }
        }
    }
    
    func validate() {
        mismatchCount = 0
        // Special case: sort labels by name (currently GitHub doesn't provide sorting API for labels)
        currentRepository.labels?.nodes?.sort { first, second in
            return (first?.name ?? "") < (second?.name ?? "")
        }
        expect(currentRepository.jsonObject, equals: Mirror(reflecting: expectedRepository), recursiveLevel: 0)
        switch mismatchCount {
        case 0: Terminal.output("Congratulations! All tests are passed.")
        default: Terminal.output("You have \(mismatchCount) mismatch(es).")
        }
    }
}
