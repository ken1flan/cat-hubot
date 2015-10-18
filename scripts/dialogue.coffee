DOCOMO_API_KEY = process.env.DOCOMO_API_KEY
DIALOGUE_API_URL = 'https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=' + DOCOMO_API_KEY

module.exports = (robot) ->
  robot.responseDialogue = (user_talk, proc) ->
    context = robot.brain.get('dialogue_context')
    data = JSON.stringify({
      utt: user_talk,
      context: context
    })
    request = robot.http(DIALOGUE_API_URL)
      .header('Content-Type', 'application/json')
      .post(data)
    request (err, res, body) ->
      json = JSON.parse body
      robot.brain.set('dialogue_context', json['context'])
      proc(json)

  robot.hear /^((?!天気).)*$/i, (msg) ->
    robot.responseDialogue msg.match[0], (json) ->
      response = robot.kitteninze(json['utt'])
      msg.reply response
