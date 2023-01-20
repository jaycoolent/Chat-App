//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [ // create a new variable called messages which is going to contain an array of message objects.
        Message(sender: "1@2.com", body: "Yo"),
        Message(sender: "3@4.com", body: "Hey"),
        Message(sender: "1@2.com", body: "What's good?"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true // How to hide the back button
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
        
        func loadMessages() {
            messages = []
            
            db.collection(K.FStore.collectionName)
                .order(by: K.FStore.dateField)
                .addSnapshotListener { (querySnapshot, error) in
                    
                    self.messages = []
                    
                    if let e = error {
                        print("There was an issue retreiving data from Firestore. \(e)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                    let newMessage = Message(sender: messageSender, body: messageBody)
                                    self.messages.append(newMessage)
                                    
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                        // how to avoid scrolling manually to see a new message. We set the section to 0 because we only have one section.
                                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
        }
        
        
    }
    
    // We have created our data dictionary. Next is the completion handler.
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if error != nil {
                    print("There was an issue with saving data")
                } else {
                    print("successfully saved data")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            
            // Navigation to the welcome screen
            
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

// TableViewDataSource means that when our table view loads up its going to make a request for data. In our viewdidload, we're going to say that the tableview's data source is going to be set as "self".

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count // to return a number dynamically depending on how many messages there are in this array.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        
        // Message from current user.
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            
        }
        // this is a message from another sender.
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
    
}
// I want to give the cell some data. So edit the text label property. Access row number by the indexpath property. However since .row is an "Int" to we must turn it into a string by "indexPath.row" and use the string interpolation method. When we run the app, we see the row numbers printed on the text label. How can we use the indexPath.row in order to pull out the body of the message from our messages array? Put the indexPath.row inside some square brackets to subscript our messages array with this number. So that means when the TV is requesting data for the 0 row, then this is going to be equal to 0.

// cell.textLabel?.text = messages[indexPath.row].body



