load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Quote < Test::Unit::TestCase 
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
    sleep 2
    product_Name = create_product
    sleep 5
    @driver.find_element(:xpath, "//div[@class='create-shortcut dropdown ng-scope']/a").click
    @driver.find_element(:link_text, "New Quote").click
    sleep 5
    @driver.find_element(:xpath, "//div[@class='ui-select-container ui-select-bootstrap dropdown ng-valid']").click
    sleep 2
    @driver.find_element(:xpath, "//input[@placeholder='Select customer...']").send_keys customer_Name
    @driver.find_element(:xpath, "//a[@class='ui-select-choices-row-inner']/div").click
    puts "customer selected in Quote page"
    begin
    time = get_Present
    quote_Name = "Quote for "+customer_Name+" "+time
    @driver.find_element(:xpath, "//input[@placeholder='Title']").send_keys quote_Name
    @driver.find_element(:xpath, "//textarea[@placeholder='About this quote']").send_keys "This quote is created through Selenium Automation"
    
    primarySalesRep = "//select[@name='primarySalesRepId']"
    primarySalesRep_index = "1"
    getSelect_by_index(primarySalesRep,primarySalesRep_index)

    productionManager = "//select[@name='productionManagerId']"
    productionManager_index = "2"
    getSelect_by_index(productionManager,productionManager_index)

    project_manager = "//select[@name='projectManagerId']"
    project_manager_index = "3"
    getSelect_by_index(project_manager,project_manager_index)

    estimator = "//select[@name='estimatorId']"
    estimator_index = "1"
    getSelect_by_index(estimator,estimator_index)

    @driver.find_element(:xpath , "//textarea[@placeholder='Customer Note']").send_keys "Customer Note"
    puts "Available"
    sleep 5
    rescue => e
    puts "Not Available"  
    end
    @driver.find_element(:xpath, "//button[@class='submit-button button']").send_keys :enter 

    puts "Created "+quote_Name
    #Add a line item for Quote
def add_line_item(name=nil)
      
      getElement_xpath(".//*[@id='main-section']/div/div[2]/div/div/div/div/div[2]/div[2]/div/div[1]/div[2]/a").click

      sleep(6)

      getElement_xpath(".//*[@id='sc8j']/input[1]").click

      product_name = Keys_CONFIG[".//*[@id='sc8j']/input[1]"]
      if(name!=nil)
        product_name = Keys_CONFIG[".//*[@id='sc8j']/input[1]"]+name
      end

      getElement_placeholder("//input[@placeholder='").send_keys product_name

      sleep(6)

      getElement_xpath("//a[@class='ui-select-choices-row-inner']/div/span").click

      sleep(6)

      getElement_xpath("html/body/div[1]/div/div/form/div[4]/button").click

      sleep(6)
   end

   #This Quote conver to Sales order
   getElement_xpath(".//*[@id='main-section']/div/div[2]/div/div/div/div/div[1]/div/div[2]/div[2]/button").click

      getElement_text(".//*[@id='main-section']/div/div[2]/div/div/div/div/div[1]/div/div[2]/div[2]/ul/li[2]/a").click

      getElement_xpath(".//*[@id='main-section']/div/div[2]/div/div/div/div/div[2]/form/div[3]/div/submit-button/button").click

      getElement_xpath("//div[@class='modal-footer ng-scope']/button[2]").click

      sleep(6)

      order_name = getElement_xpath(".//*[@id='0s3a']/div/span").text

      check = compare(quote_name,order_name)

      if(check)
        puts "Quote not Converted to Order."
      else
        puts "Quote Converted to Order"
      end
      sleep(6)

  
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
