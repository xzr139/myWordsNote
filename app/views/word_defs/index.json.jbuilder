json.array!(@word_defs) do |word_def|
  json.extract! word_def, :id, :title, :en, :jp, :eg
  json.url word_def_url(word_def, format: :json)
end
