import Foundation

class MeaningsHeaderViewModel {
    
    // MARK: Properties
    let speechPart: String
    
    var didSetupSpeechPart: (() -> Void)?
    
    // MARK: Init
    init(speechPart: String) {
        self.speechPart = speechPart
    }
    
    // MARK: Public methods
    func setupSpeechPArt() {
        didSetupSpeechPart?()
    }
}
