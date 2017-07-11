load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Customer < Test::Unit::TestCase 
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
  def test_create_customer
    login
    sleep 15
    # @driver.find_element(:link_text, "Customers & Vendors").click
    @driver.find_element(:xpath, ".//*[@id='main-nav']/li[4]/a/span").click
    @driver.find_element(:xpath, "//a[@ui-sref='companies']").click
    sleep 5
    @driver.find_element(:xpath, "//button[@uib-tooltip='Actions']").send_keys :enter

    @driver.find_element(:link_text, "New customer").click

    time = get_Present
    customer_Name = "Customer "+time
    @driver.find_element(:xpath, "//input[@placeholder='Name']").send_keys customer_Name
    begin
      @driver.find_element(:xpath, "//input[@placeholder='Legal Name']").send_keys "Legal Name"
      puts "Legal name available"
    rescue => e
      puts "Legal name not available"
    end 
    

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
