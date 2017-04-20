load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Po < Test::Unit::TestCase 
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
  def test_create_purchaseorder
    login
    sleep 20
    vendor_Name = create_vendor
    sleep 15
    product_name = create_product
    sleep 15
    @driver.find_element(:xpath, "//i[@class= 'fa fa-plus-circle']").click
    sleep 2
    @driver.find_element(:xpath, "html/body/header/div/div[2]/div[2]/ul/li[6]/a").click
    sleep 3
    time = get_Present
    po_Name = "po for "+vendor_Name+" "+time
    @driver.find_element(:xpath, "//input[@placeholder='Title']").send_keys po_Name
    @driver.find_element(:xpath, "//textarea[@placeholder='About this PO']").send_keys "This purchase order is created through Selenium Automation"
    
    tax = "//select[@name='salesTaxId']"
    tax_index = "2"
    getSelect_by_index(tax,tax_index)
    sleep 5
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div/div[2]/form/div[2]/div/section[3]/div/div[1]/vox-dynamic-select/div/div").click
    sleep 2
    @driver.find_element(:xpath, "//input[@placeholder='Select vendor...']").send_keys vendor_Name
    @driver.find_element(:xpath, "//*[@id='ui-select-choices-row-0-0']/a/span/div/span").click
    sleep 2
    puts "vendor selected in PO page"
    @driver.find_element(:xpath, "//button[@class='submit-button button']").send_keys :enter 
    sleep 3
    puts "Created "+po_Name
    sleep 5
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div/div/div[2]/div[2]/div[1]/div/a").click
    sleep 3
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/section[1]/div/div[3]/vox-dynamic-select/div/div").click
    sleep 2
    @driver.find_element(:xpath, "//input[@placeholder='Search for Product...']").send_keys product_name
    sleep 2
    @driver.find_element(:xpath, "//div[@class='ui-select-choices-row ng-scope active']/a/span/div").click
    sleep 2
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[3]/submit-button/button").click
    puts "created line item"
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
