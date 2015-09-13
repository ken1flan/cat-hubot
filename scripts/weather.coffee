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
