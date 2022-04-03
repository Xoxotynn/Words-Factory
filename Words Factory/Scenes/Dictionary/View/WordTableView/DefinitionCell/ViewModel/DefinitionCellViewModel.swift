import Foundation
import UIKit

class DefinitionCellViewModel {
    
    // MARK: - Properties
    let definition: String
    lazy var attributedExample: NSMutableAttributedString = {
        NSMutableAttributedString(
            string: R.string.dictionary.examplePrefix() + example)
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
        
        let exampleText = NSString(
            string: R.string.dictionary.examplePrefix() + example)
        let range = exampleText.range(
            of: R.string.dictionary.examplePrefix())
        
        if range.length > 0 {
            attributedExample.addAttribute(
                .foregroundColor,
                value: R.color.lightBlue() ?? .systemBlue,
                range: range)
        }
        
        didSetupExample?(true)
    }
}
