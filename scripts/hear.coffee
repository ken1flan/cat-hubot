module.exports = (robot) ->
  robot.hear /@([^+]+)\+\+/m, (res) ->
    target = res.match[1]
    robot.add_zabuton(target)

  robot.respond /list zabutons/i, (res) ->
    zabutons_array = robot.get_zabutons_array_order_by_count()
    for zabuton in zabutons_array
      res.reply "#{zabuton['name']}:#{zabuton['count']}"

  robot.respond /reset zabutons/i, (res) ->
    robot.reset_zabutons()
    res.reply 'reset zabutons'

  robot.hear /^.*$/mi, (res) ->
    message = res.match[0]
    if message.match(/(list zabutons)|(reset zabutons)|(@[^+]+\+\+)/)
      # skip
    else if message.match(/天気/)
      if message.match(/明日/)
        robot.forecastDailyWeather (json) ->
          forecast = json['list']
          tomorrowDatetime = new Date(forecast[2]['dt'] * 1000)
          message = "明日の天気かにゃ？ " +
            robot.weatherLangData[forecast[1]['weather'][0]['id']] +
            "の予報になってるにゃ。"
          res.reply message
      else
        robot.forecast3hoursWeather (json) ->
          forecast = json['list']
          nextDateTime = new Date(forecast[0]['dt'] * 1000)
          nextNextDateTime = new Date(forecast[1]['dt'] * 1000)
          message = "天気かにゃ？ " +
            "今から" +
            nextDateTime.getHours() +
            "時まで" +
            robot.weatherLangData[forecast[0]['weather'][0]['id']] +
            "、そのあと" +
            nextNextDateTime.getHours() +
            "時まで" +
            robot.weatherLangData[forecast[1]['weather'][0]['id']] +
            "の予報になってるにゃ。"
          res.reply message
    else if message.match(/おしえて|教えて/)
      robot.responseKnowledge message, (json) ->
        response = robot.kitteninze(json['message']['textForDisplay'])
        for answer, index in json['answers']
          response += "\n(" + answer['rank'] + "位)> ((≡ﾟ♀ﾟ≡))つ " + answer['linkUrl']
        res.reply response
    else
      robot.responseDialogue message, (json) ->
        response = robot.kitteninze(json['utt'])
        res.reply response
