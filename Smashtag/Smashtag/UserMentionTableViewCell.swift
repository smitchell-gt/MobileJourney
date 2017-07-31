import UIKit

class UserMentionTableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    
    var username: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        userLabel.text = username
    }

}
