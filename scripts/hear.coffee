module.exports = (robot) ->
  robot.hear /^.*$/m, (res) ->
    message = res.match[0]
    if message.match(/天気/)
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
    else
      robot.responseDialogue message, (json) ->
        response = robot.kitteninze(json['utt'])
        res.reply response
