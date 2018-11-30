require 'test_helper'

class PostshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get postships_create_url
    assert_response :success
  end

  test "should get destory" do
    get postships_destory_url
    assert_response :success
  end

end
