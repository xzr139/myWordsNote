class Word < ActiveRecord::Base
  has_many :word_def, :foreign_key=>"title_id",:primary_key => "title"
end
