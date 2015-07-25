#
# Copyright (c) 2012, IDM
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted
# provided that the following conditions are met:
#
#   * Redistributions of source code must retain the above copyright notice, this list of
#     conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright notice, this list
#     of conditions and the following disclaimer in the documentation and/or other materials
#     provided with the distribution.
#   * Neither the name of IDM nor the names of its contributors may be used to endorse or
#     promote products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED+ IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Author: Daniel Perrett (Cambridge University Press)
#
# Revised: Maxime Loviton (IDM)
#


require 'net/http'
require 'net/https'
require 'uri'

class API

=begin 

=head1 NAME

SkPublish::API - This the Ruby implementation of SkPublish API

=end

@@VERSION = '0.1'

def initialize (baseUrl, accessKey, userAgent=nil)
    @baseUrl = baseUrl
    @accessKey = accessKey
    uri = URI.parse(@baseUrl)
    if (userAgent.nil?)
        userAgent = Net::HTTP.new(uri.host, uri.port)
    end
    @userAgent = userAgent
end


def getDictionaries
    request = self.prepareGetRequest('dictionaries/')
    response = self.executeRequest(request)
    return response
end

def prepareGetRequest (uri)
    request = Net::HTTP::Get.new(@baseUrl+uri)
    request.add_field("accessKey", accessKey)
    return request
end

def executeRequest (request)
    response = @userAgent.start() {|http|
        http.request(request)
    }
    return response.body
end

def isValidDictionaryCode (code)
    if(code.length < 1)
        return 0
    end
    for i in 0 .. code.length
        c = code[i]
        # Make sure no param are injected
        if(c == '/' || c == '%')
            return 0
        end
        if(c == '*' || c == '@')
            return 0
        end
    end
    return 1
end

def isValidEntryFormat (format)
    for i in 0 .. format.length
        c = format[i]
        # Make sure no param are injected
        if(c == '/' || c == '%')
            return 0
        end
    end
    return 1
end


def isValidEntryLang (lang)
    for i in 0 .. lang.length
        c = lang[i]
        # Make sure no param are injected
        if(c == '/' || c == '%')
            return 0
        end
    end
    return 1
end

def isValidWotdDay (day)
    for i in 0 .. day.length
        c = day[i]
        # Make sure no param are injected
        if(c == '/' || c == '%')
            return 0
        end
    end
    return 1
end


def getDictionary (dictionaryCode)
    if( not self.isValidDictionaryCode(dictionaryCode))
        return
    end
    request = self.prepareGetRequest('dictionaries/'+dictionaryCode)
    return self.executeRequest(request)
end

def getEntry (dictionaryCode, entryId, format=nil)
    if( not self.isValidDictionaryCode(dictionaryCode))
        return
    end
    uri = 'dictionaries/'+dictionaryCode+'/entries/'+ URI.encode(entryId)
    c = '?'
    if(not format.nil?)
        if( not self.isValidEntryFormat(format))
            return
        end
        uri += c+'format='+format
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def getEntryPronunciations (dictionaryCode, entryId, lang=nil)
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri = 'dictionaries/'+dictionaryCode+'/entries/' + URI.encode(entryId) + '/pronunciations'
    c = '?'
    if(not lang.nil?) 
        if( not self.isValidEntryLang(lang)) 
            return nil
        end
        uri += c+'lang='+lang
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def getNearbyEntries (dictionaryCode, entryId, entryNumber=nil)
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri = 'dictionaries/' + dictionaryCode + '/entries/'+ URI.encode(entryId) + '/nearbyentries'
    c = '?'
    if(not entryNumber.nil?) 
        uri += c+'entrynumber='+ String(entryNumber)
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def getRelatedEntries (dictionaryCode, entryId)
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri = 'dictionaries/' + dictionaryCode + '/entries/' + URI.encode(entryId) + '/relatedentries'
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def getThesaurusList (dictionaryCode)
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri = 'dictionaries/' + dictionaryCode + '/topics/'
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def getTopic (dictionaryCode, thesName, topicId)
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri = 'dictionaries/' + dictionaryCode + '/topics/' + URI.encode(thesName) + '/' + URI.encode(topicId)
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end


def getWordOfTheDay (dictionaryCode=nil, day=nil, format=nil)
    uri = ''
    if(not dictionaryCode.nil?) 
        if( not self.isValidDictionaryCode(dictionaryCode)) 
            return nil
        end
        uri += 'dictionaries/'+dictionaryCode+'/'
    end
    uri += 'wordoftheday/preview'
    c = '?'
    if(not day.nil?) 
        if( not self.isValidWotdDay(day)) 
            return nil
        end
        uri += c+'day='+day
        c = '&'
    end
    if(not format.nil?) 
        if( not self.isValidEntryFormat(format)) 
            return nil
        end
        uri += c+'format='+format
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def getWordOfTheDayPreview (dictionaryCode=nil, day=nil)
    uri = ''
    if(not dictionaryCode.nil?) 
        if( not self.isValidDictionaryCode(dictionaryCode)) 
            return nil
        end
        uri += 'dictionaries/'+dictionaryCode+'/'
    end
    uri += 'wordoftheday/preview'
    c = '?'
    if(not day.nil?) 
        if( not self.isValidWotdDay(day)) 
            return nil
        end
        uri += c+'day='+day
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def search (dictionaryCode, searchWord, pageSize=nil, pageIndex=nil)
    uri = ''
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri += 'dictionaries/'+dictionaryCode+'/search?q='
    uri += URI.encode(searchWord)
    c = '&'
    if(not pageSize.nil?) 
        uri += c+'pagesize='+String(pageSize)
        c = '&'
    end
    if(not pageIndex.nil?) 
        uri += c+'pageindex='+String(pageIndex)
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def searchFirst (dictionaryCode, searchWord, format=nil)
    uri = ''
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri += 'dictionaries/'+dictionaryCode+'/search/first?q='
    uri += URI.encode(searchWord)
    c = '&'
    if(not format.nil?) 
        if( not self.isValidEntryFormat(format)) 
            return nil
        end
        uri += c+'format='+format
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

def didYouMean (dictionaryCode, searchWord, entryNumber=nil)
    uri = ''
    if( not self.isValidDictionaryCode(dictionaryCode)) 
        return nil
    end
    uri += 'dictionaries/'+dictionaryCode+'/search/didyoumean?q='
    uri += URI.encode(searchWord)
    c = '&'
    if(not entryNumber.nil?) 
        uri += c+'entrynumber='+String(entryNumber)
        c = '&'
    end
    request = self.prepareGetRequest(uri)
    return self.executeRequest(request)
end

attr_reader :baseUrl
attr_accessor :baseUrl
attr_reader :accessKey
attr_accessor :accessKey
attr_reader :userAgent
attr_accessor :userAgent

end
