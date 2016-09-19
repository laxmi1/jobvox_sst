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
  def test_create_quote
    login
    customer_Name = create_customer
    sleep 5
    @driver.find_element(:xpath, "//div[@class='create-shortcut dropdown ng-scope']/a").click
    @driver.find_element(:link_text, "New Quote").click
    sleep 5
    @driver.find_element(:xpath, "//div[@class='ui-select-container ui-select-bootstrap dropdown ng-valid']").click
    sleep 2
    @driver.find_element(:xpath, "//input[@placeholder='Select customer...']").send_keys customer_Name
    @driver.find_element(:xpath, "//a[@class='ui-select-choices-row-inner']/div").click
    puts "customer selected in Quote page"

    sleep 5

    

    # time = get_Present
    # customer_Name = "Customer "+time
    # @driver.find_element(:xpath, "//input[@placeholder='Select customer...']").send_keys customer_Name
    # @driver.find_element(:xpath, "//input[@placeholder='Legal Name']").send_keys "Legal Name"

  
    # industry  = "//select[@name='categoryId']"
    # industry_option = "Sign"
    # getSelect(industry,industry_option)

    # leadSource  = "//select[@name='leadSourceId']"
    # leadSource_option = "Call In"
    # getSelect(leadSource,leadSource_option)

    # @driver.find_element(:xpath, "//button[@class='submit-button button']").click

    # puts "created customer with name: "+customer_Name

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
