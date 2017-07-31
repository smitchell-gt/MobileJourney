import UIKit

class HashtagMentionTableViewCell: UITableViewCell {

    @IBOutlet weak var hashtagLabel: UILabel!
    
    var hashtag: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        hashtagLabel.text = hashtag
    }

}
