require File.expand_path(File.dirname(__FILE__)+'/../test_helper')
require 'dm-core'
require 'dm-sweatshop'
require 'webrat'

class SignupTest < ActionController::TestCase
  include Webrat::Matchers
  def setup
    @sso_server = 'http://hancock.atmos.org/sso'
    @browser = Watir::Safari.new
    @browser.goto("http://localhost:3000/sso/logout")
  end
  def response_body
    @browser.html
  end
  begin
    require 'safariwatir'
    test "signing up with safari" do
      # session cookie fails on localhost :\
      # sso_server = 'http://localhost:20000/sso'
      email = /\w+@\w+\.\w{2,3}/.gen.downcase
      first_name, last_name = /\w+/.gen.capitalize, /\w+/.gen.capitalize

      # make a request and signup to access the site
      @browser.goto('http://localhost:3000/')
      @browser.link(:url, "#{@sso_server}/signup").click
      @browser.text_field(:name, :first_name).set(first_name)
      @browser.text_field(:name, :last_name).set(last_name)
      @browser.text_field(:name, :email).set(email)
      @browser.button(:value, 'Signup').click

      # hacky way to strip this outta the markup in development mode
      register_url = @browser.html.match(%r!#{@sso_server}/register/\w{40}!).to_s
      assert_not_equal '', register_url
      password = /\w+{9,32}/.gen

      # register from the url from their email
      @browser.goto(register_url)
      @browser.text_field(:name, :password).set(password)
      @browser.text_field(:name, :password_confirmation).set(password)
      @browser.button(:value, 'Am I Done Yet?').click

      sleep 1

      # sent back to be greeted on the consumer
      assert_have_selector "h1:contains('Hancock Client: Rails')"
      assert_have_selector "td:contains('#{email}')"
      assert_have_selector "td:contains('#{first_name}')"
      assert_have_selector "td:contains('#{last_name}')"
    end
  rescue; end
end
