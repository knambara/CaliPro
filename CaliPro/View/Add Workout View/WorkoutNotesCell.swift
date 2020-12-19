//
//  WorkoutNotesCell.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/09.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class WorkoutNotesCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var placeholder: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    var delegate: AddWorkoutTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notesTextView.delegate = self
        notesTextView.isScrollEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            notesTextView.becomeFirstResponder()
        } else {
            notesTextView.resignFirstResponder()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        /**
            Calculate the minimum bounding rect for the text in the text view
            Constrain this value to a minimum of 50.0 just for a nicer layout
            Update our text view bounds
            Let the table view update itself/relayout
        */
        let size = notesTextView.bounds.size
        let newSize = notesTextView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            
            if let thisIndexPath = tableView?.indexPath(for: self) {
                tableView?.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
        
        guard let notes = notesTextView.text else { return }
        delegate?.cellContentChanged(cellIdentifier: "WorkoutNotesCell", content: notes)
    }
    
}

extension UITableViewCell {
    /// Search up the view hierarchy of the table view cell to find the containing table view
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }

            return table as? UITableView
        }
    }
}
