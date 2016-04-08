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

  attr_accessor :data_from_block

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

  test "#cell passes arguments to the cell" do
    get 'show'
    assert_includes @response.body, "I am data from block"
  end
end
