DOCOMO_API_KEY = process.env.DOCOMO_API_KEY

DIALOGUE_API_URL = 'https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=' + DOCOMO_API_KEY
DIALOGUE_CONTEXT_PERIOD = process.env.DOCOMO_API_DIALOGUE_CONTEXT_PERIOD
DIALOGUE_CONTEXT_PERIOD = 1000 * 60 * 6 if (!DIALOGUE_CONTEXT_PERIOD)
KNOWLEDGE_API_URL = 'https://api.apigw.smt.docomo.ne.jp/knowledgeQA/v1/ask?APIKEY=' + DOCOMO_API_KEY

module.exports = (robot) ->
  robot.responseDialogue = (user_talk, proc) ->
    context = robot.brain.get('dialogue_context')
    lastTime = robot.brain.get('dialogue_last_time')
    lastTime = 0 if lastTime == null
    currentDateTime = new Date
    currentTime =  currentDateTime.getTime()
    context = "" if currentTime - lastTime > DIALOGUE_CONTEXT_PERIOD
    data = JSON.stringify({
      utt: user_talk,
      context: context
    } )
    request = robot.http(DIALOGUE_API_URL)
      .header('Content-Type', 'application/json')
      .post(data)
    request (err, res, body) ->
      json = JSON.parse body
      robot.brain.set('dialogue_context', json['context'])
      robot.brain.set('dialogue_last_time', currentTime)
      lastTime = robot.brain.get('dialogue_last_time')
      proc(json)

  robot.responseKnowledge = (user_talk, proc) ->
    user_talk_encoded = encodeURIComponent(user_talk)
    request = robot.http(KNOWLEDGE_API_URL + '&q=' + user_talk_encoded)
      .header('Content-Type', 'application/json')
      .get()
    request (err, res, body) ->
      json = JSON.parse body
      robot.brain.set('dialogue_context', json['context'])
      proc(json)
