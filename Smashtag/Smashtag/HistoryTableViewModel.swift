import Foundation
import ReactiveCocoa
import ReactiveSwift
import Twitter

class HistoryTableViewModel {
    var history: MutableProperty<[String]>
    
    init() {
        history = MutableProperty([])
    }
    
    func getHistory() -> [String] {
        return history.value
    }
}
