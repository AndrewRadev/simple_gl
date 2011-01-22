module SimpleGl
  module Helpers
    def camel_case(string)
      string.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }
    end
  end
end
