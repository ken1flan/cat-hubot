CronJob = require('cron').CronJob

module.exports = (robot) ->
  robot.hear /^((?!明日).)*天気/i, (msg) ->
    robot.forecast_3hours_weather (json) ->
      forecast = json['list']
      next_datetime = new Date(forecast[0]['dt'] * 1000)
      next_next_datetime = new Date(forecast[1]['dt'] * 1000)
      message = "天気かにゃ？ " +
        "今から" +
        next_datetime.getHours() +
        "時まで" +
        robot.weather_lang_data[forecast[0]['weather'][0]['id']] +
        "、そのあと" +
        next_next_datetime.getHours() +
        "時まで" +
        robot.weather_lang_data[forecast[1]['weather'][0]['id']] +
        "の予報になってるにゃ。"
      msg.reply message

  robot.hear /明日.*天気/i, (msg) ->
    robot.forecast_daily_weather (json) ->
      forecast = json['list']
      tomorrow_datetime = new Date(forecast[2]['dt'] * 1000)
      message = "明日の天気かにゃ？ " +
        robot.weather_lang_data[forecast[1]['weather'][0]['id']] +
        "の予報になってるにゃ。"
      msg.reply message

  cron_weather = new CronJob '0 0 8,18 * * *', ->
    robot.forecast_3hours_weather (json) ->
      forecast = json['list']
      next_datetime = new Date(forecast[0]['dt'] * 1000)
      next_next_datetime = new Date(forecast[1]['dt'] * 1000)
      message =
        "天気はこれから" +
        next_datetime.getHours() +
        "時まで" +
        robot.weather_lang_data[forecast[0]['weather'][0]['id']] +
        "、そのあと" +
        next_next_datetime.getHours() +
        "時まで" +
        robot.weather_lang_data[forecast[1]['weather'][0]['id']] +
        "の予報になってるにゃ。"
      robot.send_room message
  cron_weather.start()
