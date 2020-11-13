//
//  ViewController.swift
//  Project7
//
//  Created by Kocfinans on 31.08.2020.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(whoAreWe))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(promptForAnswer))
        
        var urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                print(data)
                return
            }
        }
        showAlert()
    }
    
    @objc func whoAreWe() {
        let ac = UIAlertController(title: "Who are we?", message: "You are getting this info from the official White House API", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Thanks", style: .default))
        present(ac, animated: true)
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.filterPetitions(filterWord: answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func filterPetitions(filterWord: String) {
        if filterWord.isEmpty {
            filteredPetitions = petitions
            tableView.reloadData()
        } else {
            filteredPetitions = petitions.filter { $0.title.contains(filterWord) }
            tableView.reloadData()
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
    
    func showAlert() {
        let ac = UIAlertController(title: "Loading error", message: "There is a problem with the api or your connection", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

