(function() {
  (function() {
    'use strict';
    $(document).ready(function() {
      var eventHTML, events, opt;
      eventHTML = void 0;
      events = void 0;
      opt = void 0;
      events = [
        {
          id: 1,
          year: 1988,
          month: 7,
          day: 20,
          subject: '武山生誕'
        }, {
          id: 3,
          year: 1990,
          month: 12,
          day: 26,
          subject: 'ほげほげ'
        }, {
          id: 3,
          year: 2000,
          month: 12,
          day: 26,
          subject: 'ほげほげ'
        }, {
          id: 5,
          year: 2005,
          month: 4,
          day: 1,
          subject: '大学'
        }, {
          id: 5,
          year: 2006,
          month: 4,
          day: 1,
          subject: '大学'
        }, {
          id: 4,
          year: 2007,
          month: 4,
          day: 1,
          subject: '大学'
        }, {
          id: 2,
          year: 2015,
          month: 12,
          day: 26,
          subject: '開発合宿開発合宿開発合宿開発合宿開発合宿開発合宿開発合宿'
        }
      ];
      opt = {
        startYear: events[0].year,
        endYear: events[events.length - 1].year,
        range: events[events.length - 1].year - events[0].year,
        showCaseWidth: $('.eventNav').width() - 48
      };
      eventHTML = '';
      $.each(events, function(i, event) {
        var left;
        left = void 0;
        if (i !== event.length - 1) {
          left = opt.showCaseWidth / opt.range * (event.year - opt.startYear);
        }
        return eventHTML = eventHTML + '<li class=\'animated fadeIn\' style=\'left:' + left + 'px\' id=\'event_' + event.id + '\'>' + '<div class=\'time\'>' + event.year + '</div><div class=\'point\'></div>' + '<h3>' + event.subject + '</h3>' + '</li>\r\n';
      });
      return $('.eventNav ul').append(eventHTML);
    });
  }).call(this);

}).call(this);
