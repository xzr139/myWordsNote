class WordDef < ActiveRecord::Base
  belongs_to :word, :foreign_key=>"title_id", :primary_key => "title"
end
