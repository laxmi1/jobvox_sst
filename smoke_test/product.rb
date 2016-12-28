load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Product < Test::Unit::TestCase 
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
  def test_create_product
    login
    sleep 5
    @driver.find_element(:xpath, "//div[@class='account-name dropdown']").click
    @driver.find_element(:xpath, "//li[@ng-if='currentAccount.featureFlags.orderManagementEnabled && currentAccount.policies.posSettingShow']").click
    @driver.find_element(:xpath, "//i[@class='fa fa-dollar']").click
    @driver.find_element(:xpath, "//a[@ui-sref='products']").click
    sleep 2
    @driver.find_element(:link_text, "New Product").click
    
    time = get_Present
    product_name = "Product "+time
    @driver.find_element(:xpath, "//input[@name='product[name]']").send_keys product_name 
    begin
    @driver.find_element(:xpath, "//textarea[@name='product[description]']").send_keys "Test description"        
    puts "description available"
    sleep 2
    rescue => e
    puts "description not available"       
    end
    type = "//select[@name='product[product_type_id]']"
    type_index = "3"
    getSelect_by_index(type,type_index)
    sleep 2
    category = "//select[@name='product[category_id]']"
    category_index = "2"
    getSelect_by_index(category,category_index)
    
    @driver.find_element(:xpath, "//input[@name='product[buying_cost_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='product[buying_cost_in_dollars]']").send_keys "20"
    sleep 2
    @driver.find_element(:xpath, "//input[@name='product[cost_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='product[cost_in_dollars]']").send_keys "30"

    sleep 2
    @driver.find_element(:xpath, "//input[@name='product[price_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='product[price_in_dollars]']").send_keys "40"
    
    incomeaccount = "//select[@name='product[income_coa_account_id]']"
    incomeaccount_index = "2"
    getSelect_by_index(incomeaccount,incomeaccount_index)

    cogaccount = "//select[@name='product[cog_coa_account_id]']"
    cogaccount_index = "2"
    getSelect_by_index(cogaccount,cogaccount_index)
    
    @driver.find_element(:xpath, "//input[@class='button']").click
    sleep 5
     puts "Created "+product_name
      
       
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
