ZABUTONS_KEY = 'zabutons'

module.exports = (robot) ->
  robot.getZabutons = () ->
    zabutonsJsonString = robot.brain.get(ZABUTONS_KEY)
    zabutonsJsonString ||= "{}"
    return (JSON.parse zabutonsJsonString)

  robot.setZabutons = (json) ->
    jsonString = JSON.stringify json
    robot.brain.set(ZABUTONS_KEY, jsonString)

  robot.addZabuton = (target) ->
    zabutons = robot.getZabutons()
    zabutons[target] ||= 0
    zabutons[target]++
    robot.setZabutons(zabutons)

  robot.resetZabutons = () ->
    robot.setZabutons({})

  robot.getZabutonsArrayOrderByCount = () ->
    zabutons = robot.getZabutons()
    zabutonsArray = []
    for name, count of zabutons
      zabutonsArray.push({'name' : name, 'count' : count})
    zabutonsArray.sort (a, b) ->
      b['count'] - a['count']
