$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'bedi/grammars')))

require 'citrus'
require 'bedi/version'
require 'bedi/parsing_helpers'
require 'bedi/cielo'
require 'bedi/redecard'

module Bedi
end
