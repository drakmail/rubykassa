module Rubykassa
  class Configuration
    attr_accessor :login, :first_password, :second_password, :mode, :http_method

    def initialize
      self.login = "your_login"
      self.first_password = "first_password"
      self.second_password = "second_password"
      self.mode = :test
      self.http_method = :get
    end
  end
end