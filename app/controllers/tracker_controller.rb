require 'open-uri'
require 'nokogiri'

class TrackerController < ApplicationController
  def index

  end

  def track
    ids = params['ids'].split(',').map(&:strip)
    @result = ids.each_with_object({}){|id,h| h[id] = check_status(id)}
  end

  def check_status(id)
    begin
      is_delivered(load_html("http://www.israelpost.co.il/itemtrace.nsf/mainsearch?OpenForm&Seq=1&L=EN&itemcode=#{id}"))
    rescue Exception => e
      e.message
    end
  end

  def load_html(path)
    args = {
        'User-Agent' => 'viki',
        'Referer' => 'http://www.vikirozental.com/', }
    open(path, args) {|f| Nokogiri::HTML(f) }
  end

  def is_delivered(html)
    info = html.xpath("//div[@id='itemcodeinfo']//text()")
    !info.map(&:to_s).join(' ').include?('No information is available for the item')
  end
end
