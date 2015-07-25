/*
 * Copyright (c) 2012, IDM
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright notice, this list of
 *       conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright notice, this list
 *       of conditions and the following disclaimer in the documentation and/or other materials
 *       provided with the distribution.
 *     * Neither the name of the IDM nor the names of its contributors may be used to endorse or
 *       promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Author: Arnaud de Bossoreille
 */

SkPublishAPI = function(baseUrl, accessKey) {
    this.setBaseUrl(baseUrl);
    this.setAccessKey(accessKey);
};

SkPublishAPI.prototype = {

    didYouMean : function(dictionaryCode, searchWord, entryNumber) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/search/didyoumean?q=';
        uri += encodeURIComponent(searchWord);
        var c = '&';
        if (entryNumber) {
            uri += c + 'entrynumber=' + entryNumber;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    executeRequest : function(request) {
        return this.requestHandler.executeRequest(request);
    },

    getAccessKey : function() {
        return this.accessKey;
    },

    getBaseUrl : function() {
        return this.baseUrl;
    },

    getDictionaries : function() {
        var request = this.prepareGetRequest(this.baseUrl + "dictionaries",
                this.accessKey);
        return this.executeRequest(request);
    },

    getDictionary : function(dictionaryCode) {
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        var request = this.prepareGetRequest(this.baseUrl + "dictionaries/"
                + dictionaryCode, this.accessKey);
        return this.executeRequest(request);
    },

    getEntry : function(dictionaryCode, entryId, format) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/entries/';
        uri += encodeURIComponent(entryId);
        var c = '?';
        if (format) {
            if (!this.isValidEntryFormat(format))
                return null;
            uri += c + 'format=' + format;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    getEntryPronunciations : function(dictionaryCode, entryId, lang) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/entries/';
        uri += encodeURIComponent(entryId);
        uri += '/pronunciations';
        var c = '?';
        if (lang) {
            if (!this.isValidEntryLang(lang))
                return null;
            uri += c + 'lang=' + lang;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    getNearbyEntries : function(dictionaryCode, entryId, entryNumber) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/entries/';
        uri += encodeURIComponent(entryId);
        uri += '/nearbyentries';
        var c = '?';
        if (entryNumber) {
            uri += c + 'entrynumber=' + entryNumber;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    getRelatedEntries : function(dictionaryCode, entryId) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/entries/';
        uri += encodeURIComponent(entryId);
        uri += '/relatedentries';
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    getRequestHandler : function() {
        return this.requestHandler;
    },

    getThesaurusList : function(dictionaryCode) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/topics/';
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    getTopic : function(dictionaryCode, thesName, topicId) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/topics/';
        uri += encodeURIComponent(thesNameId);
        uri += '/';
        uri += encodeURIComponent(topicId);
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    getWordOfTheDay : function(dictionaryCode, day, format) {
        var uri = this.baseUrl;
        if (dictionaryCode) {
            if (!this.isValidDictionaryCode(dictionaryCode))
                return null;
            uri += 'dictionaries/' + dictionaryCode + '/';
        }
        uri += 'wordoftheday';
        var c = '?';
        if (day) {
            if (!this.isValidWotdDay(day))
                return null;
            uri += c + 'day=' + day;
            c = '&';
        }
        if (format) {
            if (!this.isValidEntryFormat(format))
                return null;
            uri += c + 'format=' + format;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    getWordOfTheDayPreview : function(dictionaryCode, day) {
        var uri = this.baseUrl;
        if (dictionaryCode) {
            if (!this.isValidDictionaryCode(dictionaryCode))
                return null;
            uri += 'dictionaries/' + dictionaryCode + '/';
        }
        uri += 'wordoftheday/preview';
        var c = '?';
        if (day) {
            if (!this.isValidWotdDay(day))
                return null;
            uri += c + 'day=' + day;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    isValidDictionaryCode : function(code) {
        if (code.length < 1)
            return false;
        for ( var i = 0; i < code.length; ++i) {
            var c = code.charAt(i);
            // Make sure no param are injected
            if (c == '/' || c == '%')
                return false;
            if (c == '*' || c == '$')
                return false;
        }
        return true;
    },

    isValidEntryFormat : function(format) {
        for ( var i = 0; i < format.length; ++i) {
            var c = format.charAt(i);
            // Make sure no param are injected
            if (c == '/' || c == '%')
                return false;
        }
        return true;
    },

    isValidEntryLang : function(lang) {
        for ( var i = 0; i < lang.length; ++i) {
            var c = lang.charAt(i);
            // Make sure no param are injected
            if (c == '/' || c == '%')
                return false;
        }
        return true;
    },

    isValidWotdDay : function(day) {
        for ( var i = 0; i < day.length; ++i) {
            var c = day.charAt(i);
            // Make sure no param are injected
            if (c == '/' || c == '%')
                return false;
        }
        return true;
    },

    prepareGetRequest : function(uri, accessKey) {
        return this.requestHandler.prepareGetRequest(uri, accessKey);
    },

    search : function(dictionaryCode, searchWord, pageSize, pageIndex) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/search?q=';
        uri += encodeURIComponent(searchWord);
        var c = '&';
        if (pageSize) {
            uri += c + 'pagesize=' + pageSize;
            c = '&';
        }
        if (pageIndex) {
            uri += c + 'pageindex=' + pageIndex;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    searchFirst : function(dictionaryCode, searchWord, format) {
        var uri = this.baseUrl;
        if (!this.isValidDictionaryCode(dictionaryCode))
            return null;
        uri += 'dictionaries/' + dictionaryCode + '/search/first?q=';
        uri += encodeURIComponent(searchWord);
        var c = '&';
        if (format) {
            if (!this.isValidEntryFormat(format))
                return null;
            uri += c + 'format=' + format;
            c = '&';
        }
        var request = this.prepareGetRequest(uri, this.accessKey);
        return this.executeRequest(request);
    },

    setAccessKey : function(accessKey) {
        this.accessKey = accessKey;
    },

    setBaseUrl : function(baseUrl) {
        if (baseUrl.substring(-1) == "/")
            this.baseUrl = baseUrl;
        else
            this.baseUrl = baseUrl + "/";
    },

    setRequestHandler : function(requestHandler) {
        this.requestHandler = requestHandler;
    }

};
