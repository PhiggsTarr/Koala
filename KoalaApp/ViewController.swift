//
//  ViewController.swift
//  KoalaApp
//
//  Created by Kevin Tarr on 9/19/22.
//

import UIKit

class ViewController: UITableViewController{
    //Creates a model array to populate with the ModelData elements once the network call is made
    var model: [ModelData] = []
    var detailViewController = DetailViewController()
    static var imageData = URL(string: "")
    static var detailNameLabel = ""
    var modelCount = 0
    static var images: [ModelData] = []
    static var imageCellSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Main View"
        tableView.backgroundColor = .systemTeal
        
        Task {
            //Uses the NetworkingLayer to make the network call and load the model array with the JSON elements
            model = await NetworkingLayer().loadData()
            self.tableView.reloadData()
            modelCount = model.count
            ViewController.images = model.filter{$0.type == "image"}
        }
        
        //Sets the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.font: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All", style: .plain, target: self, action: #selector(reload))
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Sets our tableView rows to the number of elements in our model array
        model = model.filter{$0.type != "other"}
        return model.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //Sets our tableview section to 1 section
        1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let modelData = model[indexPath.row]
        
        if modelData.type == "image"{
            if let cell =  tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as? PictureTableViewCell{
                cell.data = model[indexPath.row]
                return cell
            }
            return UITableViewCell()
        }
        
        if modelData.type == "text"{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell{
                cell.data = model[indexPath.row]
                return cell
            }
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(model[indexPath.row].id)
        
        ImageViewController.imageUrl = URL(string: model[indexPath.row].modelData!)
        //Sets the image for the row the user selected to be the imageData for the detail view
    }
    
    @objc func reload(){
        
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        
        
        let controller = UIAlertController(title: "Sort Options", message: "Choose your sorting preference", preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Only Images", style: .default, handler: { _ in
            //Uses the NetworkingLayer to make the network call and load the model array with the JSON elements
            if self.modelCount == self.model.count{
                self.model = self.model.filter{$0.type == "image"}
                
                self.tableView.reloadData()
            }
            else{
                
                Task {
                    self.model = await NetworkingLayer().loadData()
                    self.model = self.model.filter{$0.type == "image"}
                    
                    self.tableView.reloadData()
                }
            }
            self.navigationItem.rightBarButtonItem?.title = "Images"
        }))
        
        controller.addAction(UIAlertAction(title: "Only Text", style: .default, handler: { _ in
            if self.modelCount == self.model.count{
                self.model = self.model.filter{$0.type == "text"}
                
                self.tableView.reloadData()
            }
            else{
                
                Task {
                    self.model = await NetworkingLayer().loadData()
                    self.model = self.model.filter{$0.type == "text"}
                    self.tableView.reloadData()
                }
            }
            self.navigationItem.rightBarButtonItem?.title = "Text"
        }))
        controller.addAction(UIAlertAction(title: "All", style: .default,  handler: { _ in
            Task {
                //Uses the NetworkingLayer to make the network call and load the model array with the JSON elements
                self.model = await NetworkingLayer().loadData()
                self.tableView.reloadData()
            }
            self.navigationItem.rightBarButtonItem?.title = "All"
        }))
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
}

//Extension to load imageview
extension UIImageView {
    
    func load(url: URL){
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            //Checking for error if HTTP timesout or throws an exception error
            if error != nil {
                DispatchQueue.main.async {
                    self.image = #imageLiteral(resourceName: "image-not-found copy.jpeg")
                }
                return
            }
            
            //Checking the response object to check the HTTP status code and set image based on the response code. If we get a response code between 200 and 299 then we have a valid HTTP response for our image and we can load our image from the network call
            if let response = response as? HTTPURLResponse {
                if 200...299 ~= response.statusCode {
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                    //If our HTTP response is outside of the valid range of 200 to 299 then we load our "Photo Not Available" stock photo
                } else {
                    DispatchQueue.main.async {
                        self.image = #imageLiteral(resourceName: "image-not-found copy.jpeg")
                    }
                    return
                }
            }
        }
        dataTask.resume()
    }
    
}

var activityIndicator: UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView(style: .medium)
    return indicator
}
