import Foundation
import UIKit

// MARK: - Strings
private extension Strings {
    static let example = "Example: "
}

class DefinitionCellViewModel {
    
    // MARK: - Properties
    let definition: String
    lazy var attributedExample: NSMutableAttributedString = {
        NSMutableAttributedString(string: Strings.example + example)
    }()
    
    var didSetupDefinition: (() -> Void)?
    var didSetupExample: ((Bool) -> Void)?
    
    private let example: String
    
    // MARK: - Init
    init(definition: Definition) {
        self.definition = definition.definition
        self.example = definition.example
    }
    
    // MARK: - Public methods
    func setupDefinition() {
        didSetupDefinition?()
        guard !example.isEmpty else {
            didSetupExample?(false)
            return
        }
        
        let exampleText = NSString(string: Strings.example + example)
        let range = exampleText.range(of: Strings.example)
        if range.length > 0 {
            attributedExample.addAttribute(
                .foregroundColor,
                value: R.color.lightBlue() ?? .systemBlue,
                range: range)
        }
        
        didSetupExample?(true)
    }
}
