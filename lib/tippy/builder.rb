class String
	def number?
		return true if self =~ /[+-]?([0-9]*[.])?[0-9]+/
	end
end

module Tippy
	class Builder
		@@const_hash = { "HIGH" => 25.0, "LOW" => 15.0, "STANDARD" => 18.0, "ZERO" => 0.0 }
		def initialize(total:, gratuity:)
			@total = total.to_i
			@gratuity = gratuity
		end

		def generate
			return calculation if number_based?
			@gratuity = string_based?
			calculation
		end

		private
		def number_based?
			if (@gratuity.is_a? Numeric or @gratuity.number?)
				@gratuity = @gratuity.to_f
				return true
			end
			false
		end

		def string_based?
			gratuity = @gratuity.upcase
			return @@const_hash[gratuity] if @@const_hash.has_key? gratuity
			return @@const_hash["ZERO"]
		end

		def calculation
			return @total + (@total * @gratuity / 100)
		end

	end
end
