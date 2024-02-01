# frozen_string_literal: true

module BattleNet
  class Client
    def initialize
      @client = Faraday.new(url: 'https://us.api.blizzard.com') do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
        faraday.headers['Authorization'] = "Bearer #{access_token}"
      end
    end

    def get(path, params = {})
      client.get(path, params.merge!(namespace: ) )
    end

    private

    attr_reader :client
    def access_token
      return Rails.cache.read('battle_net::access_token') if Rails.cache.read('battle_net::access_token')

      conn = Faraday.new(url: 'https://oauth.battle.net') do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end

      conn.set_basic_auth(Settings.battle_net.client, Settings.battle_net.secret)
      response = conn.post('/token', { grant_type: 'client_credentials' })
      access_token = JSON.parse(response.body)['access_token']
      expires_in = JSON.parse(response.body)['expires_in'].to_i
      Rails.cache.write('battle_net::access_token', access_token, expires_in: expires_in)
    end

    def namespace
      Settings.battle_net.namespace
    end
  end
end
