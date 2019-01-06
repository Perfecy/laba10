
class XmlController < ApplicationController
    before_action :parse_params, only: :index
    def index
        array = params[:param]
	  	arr = array.split(' ')
	  	@inp = array
	  	arr.map!{|x| x.to_i}
	  	@result=func(arr)
        respond_to do |format|
            format.xml { render xml: @result.map { |elem| {elem: elem } }.to_xml }
            format.rss { render xml: @result.map { |elem| {elem: elem } }.to_xml }
        end
    end
    protected
    def parse_params
        @param = params[:param]
    end
private
def func(a)
  resarr = []
  s = 0
  sm = []
  d = a[0]
  k = 1
  a.each_index do |i|
    if (i != 0) && (a[i] > d) && (i != (a.length - 1))
      sm.push(a[i])
      s += 1
    elsif (i == 0) && (a[1] > a[0])
      sm.push(a[i])
      s += 1
    elsif (a[i] <= d) && (s > 0)
      resarr.push.push(sm)
      sm = [a[i]]
      s = 0
    elsif (i == (a.length - 1)) && (a[i] > d)
      sm.push(a[i])
      resarr.push.push(sm)
    end
    d = a[i]
  end

  resarr = resarr.sort { |a, b| b.length <=> a.length }

resarr
end
end
