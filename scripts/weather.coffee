CronJob = require('cron').CronJob
ROOM_ID = process.env.HUBOT_IDOBATA_DEFAULT_ROOM_ID
WEATHER_LANG_DATA = {
  "200": "小雨と雷雨",
  "201": "雨と雷雨",
  "202": "雨と雷雨",
  "210": "光雷雨",
  "211": "雷雨",
  "212": "重い雷雨",
  "221": "ぼろぼろ雷雨",
  "230": "小雨と雷雨",
  "231": "雷雨で霧雨",
  "232": "重い霧雨と雷雨",
  "300": "強度の光の霧雨",
  "301": "霧雨",
  "302": "重い強度霧雨",
  "310": "強度の光の霧雨の雨",
  "311": "霧雨の雨",
  "312": "重い強度雨霧雨",
  "313": "シャワーの雨と霧雨",
  "314": "重いシャワーの雨と霧雨",
  "321": "霧雨シャワー",
  "500": "小雨",
  "501": "適度な雨",
  "502": "重い強度の雨",
  "503": "非常に激しい雨",
  "504": "極端な雨",
  "511": "冷たい雨",
  "520": "強度光レインシャワー",
  "521": "にわか雨",
  "522": "重い強度のレインシャワー",
  "531": "ぼろぼろのレインシャワー",
  "600": "小雪",
  "601": "雪",
  "602": "大雪",
  "611": "みぞれ",
  "612": "シャワーみぞれ",
  "615": "光雨と雪",
  "616": "雨と雪",
  "620": "小雪シャワー",
  "621": "雪のシャワー",
  "622": "大雪シャワー",
  "701": "ミスト",
  "711": "煙",
  "721": "ヘイズ",
  "731": "砂、ほこりの渦巻き",
  "741": "霧",
  "751": "砂",
  "761": "ほこり",
  "762": "火山灰",
  "771": "スコール",
  "781": "竜巻",
  "800": "晴天",
  "801": "少数の雲",
  "802": "千切れ雲",
  "803": "壊れた雲",
  "804": "曇り雲",
  "900": "竜巻",
  "901": "熱帯暴風雨",
  "902": "ハリケーン",
  "903": "冷たいです",
  "904": "ホット",
  "905": "風の強いです",
  "906": "雹",
  "951": "穏やかな",
  "952": "軽風",
  "953": "そよ風",
  "954": "和風",
  "955": "疾風",
  "956": "雄風",
  "957": "強風の近くに、強風",
  "958": "強風",
  "959": "重度の強風",
  "960": "嵐",
  "961": "激しい嵐",
  "962": "ハリケーン",
}

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
        "これから" +
        WEATHER_LANG_DATA[forecast['weather'][0]['id']] +
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
        "天気はこれから" +
        WEATHER_LANG_DATA[forecast['weather'][0]['id']] +
        "の予報になっていますにゃ。"
      robot.send_room  message
  cron_weather.start()
