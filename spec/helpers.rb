module Helpers
  def fixture_file(filename)
    path = File.join(File.dirname(__FILE__), 'fixtures', filename)
    File.open(path)
  end
end
