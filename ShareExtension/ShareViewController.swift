//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Softsuave-iOS dev on 24/01/25.
//

import UIKit
import Social

struct UserData: Codable {
    let name: String
    let mobile: String
    var selected: Bool
}

class ShareViewController: UIViewController {
    
    var selectedList: [UserData] = []
    
    var userData:[UserData] = [
        UserData(name: "Mani", mobile: "99999999", selected: false),
        UserData(name: "Mani", mobile: "44444444", selected: false),
        UserData(name: "Mani", mobile: "66666666", selected: false),
        UserData(name: "Mani", mobile: "88888888", selected: false),
        UserData(name: "Mani", mobile: "11111111", selected: false),
        UserData(name: "Mani", mobile: "22222222", selected: false),
        UserData(name: "Mani", mobile: "33333333", selected: false),
        UserData(name: "Mani", mobile: "00000000", selected: false),
        UserData(name: "Mani", mobile: "55555555", selected: false),
        UserData(name: "Mani", mobile: "77777777", selected: false),
    ]

    private let imagePreview = UIImageView()
    private let previewsTable = UITableView()
    private let confirmButton = UIButton()
    private let searchView = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureConfirmButton()
        configureSearchView()
        setupLayout()
        getImageData()
        confirmButton.addTarget(self, action: #selector(actionOnSend), for: .touchUpInside)
    }
    
    @objc func actionOnSend() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    func configureSearchView() {
     
    }

    func configureTable() {
        previewsTable.backgroundColor = .white
        previewsTable.delegate = self
        previewsTable.dataSource = self
        previewsTable.register(ContactViewTableViewCell.self, forCellReuseIdentifier: "preview")
        previewsTable.separatorStyle = .none
    }

    func configureConfirmButton() {
        confirmButton.setTitle("Send", for: .normal)
        confirmButton.backgroundColor = .systemGray
        confirmButton.layer.cornerRadius = 14
        confirmButton.isEnabled = false
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
  

    func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        view.addSubview(imagePreview)
        imagePreview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePreview.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 14),
            imagePreview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePreview.widthAnchor.constraint(equalToConstant: 90),
            imagePreview.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.heightAnchor.constraint(equalToConstant: 56),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            confirmButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14)
        ])

        view.addSubview(previewsTable)
        previewsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            previewsTable.topAnchor.constraint(equalTo: imagePreview.bottomAnchor, constant: 24),
            previewsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            previewsTable.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -24)
        ])
    }

    
    func getImageData() {
        if let inputItems = extensionContext?.inputItems as? [NSExtensionItem], let attachments = inputItems.first?.attachments {
            for attachment in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.image") {
                        attachment.loadItem(forTypeIdentifier: "public.image", options: nil) { [weak self] (data, error) in
                            if let error = error {
                                print("Error loading image: \(error.localizedDescription)")
                                return
                            }
                            
                            if let imageURL = data as? URL {
                                // Load image from URL
                                self?.loadImage(from: imageURL)
                            } else if let image = data as? UIImage {
                                // Directly set UIImage
                                DispatchQueue.main.async {
                                    self?.imagePreview.image = image
                                }
                            }
                        }
                    }
                }
        }
    }
    
    private func loadImage(from url: URL) {
        // Load image data asynchronously
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.imagePreview.image = image
                }
            }
        }
    }
}


extension ShareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preview") as! ContactViewTableViewCell
        cell.titleLabel.text = "Title \(indexPath.row)"
               cell.subtitleLabel.text = "Subtitle for row \(indexPath.row)"
        let data = userData[indexPath.row]
        cell.configureCell(userData: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let selectedItem = userData[indexPath.row]
        if selectedList.isEmpty {
            selectedList.append(selectedItem)
        } else if selectedList.contains(where: {$0.mobile == selectedItem.mobile}) {
            selectedList.removeAll(where: {$0.mobile == selectedItem.mobile})
        } else {
            selectedList.append(selectedItem)
        }
        userData[indexPath.row].selected.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
        let isEmpty = selectedList.isEmpty
        
        confirmButton.isEnabled = !isEmpty
        confirmButton.backgroundColor = !isEmpty ? .systemGray : .systemTeal
        
        if selectedList.isEmpty {
            confirmButton.isEnabled = false
            confirmButton.backgroundColor = .systemGray
        } else {
            confirmButton.backgroundColor = .systemTeal
            confirmButton.isEnabled = true
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}
    
