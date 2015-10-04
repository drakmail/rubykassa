# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Rubykassa::PaymentInterface do
  before(:each) do
    @payment_interface = Rubykassa::PaymentInterface.new do
      self.invoice_id = 12
      self.total = 1200.00
      self.params = { foo: "bar" }
    end

    Rubykassa.configure do |config|
    end
  end

  it "should return correct base_url" do
    @payment_interface.base_url.should == "https://auth.robokassa.ru/Merchant/Index.aspx?IsTest=1&"
  end

  it "should return correct pay_url" do
    @payment_interface.pay_url.should == "https://auth.robokassa.ru/Merchant/Index.aspx?IsTest=1&MerchantLogin=your_login&OutSum=1200.00&InvId=12&SignatureValue=ad504f1527d5c5ea3214eab1ad08f31a&shpfoo=bar"
  end

  it "should return correct pay_url when additional options passed" do
    @payment_interface.pay_url({description: "desc", culture: "ru", email: "foo@bar.com", currency: ""}).should == "https://auth.robokassa.ru/Merchant/Index.aspx?IsTest=1&MerchantLogin=your_login&OutSum=1200.00&InvId=12&SignatureValue=ad504f1527d5c5ea3214eab1ad08f31a&shpfoo=bar&IncCurrLabel=&Desc=desc&Email=foo@bar.com&Culture=ru"
  end

  it "should return correct initial_options" do
    @payment_interface.initial_options.should == {
      login: "your_login",
      total: 1200.00,
      invoice_id: 12,
      signature: "ad504f1527d5c5ea3214eab1ad08f31a",
      shpfoo: "bar"
    }
  end

  it "should return correct test_mode?" do
    @payment_interface.test_mode?.should == true
  end
end
