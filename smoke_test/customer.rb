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
    @driver.find_element(:xpath, "//span[@class='ng-binding']".click
    #@driver.find_element(:xpath, "//i[@name ='suitcase']").click
    sleep 10
    @driver.find_element(:link_text, "companies").click
    sleep 10
    @driver.find_element(:xpath, "//button[@uib-tooltip='Actions']").send_keys :enter

    @driver.find_element(:link_text, "New customer").click

    time = get_Present
    customer_Name = "Customer "+time
    @driver.find_element(:xpath, "//input[@placeholder='Name']").send_keys customer_Name
    begin
      @driver.find_element(:xpath, "//input[@placeholder='Legal Name']").send_keys "Legal Name"
      puts "Legal name available"
      sleep 5
    rescue => e
      puts "Legal name not available"
    end

    begin
      contact_Name = "Contact "+time
    @driver.find_element(:xpath, "//div[1][@class='col-sm-6']/vox-text-field/div/div/input").send_keys contact_Name
    @driver.find_element(:xpath, "//div[2][@class='col-sm-6']/vox-text-field/div/div/input").send_keys "laxmi@techvoxinc.com"
           puts "Contact available"
           sleep 5
       rescue => e
           puts "Contact is not available"
end
    
    # @driver.find_element(:xpath, "//div[1][@class='col-sm-9 ng-scope']/phone-field/div/div").send_keys "9848071234"
    industry  = "//select[@name='categoryId']"
    industry_index = "1"
    getSelect_by_index(industry,industry_index)


    leadSource  = "//select[@name='leadSourceId']"
    leadSource_index = "1"
    getSelect_by_index(leadSource,leadSource_index)

    @driver.find_element(:xpath, "//button[@class='submit-button button']").click
    sleep 5
    puts "created customer with name: "+customer_Name

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
