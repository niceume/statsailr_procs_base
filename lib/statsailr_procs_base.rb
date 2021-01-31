# frozen_string_literal: true

require_relative "statsailr_procs_base/version"
require_relative "statsailr_procs_base/path"
require_relative "statsailr_procs_base/check_statsailr_version"

module StatSailr
  module ProcsBase
    class Error < StandardError; end

    # Your code goes here...
  end
end

StatSailr::ProcsBase::check_statsailr_version()

