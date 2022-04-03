import Foundation

class MeaningsSectionViewModel {
    
    // MARK: - Properties
    let meaningsHeaderViewModel: MeaningsHeaderViewModel
    
    var rowsNumber: Int {
        definitionCellViewModels.count
    }
    
    private let definitionCellViewModels: [DefinitionCellViewModel]
    
    // MARK: - Init
    init(meaning: Meaning) {
        meaningsHeaderViewModel = MeaningsHeaderViewModel(
            speechPart: meaning.speechPart)
        definitionCellViewModels = meaning.definitions
            .map { DefinitionCellViewModel(definition: $0) }
    }
    
    func getDefinitionCellViewModel(forRow row: Int) throws
    -> DefinitionCellViewModel {
        guard row >= 0, row < rowsNumber else {
            throw SystemError.indexOutOfRange
        }
        
        return definitionCellViewModels[row]
    }
}
