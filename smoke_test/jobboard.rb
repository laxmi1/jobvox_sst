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
  def test_create_jobboard
    login
    sleep 20
    @driver.find_element(:xpath, ".//*[@id='main-nav']/li[2]/a").click
    sleep 5    
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/a[1]").click
    sleep 4
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/a[2]").click
    sleep 4
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/a[3]/i").click
    sleep 4
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/div/a/i").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='page-header']/div/div[2]/div/ul/li[1]/a").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/div/a/i").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='page-header']/div/div[2]/div/ul/li[2]/a").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/div/a/i").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='page-header']/div/div[2]/div/ul/li[3]/a").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/div/a/i").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='page-header']/div/div[2]/div/ul/li[4]/a").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/a[4]").click
    sleep 4
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/a[3]").click
    sleep 6
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/header/div/div[2]/a[5]").click
    sleep 8
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
