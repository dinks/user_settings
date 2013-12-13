/* global $, jQuery */

(function($) {
  $.userSettings = function(url) {
    var baseUrl = url;

    var executor = function(options) {
      var deferred = new $.Deferred();

      if ($.isFunction(options.callback)) {
        deferred.then(options.callback);
      }

      var dataToSend = $.extend({
                          t: Date.now()
                        }, options.params);

      $.ajax({
        url: baseUrl + options.key,
        dataType: 'json',
        type: options.requestType,
        data: dataToSend
      }).then(function(data) {
        deferred.resolve(data);
      }).fail(function(data){
        deferred.reject(data);
      });

      return deferred.promise();
    };

    // $.userSettings.get('test').then(function(a){console.log(a);}).fail(function(f){console.log(f);});
    var get = function(key, callback) {
      return executor({
        key: key,
        requestType: 'GET',
        callback: callback
      });
    };

    var set = function(key, value, callback) {
      return executor({
        key: key,
        params: {
          value: value
        },
        requestType: 'POST',
        callback: callback
      });
    };

    var setOnce = function(key, value, callback) {
      return executor({
        key: key,
        params: {
          value: value
        },
        requestType: 'PUT',
        callback: callback
      });
    };

    var remove = function(key, callback) {
      return executor({
        key: key,
        requestType: 'DELETE',
        callback: callback
      });
    };

    return {
      get: get,
      set: set,
      setOnce: setOnce,
      remove: remove
    };
  };
})(jQuery);
