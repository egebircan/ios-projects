
import UIKit

class ViewController: UITableViewController {
  var textLabel: UILabel?
  
  lazy var textField: UITextField! = { [unowned self] in
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Enter your name"
    textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    return textField
  }()
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    guard let newText = textField.text else {
      return
    }
    textLabel?.text = "Your name is \(newText)"
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    if indexPath.row == 0 {
      cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath)
      cell.contentView.addSubview(textField)
      setConstraint(in: cell)
    }else{
      cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
      textLabel = cell.textLabel
      textLabel?.text = "Your name is \("")"
    }
    return cell
  }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TextFieldCell")
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LabelCell")
    }

  
  private func setConstraint(in cell: UITableViewCell){
    textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16).isActive = true
    textField.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
    textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16).isActive = true
    textField.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
  }

}
