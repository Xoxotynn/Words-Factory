import Foundation
import UIKit

// MARK: Strings
private extension Strings {
    static let example = "Example: "
}

class DefinitionCellViewModel {
    
    // MARK: Properties
    let definition: String
    let attributedExample: NSMutableAttributedString?
    
    var didSetupDefinition: (() -> Void)?
    var didSetupExample: ((Bool) -> Void)?
    
    private let example: String?
    
    // MARK: Init
    init(definition: Definition) {
        self.definition = definition.definition
        if let example = definition.example {
            self.example = Strings.example + example
            attributedExample = NSMutableAttributedString(
                string: Strings.example + example)
        } else {
            self.example = nil
            attributedExample = nil
        }
    }
    
    // MARK: Public methods
    func setupDefinition() {
        didSetupDefinition?()
        guard let example = example,
              let attributedExample = attributedExample,
              !example.isEmpty else {
            didSetupExample?(true)
            return
        }
        
        let range = (example as NSString).range(of: Strings.example)
        if range.length > 0 {
            attributedExample.addAttribute(
                .foregroundColor,
                value: UIColor.secondary ?? .systemBlue,
                range: range)
        }
        
        didSetupExample?(false)
    }
}
