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
    sleep 10    
    @driver.find_element(:xpath, "//i[@name='plus-circle']").click
    @driver.find_element(:link_text, "New Purchase Order").click
    sleep 3
    time = get_Present
    po_Name = "po for "+vendor_Name+" "+time
    @driver.find_element(:xpath, "//input[@placeholder='Title']").send_keys po_Name
    @driver.find_element(:xpath, "//textarea[@placeholder='About this PO']").send_keys "This purchase order is created through Selenium Automation"
    
    tax = "//select[@name='salesTaxId']"
    tax_index = "2"
    getSelect_by_index(tax,tax_index)
    sleep 5
    @driver.find_element(:xpath, "//*[@id='xykl']/div/span/span[1]").click
    sleep 5
    @driver.find_element(:xpath, "//input[@placeholder='Select vendor...']").send_keys vendor_Name
    sleep 5
    @driver.find_element(:xpath, "//*[@id='ui-select-choices-row-0-0']/a/span/div/span").click

    puts "vendor selected in PO page"

    @driver.find_element(:xpath, "//*[@id='main-section']/div/div/div[2]/form/div[3]/div/submit-button/button").send_keys :enter 
    sleep 3

    puts "Created "+po_Name

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
