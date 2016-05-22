import Cocoa
import AlamofireImage

class ViewController: NSViewController {

    @IBOutlet weak var photoView: NSImageView!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var tableView: NSTableView!

    override func viewDidAppear() {
        super.viewDidAppear()
    }
}


extension ViewController: NSTableViewDataSource, NSTableViewDelegate {

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 0
    }

    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeViewWithIdentifier("SaleCell", owner: self) as? SaleCellView else { return NSView() }
        cell.photoView.af_setImageWithURL(NSURL())
        cell.nameLabel.stringValue = ""
        return cell
    }

    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        photoView.af_setImageWithURL(NSURL())
        nameLabel.stringValue = ""
        descriptionLabel.stringValue = ""
        return true
    }
}
