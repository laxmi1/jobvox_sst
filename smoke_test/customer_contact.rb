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
    sleep 10
    customer_Name = create_customer
    sleep 5
    @driver.find_element(:xpath, "//i[@class= 'fa fa-plus-circle']").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-header']/div/div[2]/div[2]/ul/li[13]/a").click
    sleep 2
    time = get_Present
    contact_Name = "Contact "+time
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div[2]/div/form/div[1]/div/section[1]/div/div[1]/vox-text-field/div/div/input").send_keys contact_Name
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div[2]/div/form/div[1]/div/section[1]/div/div[2]/vox-dynamic-select/div/div").click
    sleep 4
    @driver.find_element(:xpath, "//input[@placeholder='Select customer...']").send_keys customer_Name
    sleep 2
    @driver.find_element(:xpath, "//a[@class='ui-select-choices-row-inner']/span/div/span").click
    puts "customer selected in invoice page"
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div[2]/div/form/div[1]/div/section[5]/div/div[1]/vox-text-field/div/div/input").send_keys "abhinav@techvoxinc.com"
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div[2]/div/div/div[2]/div/form/div[2]/div/submit-button/button").send_keys :enter
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
