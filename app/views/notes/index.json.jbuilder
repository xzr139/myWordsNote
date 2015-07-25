json.array!(@notes) do |note|
  json.extract! note, :id, :name, :comment, :mark
  json.url note_url(note, format: :json)
end
