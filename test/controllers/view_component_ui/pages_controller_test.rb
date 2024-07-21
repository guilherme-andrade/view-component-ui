require "test_helper"

module ViewComponentUI
  class PagesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get home" do
      get pages_home_url
      assert_response :success
    end
  end
end
