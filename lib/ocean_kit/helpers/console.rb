# frozen_string_literal: true

def pastel
  Pastel.new
end

def default_text(text)
  pastel.white(text)
end

def underline_text(text)
  pastel.white.bold.underline(text)
end

def bold_text(text)
  pastel.white.bold(text)
end
