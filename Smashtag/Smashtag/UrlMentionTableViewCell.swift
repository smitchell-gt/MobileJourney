import UIKit

class UrlMentionTableViewCell: UITableViewCell {

    @IBOutlet weak var urlLabel: UILabel!
    
    var url: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        urlLabel.text = url
    }
    
}
