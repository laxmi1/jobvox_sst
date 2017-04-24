load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Login < Test::Unit::TestCase 
  fixtures :users

# To open firefox browser and the application url
  def setup
    @driver = get_driver
    @accept_next_alert = true
    @verification_errors = [] 
  end
# Throws an assertion errors
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
# Test to login with valid credentials
  def test_create_task
    login
    sleep 20
    @driver.find_element(:xpath, ".//*[@id='main-nav']/li[9]/a/i").click
    sleep 5 
    @driver.find_element(:xpath, "//input[@ng-model='model.bindable']").click 
    sleep 2
    time = get_Present
    task_Name = "task for "+time
    @driver.find_element(:xpath, "//input[@placeholder='Type your task here...']").send_keys task_Name
    @driver.find_element(:xpath, "//div[@placeholder='Task description...']").send_keys "Test selenium description for task"
    sleep 2
    # Due date selection for task
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div/div[2]/vox-task-form/div/form/div[3]/div[1]/date-picker/div/div/div/span").click
    sleep 2
    @driver.find_element(:xpath, "//button[@class='picker__button--today']").click
    sleep 2
    assignto = "//select[@name='assignedToId']"
    assignto_index = "2"
    getSelect_by_index(assignto,assignto_index)
    sleep 2
    category = "//select[@name='taskTypeId']"
    category_index = "2"
    getSelect_by_index(category,category_index)
    sleep 2
    @driver.find_element(:xpath, "//button[@class='submit-button button']").send_keys :enter 
    sleep 2
    puts "Created "+task_Name
    sleep 5    
  end

  
# To find the element and throws an error if element is not found.
   def element_present?(how, what)
    @driver.find_element(how, what)
    true
      rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

# To see the alert is present and throws an error if no alert is present
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
# To verify expected and actual values
# If assertion failed it throws an error
  def verify(&blk)
    yield
    rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
# To close alerts
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
    ensure
    @accept_next_alert = true
  end
end
