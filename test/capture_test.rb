require 'test_helper'

require 'cells-erb'

class MusiciansController < ActionController::Base
  append_view_path("test/views")

  def show
  end
end

class BassistCell < Cell::ViewModel
  include Cell::Rails::Capture
  include Cell::Erb

  self.view_paths = ['test/views']

  def content_for_test
    render
  end
end

class CaptureTest < ActionController::TestCase
  tests MusiciansController

  test "#content_for" do
    get 'show'
    assert_includes @response.body, "keep me!<pre>DummDooDiiDoo</pre>"
  end
end
