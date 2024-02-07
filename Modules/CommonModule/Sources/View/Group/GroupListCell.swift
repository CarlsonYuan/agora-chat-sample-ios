//
//  GroupListCell.swift
//  CommonModule
//
//  Created by Carlson Yuan on 2023/8/7.
//

import UIKit
import AgoraChat

open class GroupListCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    open func configure(with group: AgoraChatGroup) {
        if #available(iOS 14.0, *) {
            var content = defaultContentConfiguration()
            content.text = group.groupName
            content.secondaryText = group.description
            contentConfiguration = content
        } else {
            textLabel?.text = group.groupName
            detailTextLabel?.text = group.description
        }
    }
    
}
