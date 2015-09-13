CronJob = require('cron').CronJob
ROOM_ID = process.env.HUBOT_IDOBATA_DEFAULT_ROOM_ID

module.exports = (robot) ->
  robot.hear /天気/i, (msg) ->
    request = msg.
      http('http://api.openweathermap.org/data/2.5/forecast?q=Tokyo,jp&mode=json&units=metric').
      get()
    request (err, res, body) ->
      json = JSON.parse body
      city = json['city']['name']
      forecast = json['list'][0]
      message =
        "天気ですか？ " +
        city + "はこれから" +
        forecast['weather'][0]['main'] + "(" +
        forecast['weather'][0]['description'] + ")" +
        "の予報になっていますにゃ。"
      msg.reply message

  # for idobata
  robot.send_room = (msg) ->
    envelope = { message: { data: {room_id: ROOM_ID } } }
    @send envelope, msg

  cron_weather = new CronJob '0 0 8,18 * * *', ->
    request = robot.
      http('http://api.openweathermap.org/data/2.5/forecast?q=Tokyo,jp&mode=json&units=metric').
      get()
    request (err, res, body) ->
      json = JSON.parse body
      city = json['city']['name']
      forecast = json['list'][0]
      message =
        city + "の天気はこれから" +
        forecast['weather'][0]['main'] + "(" +
        forecast['weather'][0]['description'] + ")" +
        "の予報になっていますにゃ。"
      robot.send_room  message
  cron_weather.start()
