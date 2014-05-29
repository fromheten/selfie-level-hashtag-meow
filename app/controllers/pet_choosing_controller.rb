class PetChoosingController < UIViewController
  # In this veiw/controller you get a list (UITableView) of cats. When chosing one, that cat's image is sent to the a CameraController

  def viewDidLoad
    super
    self.title = "Cat Chooooooser"
    self.view.backgroundColor = UIColor.whiteColor

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.dataSource = self
    self.view.addSubview(@table)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    puts "indexPath.row: #{indexPath.row} is #{pets[indexPath.row]}. かわいい！"

    pet = pets[indexPath.row]
    cell.textLabel.text = pet[:name]

    cell
  end
  def tableView(tableView, numberOfRowsInSection: indexPath)
    #How many rows? should be pets.length
    puts "#{indexPath}: #{pets.length}"

    pets.count
  end

  def pets
    # This method gets a list of all the pets the user is allowed to use
    # For now it will be hardcoded
    pussycats = [
      {name: "Oscar F. Wild", filename: "oscar_wild.png"},
      {name: "Benedict the Fat", filename: "benedict-the-fat.png"}
    ]
    return pussycats
  end

  def pet_image(pet_index)
    kitten_directory = NSBundle.resourcePath + "cats/"
    puts kitten_directory
  end
end
