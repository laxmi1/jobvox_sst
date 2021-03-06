load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Quote < Test::Unit::TestCase 
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
  def test_create_quote
    login
    sleep 15
    customer_Name = create_customer
    sleep 5
    product_name = create_product
    sleep 15
    @driver.find_element(:xpath, "//i[@class= 'fa fa-plus-circle']").click
    sleep 2
    @driver.find_element(:xpath, "html/body/header/div/div[2]/div[2]/ul/li[2]/a").click
    sleep 5
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div/div[2]/form/div[2]/div/section[1]/div/div[1]/vox-dynamic-select/div/div/div").click
    sleep 5
    @driver.find_element(:xpath, "//input[@placeholder='Select customer...']").send_keys customer_Name
    sleep 5
    @driver.find_element(:xpath, "//a[@class='ui-select-choices-row-inner']/span/div/span").click
    puts "customer selected in Quote page"
    begin
    time = get_Present
    quote_Name = "Quote for "+customer_Name+" "+time
    @driver.find_element(:xpath, "//input[@placeholder='Title']").send_keys quote_Name
    @driver.find_element(:xpath, "//textarea[@placeholder='About this quote']").send_keys "This quote is created through Selenium Automation"
    
    primarySalesRep = "//select[@name='primarySalesRepId']"
    primarySalesRep_index = "1"
    getSelect_by_index(primarySalesRep,primarySalesRep_index)

    productionManager = "//select[@name='productionManagerId']"
    productionManager_index = "2"
    getSelect_by_index(productionManager,productionManager_index)

    project_manager = "//select[@name='projectManagerId']"
    project_manager_index = "3"
    getSelect_by_index(project_manager,project_manager_index)

    estimator = "//select[@name='estimatorId']"
    estimator_index = "1"
    getSelect_by_index(estimator,estimator_index)

    @driver.find_element(:xpath , "//textarea[@placeholder='Customer Note']").send_keys "Customer Note"
    puts "Available"
    sleep 5
    rescue => e
    puts "Not Available"  
    end
    @driver.find_element(:xpath, "//*[@id='main-section']/div/div/div[2]/form/div[3]/div/submit-button/button").send_keys :enter 
    sleep 5
    puts "Created "+quote_Name
    puts "Adding Line item With"+product_name
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div/div/div[2]/div[2]/div/div[1]/div[2]/a").click
    sleep 5
    @driver.find_element(:xpath, "//input[@placeholder='Search for product...']").send_keys product_name
    sleep 2
    @driver.find_element(:xpath, "//div[@class='ui-select-choices-row ng-scope active']/a/span/div").click
    sleep 2
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[4]/a[2]").click
    puts "Created line item"
    sleep 5
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div/div/div[1]/div/div[2]/div[2]/button").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div/div/div[1]/div/div[2]/div[2]/ul/li[2]/a").click
    sleep 5
    begin
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div/div/div[2]/form/div[1]/div/section[1]/div/div[3]/date-picker/div/div/div/span/i").click
    sleep 2
    @driver.find_element(:xpath, "//div[@class='picker__footer']/button[1]").click
    puts "Available"
    sleep 5
    rescue => e
    puts "Not Available"
    sleep 5
    end
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div/div/div[2]/form/div[3]/div/submit-button/button").send_keys :enter
    puts "Created SO from QT"
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
