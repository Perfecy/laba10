require 'test_helper'

class XmlControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "check rss format" do
    get '/' , params: {n: '1 2 3 3 4 5 6 7 8 1 2 3 3 3 3 34 35 72 96 15 35 46 73',format: :rss}
    assert_response :success
  end
end
