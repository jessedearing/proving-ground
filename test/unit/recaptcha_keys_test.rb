require 'test_helper'

class RecaptchaKeysTest < ActiveSupport::TestCase
  test "Recaptcha keys are read correctly" do
    assert "6LfcvcMSAAAAADCYXDmaUaIELXr9GAifH3C_6M59", RCC_PUB
    assert "6LfcvcMSAAAAAMF_0oEVj6u9MTnF-njTC8qBeXJ0", RCC_PRIV
  end
end
