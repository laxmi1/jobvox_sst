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
  def test_create_mr
    login
    sleep 15
    vendor_Name = create_vendor
    @driver.find_element(:xpath, "//div[@class='create-shortcut dropdown ng-scope']/a").click
    @driver.find_element(:link_text, "New Material Receipt").click
    sleep 3
    time = get_Present
    mr_Name = "Material Receipt for "+vendor_Name+" "+time
    @driver.find_element(:xpath, "//input[@placeholder='Title']").send_keys mr_Name
    @driver.find_element(:xpath, "//textarea[@placeholder='About this MR']").send_keys "This material Receipt is created through Selenium Automation"
    
    @driver.find_element(:xpath, ".//*[@id='main-section']/div/div/div[2]/form/div[1]/div/section[3]/div/div[1]/vox-dynamic-select/div/div").click
    sleep 2
     @driver.find_element(:xpath, "//input[@placeholder='Select vendor...']").send_keys vendor_Name
    @driver.find_element(:xpath, "//a[@class='ui-select-choices-row-inner']/span/div/span").click
    puts "vendor selected in MR page"

    @driver.find_element(:xpath, "//button[@class='submit-button button']").send_keys :enter 
    sleep 3

    puts "Created "+mr_Name

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
