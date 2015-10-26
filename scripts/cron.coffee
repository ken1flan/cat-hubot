CronJob = require('cron').CronJob

module.exports = (robot) ->
  cronGoodMorning = new CronJob '0 30 7 * * *', ->
    robot.sendRoom "おはにゃうございますー"
  cronGoodMorning.start()
  cronCheers = new CronJob '0 30 18 * * *', ->
    robot.sendRoom "おつかれさまにゃー"
  cronCheers.start()
  cronGoodNight = new CronJob '0 0 0 * * *', ->
    robot.sendRoom "おにゃすみにゃさーい"
  cronGoodNight.start()
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
