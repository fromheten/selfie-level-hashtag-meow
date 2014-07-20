class PetChoosingController < UIViewController
  # In this veiw/controller you get a list (UITableView) of cats. When chosing one, that cat's image is sent to the a CameraController

  def viewDidLoad
    super
    self.title = "Cat Chooooooser"
    self.view.backgroundColor = UIColor.whiteColor

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.dataSource = self
    @table.delegate = self
    @table.rowHeight = 100
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
    image_nsdata = NSData.dataWithContentsOfFile(File.join(NSBundle.mainBundle.resourcePath, "cats/#{pet[:image]}"))
    image_object = UIImage.imageWithData(image_nsdata)
    cell.imageView.image = image_object
    puts cell.imageView.image

    cell
  end
  def tableView(tableView, numberOfRowsInSection: indexPath)
    # This method tells the table how many rows to make
    pets.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    # Instantiate a camera controller
    # camera_controller = CameraController.alloc.initWithNibName(nil, bundle: nil)
    camera_controller = CameraController.alloc.initWithForegroundImage(nil, bundle: nil)
    self.navigationController.pushViewController(camera_controller, animated: true)
  end

  def pets
    # This method gets a list of all the pets the user is allowed to use
    # For now it will be hardcoded
    pet_list = [
      {name: "Oscar F. Wild", image: "oscar_wild.png"},
      {name: "Fat the Cat", image: "benedict-the-fat.png"},
      {name: "ET - Extra Terrestrial", image: "et.png"},
      {name: "Karl Catastrophy", image: "karl-catastrophy.png"},
    ]
    return pet_list
  end
end
