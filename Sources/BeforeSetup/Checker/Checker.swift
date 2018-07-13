import Apollo

class Checker {
    private var currentRepository: RepositoryQuery.Data.Repository
    private let expectedRepository: Configurations.Repository
    private var mismatchCount: Int = 0

    init(expect currentRepository: RepositoryQuery.Data.Repository, equals expectedRepository: Configurations.Repository) {
        self.currentRepository = currentRepository
        self.expectedRepository = expectedRepository
    }

    func validate() -> Int {
        mismatchCount = 0
        // Special case: sort labels by name (currently GitHub doesn't provide sorting API for labels)
        currentRepository.labels?.nodes?.sort { first, second in
            (first?.name ?? "") < (second?.name ?? "")
        }
        expect(currentRepository.jsonObject, equals: Mirror(reflecting: expectedRepository), recursiveLevel: 0)
        return mismatchCount
    }
}

private extension Checker {
    func check(label: String, outputIfMatch: String, outputIfMismatch: String, outputIndentation numberOfSpaces: Int, using closure: () -> Bool) {
        let isMatch = closure()
        let text = isMatch ? outputIfMatch : outputIfMismatch
        Terminal.output(indentation: numberOfSpaces, isMatch: isMatch, label: label, text: text)
        if !isMatch {
            mismatchCount += 1
        }
    }

    func check(_ label: String, expect currentValue: AnyHashable?, equals expectedValue: AnyHashable, outputIndentation numberOfSpaces: Int) {
        let matchOutput = """
        "\(expectedValue)"
        """
        let mismatchOutput = """
        should be "\(expectedValue)" but currently is "\(currentValue?.description ?? "nil")"
        """
        check(label: label, outputIfMatch: matchOutput, outputIfMismatch: mismatchOutput, outputIndentation: numberOfSpaces) {
            currentValue == expectedValue
        }
    }

    func check(_ label: String, expect currentValue: [AnyHashable]?, equals expectedValue: [AnyHashable], outputIndentation numberOfSpaces: Int) {
        let matchOutput = """
        "\(expectedValue)"
        """
        let mismatchOutput = """
        should be "\(expectedValue)" but currently is "\(currentValue ?? [])"
        """
        check(label: label, outputIfMatch: matchOutput, outputIfMismatch: mismatchOutput, outputIndentation: numberOfSpaces) {
            expectedValue == currentValue
        }
    }

    func check(_ label: String, expect currentCount: Int, equals expectedCount: Int, outputIndentation numberOfSpaces: Int) {
        let matchOutput = """
        \(expectedCount) items
        """
        let mismatchOutput = """
        should have \(expectedCount) items but currently has \(currentCount) items
        """
        check(label: label, outputIfMatch: matchOutput, outputIfMismatch: mismatchOutput, outputIndentation: numberOfSpaces) {
            currentCount == expectedCount
        }
    }

    func expect(_ current: JSONObject, equals expected: Mirror, recursiveLevel: Int) {
        let numberOfSpaces = recursiveLevel * 2
        for case let (label?, value as Optional<Any>) in expected.children {
            guard value != nil else { continue }
            switch (value, current[label]) {
            case let (expectedValues, currentValues) as ([AcceptableNonliteral], JSONObject):
                let currentValues = currentValues["nodes"] as? [JSONObject] ?? []
                check(label, expect: currentValues.count, equals: expectedValues.count, outputIndentation: numberOfSpaces)
                for (expectedValue, currentValue) in zip(expectedValues, currentValues) {
                    expect(currentValue, equals: Mirror(reflecting: expectedValue), recursiveLevel: recursiveLevel + 1)
                }
            case let (expectedValue, currentValue) as (AcceptableNonliteral, JSONObject):
                let expectedValue = Mirror(reflecting: expectedValue)
                Terminal.output(indentation: numberOfSpaces, isMatch: true, label: label, text: "")
                expect(currentValue, equals: expectedValue, recursiveLevel: recursiveLevel + 1)
            case let (expectedValue, currentValue) as (AnyHashable, AnyHashable?):
                check(label, expect: currentValue, equals: expectedValue, outputIndentation: numberOfSpaces)
            case let (expectedValue, currentValue) as ([AnyHashable], [AnyHashable]?):
                check(label, expect: currentValue, equals: expectedValue, outputIndentation: numberOfSpaces)
            case let (expectedValue, currentValue):
                let expectedValue = String(describing: expectedValue)
                let currentValue = String(describing: currentValue)
                check(label, expect: currentValue, equals: expectedValue, outputIndentation: numberOfSpaces)
            }
        }
    }
}

private extension Terminal {
    static func output(indentation numberOfSpaces: Int, isMatch: Bool, label: String, text: String) {
        let indentation = String(repeating: " ", count: numberOfSpaces)
        let mark = isMatch ? "☑" : "☒"
        Terminal.output("\(indentation)\(mark) \(label): \(text)", color: isMatch ? .default : .yellow)
    }
}
