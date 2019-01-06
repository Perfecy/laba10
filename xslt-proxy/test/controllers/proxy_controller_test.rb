require 'test_helper'

class ProxyControllerTest < ActionDispatch::IntegrationTest

  test "should get input" do
    get proxy_input_url
    assert_response :success
  end

  test "should get output" do
    get proxy_output_url
    assert_response :success
  end
 test  'check html  format' do
    get proxy_output_url, params: {side:'server', n: '1 2 3 3 4 5 6 7 8 1 2 3 3 3 3 34 35 72 96 15 35 46 73'}
    res1 = response.parsed_body
    get proxy_output_url, params:{side: 'client-with-xslt', n: '1 2 3 3 4 5 6 7 8 1 2 3 3 3 3 34 35 72 96 15 35 46 73'}
    res2 = response.parsed_body
    assert_not_equal res1, res2
  end
  test 'test_3' do
    get proxy_output_url, params: {side:'server', n: '1 2 3 3 4 5 6 7 8 1 2 3 3 3 3 34 35 72 96 15 35 46 73'}
    assert_equal assigns[:result], [[3,4,5,6,7,8], [3,34,35,72,96], [15,35,46,73], [1,2,3], [1,2,3]]
  end
  test 'test_4' do
    get proxy_output_url, params: {side:'client-with-xslt', n: '1 2 3 3 4 5 6 7 8 1 2 3 3 3 3 34 35 72 96 15 35 46 73'}
    assert_equal assigns[:result], [[3,4,5,6,7,8], [3,34,35,72,96], [15,35,46,73], [1,2,3], [1,2,3]]
  end
  test 'test_5' do
    get proxy_output_url, params: {side:'server', n: '110 100 90 80 70 60 50 40 30 20 10 9 8 7 6 5 4 3 2 1'}
    assert_equal assigns[:result][0], "Последовательностей не найдено!"
  end
  test 'test_6' do
    get proxy_output_url, params: {side:'client-with-xslt', n: '110 100 90 80 70 60 50 40 30 20 10 9 8 7 6 5 4 3 2 1'}
    assert_equal assigns[:result][0], "Последовательностей не найдено!"
  end
  test "check rss" do
    @data = '123 34 5 5 5 25 125 625 25 25 25'
    answer = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<objects type=\"array\">\n  <object>\n    <elem type=\"integer\">5</elem>\n    <sqr type=\"integer\">5</sqr>\n  </object>\n  <object>\n    <elem type=\"integer\">5</elem>\n    <sqr type=\"integer\">25</sqr>\n  </object>\n  <object>\n    <elem type=\"integer\">125</elem>\n    <sqr type=\"integer\">625</sqr>\n  </object>\n  <object>\n    <elem type=\"integer\">25</elem>\n    <sqr type=\"integer\">25</sqr>\n  </object>\n  <object>\n    <elem type=\"integer\">25</elem>\n    <sqr type=\"integer\">5</sqr>\n  </object>\n  <object>\n    <elem type=\"integer\">26</elem>\n    <sqr type=\"integer\">676</sqr>\n  </object>\n</objects>\n"
    BASE_API_URL = 'http://localhost:3000/?format=rss'
    @url = BASE_API_URL + "&param=#{@data}"
    resp = ''
    open(@url) {|f|
      f.each_line {|line| resp += line}
    }
    p resp
    assert_equal resp.to_s, answer.to_s
  end
end
