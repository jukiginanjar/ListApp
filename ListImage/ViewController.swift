//
//  ViewController.swift
//  ListImage
//
//  Created by Nanang Rafsanjani on 14/03/19.
//  Copyright © 2019 Nanang Rafsanjani. All rights reserved.
//

import UIKit

struct CoverResponse: Codable {
    var top: [Cover]
}

struct Cover: Codable {
    var title: String
    var imageUrl: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    
    private var covers: [Cover] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://private-anon-b223ed3554-jikan.apiary-proxy.com/v3/top/anime/1/upcoming") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let data = data,
                let result = try? decoder.decode(CoverResponse.self, from: data) else {
                    return
            }
            
            DispatchQueue.main.async {
                self?.covers = result.top
            }            
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cover_cell") as! CoverTableViewCell
        cell.cover = covers[indexPath.row]
        return cell
    }
}

