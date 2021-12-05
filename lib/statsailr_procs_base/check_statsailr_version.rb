module StatSailr
  module ProcsBase
    def self.check_statsailr_version
      statsailr_version = StatSailr::VERSION
      statsailr_version_at_least = "0.7.6"
      return version_should_be_at_least( statsailr_version , statsailr_version_at_least ) 
    end

    def self.version_should_be_at_least( gem_version, str_version )
      if( Gem::Version.new(gem_version) >= Gem::Version.new(str_version) )
        return true
      else
        puts "\e[1m" + "WARNING: statsailr gem (#{gem_version}) needs to be newer or equal to ver. #{str_version}" + "\e[22m"
        return false
      end
    end
  end
end
