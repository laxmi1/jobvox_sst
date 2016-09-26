load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Vendor < Test::Unit::TestCase 
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
  def test_create_vendor
    login
    @driver.find_element(:xpath, ".//*[@name ='suitcase']").click
    @driver.find_element(:xpath, "//a[@ui-sref='vendors']").click
    @driver.find_element(:xpath, "//button[@tooltip='Actions']").click
    @driver.find_element(:link_text, "New vendor").click
    time = get_Present
    vendor_Name = "Test vendor "+ time
    @driver.find_element(:xpath, "//input[@placeholder='Name']").send_keys vendor_Name
    @driver.find_element(:xpath, "//input[@placeholder='Legal name']").send_keys "Abhi"

    terms = "//select[@name='termCodeId']"
    terms_option = "due 10"
    getSelect(terms,terms_option) 

    tax = "//select[@name='salesTaxId']"
    tax_option = "Exempt"
    getSelect(tax,tax_option)

    # @driver.find_element(:xpath, "//input[@placeholder='jsmith@acme.com']").send_keys "abhinav@ahsgjashdkjf.com"
    # @driver.find_element(:xpath, "//input[@placeholder='(55) 5555-5555']").send_keys "9848032919"

    @driver.find_element(:xpath, "//button[@class='submit-button button']").click
     
     puts "created vendor with name: "+vendor_Name
    
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
