import UIKit
import ReactiveCocoa
import ReactiveSwift
import Twitter

class MentionsTableViewController: UITableViewController {
    
    var viewModel: MentionsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.getAuthorName()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows: Int
        
        if section == 0 {
            numberOfRows = viewModel.getImages().count
        } else if section == 1 {
            numberOfRows = viewModel.getHashtagMentions().count
        } else if section == 2 {
            numberOfRows = viewModel.getUserMentions().count
        } else if section == 3 {
            numberOfRows = viewModel.getUrlMentions().count
        } else {
            numberOfRows = 0
        }
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "imageMention", for: indexPath)
            if let imageCell = cell as? ImageTableViewCell {
                imageCell.tweetImage = viewModel.getImages()[indexPath.row]
            }
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "hashtagMention", for: indexPath)
            if let hashtagCell = cell as? HashtagMentionTableViewCell {
                hashtagCell.hashtag = viewModel.getHashtagMentions()[indexPath.row].keyword
            }
        } else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "userMention", for: indexPath)
            if let userCell = cell as? UserMentionTableViewCell {
                userCell.username = viewModel.getUserMentions()[indexPath.row].keyword
            }
        } else if indexPath.section == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "urlMention", for: indexPath)
            if let urlCell = cell as? UrlMentionTableViewCell {
                urlCell.url = viewModel.getUrlMentions()[indexPath.row].keyword
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "resueIdentifier", for: indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let imageIndex = indexPath.row
            let image = viewModel.getImages()[imageIndex]
            return tableView.rowHeight * CGFloat(image.aspectRatio)
        }
        
        return tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        if section == 0 {
            if viewModel.getImages().count > 0 {
                title = "Images"
            }
        } else if section == 1 {
            if viewModel.getHashtagMentions().count > 0 {
                title = "Hashtags"
            }
        } else if section == 2 {
            if viewModel.getUserMentions().count > 0 {
                title = "Users"
            }
        } else if section == 3 {
            if viewModel.getUrlMentions().count > 0 {
                title = "URLs"
            }
        }
        
        return title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let url = viewModel.getUrlMentions()[indexPath.row].keyword
            if url != "" {
                UIApplication.shared.open(URL(string: url)!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCellIndexPath = self.tableView.indexPathForSelectedRow!
        let cellRow = selectedCellIndexPath.row
        
        if let destinationViewController = segue.destination as? TweetTableViewController {
            if segue.identifier == "HashtagSearch" {
                let hashtag = viewModel.getHashtagMentions()[cellRow].keyword
                destinationViewController.viewModel = TweetTableViewModel(searchText: hashtag)
            } else if segue.identifier == "UsernameSearch" {
                let username = viewModel.getUserMentions()[cellRow].keyword
                destinationViewController.viewModel = TweetTableViewModel(searchText: username)
            }
        }
    }
    
}
