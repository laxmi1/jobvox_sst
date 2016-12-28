load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Order < Test::Unit::TestCase 
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
  def test_create_job
    login
    sleep 10
    customer_Name = create_customer
    sleep 5
    @driver.find_element(:xpath, "//div[@class='create-shortcut dropdown ng-scope']/a").click
    @driver.find_element(:link_text, "New Job").click
    sleep 5
    @driver.find_element(:xpath, "//div[@class='ui-select-container ui-select-bootstrap dropdown ng-valid']").click
    sleep 2
    @driver.find_element(:xpath, "//input[@placeholder='Select customer...']").send_keys customer_Name
    sleep 2
    @driver.find_element(:xpath, "//a[@class='ui-select-choices-row-inner']/div").click
    puts "customer selected in job page"

    time = get_Present
    job_Name = "Job for "+customer_Name+" "+time
    @driver.find_element(:xpath, "//input[@placeholder='Name']").send_keys job_Name
    begin
      @driver.find_element(:xpath, "//textarea[@placeholder='Description']").send_keys "This job is created through Selenium Automation"
      puts "Description is available"
      sleep 5
    rescue => e
      puts "Description is not available"
    end
    
    @driver.find_element(:xpath, "//input[@placeholder='Quantity']").send_keys "2"
    sleep 2

    workflow = "//select[@name='jobTemplateId']"
    workflow_index = "2"
    getSelect_by_index(workflow,workflow_index)
    sleep 2
    begin
    salesRep = "//select[@name='salesRepId']"
    salesRep_index = "1"
    getSelect_by_index(salesRep,salesRep_index)
    sleep 2

    productionManager = "//select[@name='productionManagerId']"
    productionManager_index = "2"
    getSelect_by_index(productionManager,productionManager_index)

    project_manager = "//select[@name='projectManagerId']"
    project_manager_index = "3"
    getSelect_by_index(project_manager,project_manager_index) 
    puts "Details available"
    sleep 5
    rescue => e
      puts "not available"
    end

    @driver.find_element(:xpath, "//button[@class='submit-button button']").send_keys :enter 
    sleep 2
    puts "Created "+job_Name
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
