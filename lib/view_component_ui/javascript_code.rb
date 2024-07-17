module ViewComponentUI
  class JavascriptCode
    def initialize(code)
      @code = code
    end

    attr_reader :code

    def to_s
      return code.to_s unless code.is_a? Hash

      hash_content = code.map do |k, v|
        k =  "'#{k}'" unless k.is_a?(JavascriptCode)
        v =  "'#{v}'" unless v.is_a?(JavascriptCode)

        "#{k}: #{v}"
      end.join(", ")

      "{ #{hash_content} }"
    end

    def to_json
      to_s.to_json
    end
  end
end
