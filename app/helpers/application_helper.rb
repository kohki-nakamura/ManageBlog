module ApplicationHelper
	def encode_sjis(str)
    str ||= ""
    str.gsub(REPLACE_KEYS, CONVERSIONS)
    str.encode("Windows-31J","UTF-8",:invalid => :replace,:undef=>:replace).encode("UTF-8","Windows-31J")
	end

	CONVERSIONS = {
    "\u301c" => "\uff5e", # wave-dash
    "\u2212" => "\uff0d", # full-width minus
    "\u00a2" => "\uffe0", # cent sign
    "\u00a3" => "\uffe1", # pound sign
    "\u00ac" => "\uffe2", # not sign
    "\u2013" => "\uff0d",
    "\u2014" => "\u2015", # full-width dash
    "\u2016" => "\u2225", # double vertical line
    "\u203e" => "\uffe3",
    "\u00a0" => "\u0020",
    "\u00f8" => "\u03a6",
    "\u203a" => "\u3009",
  }

	REPLACE_KEYS = /[#{CONVERSIONS.keys.join}]/
end
