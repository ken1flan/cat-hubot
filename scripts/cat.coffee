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
  robot.hear /(hello)|(こんにちは)|(こんにちわ)/i, (res) ->
    res.send "こんにゃちはー"
  robot.respond /(ありがと)|(サンキュ)|(さんきゅ)/i, (res) ->
    res.send "うんにゃー"
