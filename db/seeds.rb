# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    User.create!(:name => "admin", :password => "123456", :password_confirmation => "123456")
    
    Note.create!(:name => "myNote1", :comment => "this is my first note", :mark => 1)
    
    Word.create!(:title => "apple", :pos => "noun", :pron => "https://dictionary.cambridge.org/media/english-japanese/uk_pron/u/uka/ukapp/ukappen014.mp3", :ipa => "æp·l", :note_id => 1 )
    
    WordDef.create!(:title_id => "apple", :en => "a hard, round fruit with a green or red skin", :jp => "リンゴ", :eg => "an apple pie")
    

