import CoreData
import ReactiveCocoa
import ReactiveSwift
import Twitter

class HistoryTableViewModel {
    var history: MutableProperty<[String]>
    
    init(history: [String]) {
        self.history = MutableProperty(history)
    }
    
    func getHistory() -> [String] {
        return history.value
    }
}
