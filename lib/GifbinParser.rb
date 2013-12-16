class GifbinParser
  def random
    doc = Nokogiri::HTML http_get Settings.gifbin_url
    doc.xpath('//div[@id = "main"]/div/a/img[@id = "gif"]').map{ |n| n.attributes["src"].value }.first
  end

  private

  def http_get(url, params = {})
    http = HTTPClient.new agent_name: Settings.http_client.agent_name, follow_redirect: false
    response = http.get url, params
    response.ok? ? response.body : false
  end
end
