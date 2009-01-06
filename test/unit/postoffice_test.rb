require 'test_helper'

class PostofficeTest < ActionMailer::TestCase
  test "new_request" do
    @expected.subject = 'Postoffice#new_request'
    @expected.body    = read_fixture('new_request')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Postoffice.create_new_request(@expected.date).encoded
  end

end
