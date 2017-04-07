require 'withings_api/version'

require 'net/https'
require 'open-uri'
require 'simple_oauth'
require 'tempfile'

# Withings API Ruby thin client wrapper library
# {https://github.com/niwasawa/withings-api-ruby-thin-client-wrapper}
module WithingsAPI

  # A base client class.
  class BaseClient

    # Initializes a BaseClient object.
    #
    # @param credentials [Hash] Credentials
    # @return [WithingsAPI::BaseClient]
    def initialize(credentials)
      @credentials = credentials
    end

    # Calls a Withings API using GET method.
    #
    # @param resource_url [String] Resource URL
    # @param params [Hash] Parameters
    # @return [WithingsAPI::Response]
    def get(resource_url, params)
      p = authenticated('GET', resource_url, params)
      url = resource_url + '?' + URI.encode_www_form(p)
      res = open(url)
      Response.new(res)
    end

    private

    # Returns authenticated parameters.
    #
    # @param method [String] A HTTP method
    # @param url [String] A URL
    # @param params [Hash] Parameters
    # @return [Array]
    def authenticated(method, url, params)
      auth = SimpleOAuth::Header.new(method, url, params, @credentials)
      h = auth.signed_attributes.merge(params)
      h.sort_by{|k,v|k.to_s}
    end

  end

  # A client class.
  class Client < BaseClient

    # Initializes a Client object.
    #
    # @param credentials [Hash] Credentials
    # @return [WithingsAPI::Client]
    def initialize(credentials)
      super
    end

    # Measure - Get Activity Measures
    # {https://oauth.withings.com/api/doc#api-Measure-get_activity}
    #
    # @param params [Hash] Parameters
    # @return [WithingsAPI::Response]
    def get_activity_measures(params)
      resource_url = 'https://wbsapi.withings.net/v2/measure'
      h = {'action' => 'getactivity'}
      get(resource_url, params.merge(h))
    end

    # Measure - Get Body Measures
    # {https://oauth.withings.com/api/doc#api-Measure-get_measure}
    #
    # @param params [Hash] Parameters
    # @return [WithingsAPI::Response]
    def get_body_measures(params)
      resource_url = 'https://wbsapi.withings.net/measure'
      h = {'action' => 'getmeas'}
      get(resource_url, params.merge(h))
    end

    # Measure - Get Intraday Activity
    # {https://oauth.withings.com/api/doc#api-Measure-get_intraday_measure}
    #
    # @param params [Hash] Parameters
    # @return [WithingsAPI::Response]
    def get_intraday_activity(params)
      resource_url = 'https://wbsapi.withings.net/v2/measure'
      h = {'action' => 'getintradayactivity'}
      get(resource_url, params.merge(h))
    end

    # Measure - Get Sleep Measures
    # {https://oauth.withings.com/api/doc#api-Measure-get_sleep}
    #
    # @param params [Hash] Parameters
    # @return [WithingsAPI::Response]
    def get_sleep_measures(params)
      resource_url = 'https://wbsapi.withings.net/v2/sleep'
      h = {'action' => 'get'}
      get(resource_url, params.merge(h))
    end

    # Measure - Get Sleep Summary
    # {https://oauth.withings.com/api/doc#api-Measure-get_sleep_summary}
    #
    # @param params [Hash] Parameters
    # @return [WithingsAPI::Response]
    def get_sleep_summary(params)
      resource_url = 'https://wbsapi.withings.net/v2/sleep'
      h = {'action' => 'getsummary'}
      get(resource_url, params.merge(h))
    end

    # Measure - Get Workouts
    # {https://oauth.withings.com/api/doc#api-Measure-get_workouts}
    #
    # @param params [Hash] Parameters
    # @return [WithingsAPI::Response]
    def get_workouts(params)
      resource_url = 'https://wbsapi.withings.net/v2/measure'
      h = {'action' => 'getworkouts'}
      get(resource_url, params.merge(h))
    end

  end

  # A HTTP Response class.
  class Response

    # Initializes a Response object.
    #
    # @param res [Net::HTTPResponse]
    # @param res [StringIO]
    # @param res [Tempfile]
    # @return [WithingsAPI::Response]
    def initialize(res)
      @res = res
      @headers = make_headers
      @body = make_body
    end

    # Returns HTTP headers.
    #
    # @return [Net::HTTPHeader]
    # @return [Hash]
    def headers
      @headers
    end

    # Returns HTTP body.
    #
    # @return [String]
    def body
      @body
    end

    private

    # Returns HTTP headers.
    #
    # @return [Net::HTTPHeader]
    # @return [Hash]
    def make_headers
      if @res.kind_of?(Net::HTTPResponse)
        @res # Net::HTTPHeader
      elsif @res.kind_of?(StringIO)
        @res.meta # Hash
      elsif @res.kind_of?(Tempfile)
        @res.meta # Hash
      else
        nil
      end
    end

    # Returns HTTP body.
    #
    # @return [String]
    def make_body
      if @res.kind_of?(Net::HTTPResponse)
        @res.body
      elsif @res.kind_of?(StringIO)
        @res.read
      elsif @res.kind_of?(Tempfile)
        @res.read
      else
        nil
      end
    end
  end

end

