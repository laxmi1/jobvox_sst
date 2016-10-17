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
    sleep 10
    @driver.find_element(:xpath, "//i[@name ='suitcase']").click
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

    @driver.find_element(:xpath, "//button[@class='submit-button button']").click
     
     puts "created vendor with name: "+vendor_Name

    sleep 5

    @driver.find_element(:xpath, "//a[@class='sidebar-toggle sidebar-toggle--dark left']").click
    @driver.find_element(:xpath, "//button[@class='button dropdown-toggle']").click

    @driver.find_element(:link_text, "Purchase order").click
    sleep 5
    time = get_Present
    po_Name = "po for "+vendor_Name+" "+time
    @driver.find_element(:xpath, "//input[@placeholder='Title']").send_keys po_Name
    @driver.find_element(:xpath, "//textarea[@placeholder='About this PO']").send_keys "This purchase order is created through Selenium Automation"
    
    tax = "//select[@name='salesTaxId']"
    tax_index = "2"
    getSelect_by_index(tax,tax_index)

    @driver.find_element(:xpath, "//button[@class='submit-button button']").send_keys :enter 

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
