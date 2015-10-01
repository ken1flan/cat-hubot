CronJob = require('cron').CronJob

module.exports = (robot) ->
  robot.hear /^((?!明日).)*天気/i, (msg) ->
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
      msg.reply message

  robot.hear /明日.*天気/i, (msg) ->
    robot.forecastDailyWeather (json) ->
      forecast = json['list']
      tomorrowDatetime = new Date(forecast[2]['dt'] * 1000)
      message = "明日の天気かにゃ？ " +
        robot.weatherLangData[forecast[1]['weather'][0]['id']] +
        "の予報になってるにゃ。"
      msg.reply message

  cronWeather = new CronJob '0 0 8,18 * * *', ->
    robot.forecast3hoursWeather (json) ->
      forecast = json['list']
      nextDateTime = new Date(forecast[0]['dt'] * 1000)
      nextNextDateTime = new Date(forecast[1]['dt'] * 1000)
      message =
        "天気はこれから" +
        nextDateTime.getHours() +
        "時まで" +
        robot.weatherLangData[forecast[0]['weather'][0]['id']] +
        "、そのあと" +
        nextNextDateTime.getHours() +
        "時まで" +
        robot.weatherLangData[forecast[1]['weather'][0]['id']] +
        "の予報になってるにゃ。"
      robot.sendRoom message
  cronWeather.start()
