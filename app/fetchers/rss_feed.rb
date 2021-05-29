# frozen_string_literal: true

class RssFeed
  def initialize(source)
    @source = source
  end

  def create_pending_posts
    return false unless feed_object

    incoming_entries = feed_object.entries
    incoming_entries.each do |entry|
      PendingPost.create_from_feedjira(@source, entry)
    end
  end

  private

  def feed_object
    @feed_object ||= begin
      body = feed_net_request

      Feedjira.parse(body) if body.present? || Rails.env.test?
    rescue StandardError
      nil
    end
  end

  def feed_net_request
    response = make_request(@source.url)

    response.body
  rescue StandardError
    nil
  end

  def make_request(request_url, limit = 5)
    raise ArgumentError, "too many HTTP redirects" if limit <= 0

    uri = URI.parse(request_url)
    req = Net::HTTP::Get.new(uri.request_uri)
    req["Accept-Language"] = "*"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    http.open_timeout = 5
    http.read_timeout = 5
    response = http.start { http.request(req) }

    case response
    when Net::HTTPSuccess
      response
    when Net::HTTPRedirection
      location = response["location"]
      make_request(location, limit - 1)
    end
  end
end
