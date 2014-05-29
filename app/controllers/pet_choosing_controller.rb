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
    # This method tells the table how many rows to make
    pets.count
  end

  def pets
    # This method gets a list of all the pets the user is allowed to use
    # For now it will be hardcoded
    pussycats = [
      {name: "Oscar F. Wild", filename: "oscar_wild.png"},
      {name: "Fat the Cat", filename: "benedict-the-fat.png"}
      # Name idea: Carl Catastrophy
    ]
    return pussycats
  end

  def pet_image(pet_index)
    #get the filename of pets[pet_index]
    kitten_directory = NSBundle.resourcePath + "cats" #string
    pet = pets[pet_index]
    pet_image_filename = "#{kitten_directory}/#{pet[:filename]}"
    puts pet_image_filename

    #Make UIImage from that file
    pet_image = UIImage.alloc.initWithContentsOfFile(pet_image_filename)

    pet_image
  end
end
