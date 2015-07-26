require "API.rb"
require "json"
require 'rexml/document'

class WordsController < ApplicationController
  before_filter :set_word, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :search
  protect_from_forgery except: :search_suggest
  layout "note"
  
  # GET /words
  # GET /words.json
  def index
    @words = Word.all
    session[:return_to] = "/words/"
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    
    flag = true  
    t = params[:note]
    @word = Word.new(:title => params[:word][:title], :pos =>params[:word][:pos], :pron => params[:word][:pron], :ipa => params[:word][:ipa], :note_id => params[:note][0] )
    if !@word.save 
      flag = false
    else
      for num in 1..params[:word][:en].length do  
        @word_def = WordDef.new(:title_id => params[:word][:title], :en => params[:word][:en][num-1], :jp => params[:word][:jp][num-1], :eg => params[:word][:eg][num-1])
        if !@word_def.save
          flag = false
          break
        end
      end
    end
    
    respond_to do |format|
      if flag
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.word_def.each do |data|
      data.destroy
    end
    @word.destroy
    respond_to do |format|
      
      format.html { redirect_to session[:return_to], notice: 'Word was successfully destroyed.'  }
      format.json { head :no_content }
    end
  end
  
  def search
    
    @note = Note.all
    
    @word = Word.find_by_title(params[:word])
     if @word != nil
       redirect_to @word
     else
       @word = Word.new  
     end
    
    baseUrl= "http://www.dictionaryapi.com/api/v1/references/sd4/xml/"+params[:word]+"?key=7b6540c6-117a-4264-8c39-070748265b39";
    uri = URI.parse(baseUrl);
    userAgent = Net::HTTP.new(uri.host, uri.port);
    req = Net::HTTP::Get.new(uri.request_uri);
    response = userAgent.request(req);
    doc = REXML::Document.new(response.body)
    
    @title = params[:word]
    
    @en = Array.new
    @jp = Array.new
    @eg = Array.new
    
    i=0
    doc.elements.each('entry_list/entry') do |entry|
      if entry.attributes['id'].include? params[:word]+'[' or entry.attributes['id'] == params[:word] 
        if i == 3
          break;
        end
        if entry.elements['def/dt'].text.to_s == ' ' or entry.elements['def/dt'].text.to_s == ':'
          next;
        end    
        
        p = entry.elements['def/dt'].text.to_s.gsub!(/:/,'')
        if p == nil
          @en.push entry.elements['def/dt'].text.to_s
        else
          @en.push p
        end   
        @jp.push entry.elements['fl'].text.to_s
        i+=1
        
        if entry.elements['def/dt/vi']
          t = entry.elements['def/dt/vi'].to_s
          t.gsub!(/<vi>/,'')
          t.gsub!(/<it>/,'')
          t.gsub!(/<\/vi>/,'')
          t.gsub!(/<\/it>/,'')
          @eg.push t
        else
          @eg.push ''
        end
      end
     end
     
     if @en[0] == nil
       return
     end
     
     @ipa = doc.elements['entry_list/entry/pr'].text
     @pron = "http://media.merriam-webster.com/soundc11/"+params[:word][0]+'/'+doc.elements['entry_list/entry/sound/wav'].text
     @pos = doc.elements['entry_list/entry/fl'].text

     
end
  
  def search_suggest
    
    response = Unirest.get "https://montanaflynn-spellcheck.p.mashape.com/check/?text="+ params[:search],
    headers:{
      "X-Mashape-Key" => "u6IwQ3lgE9mshD9JiafFujdP2ltzp1TKoiajsnPKMG7XR8hAVA",
      "Accept" => "application/json"
    }
    
    temp = response.body["corrections"][params[:search]]
    if temp == nil
      temp = Array.new
    end
    temp.insert(0,params[:search]) 
    render json:temp.to_json   

  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:title, :pos, :pron, :ipa)
    end
end