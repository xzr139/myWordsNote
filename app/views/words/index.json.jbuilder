json.array!(@words) do |word|
  json.extract! word, :id, :title, :pos, :pron, :ipa
  json.url word_url(word, format: :json)
end
