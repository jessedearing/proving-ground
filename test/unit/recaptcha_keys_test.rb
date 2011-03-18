require 'test_helper'

class RecaptchaKeysTest < ActiveSupport::TestCase
  test "Recaptcha keys are read correctly" do
    assert "6Ledh7wSAAAAAPAlhuq_x03-U_ZigW69sTw2ozm7", RCC_PUB
    assert "6Ledh7wSAAAAAJPygQVUunDv7jhkHlPS8EeQ0Kx9", RCC_PRIV
  end
end
