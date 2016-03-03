ZABUTONS_KEY = 'zabutons'

module.exports = (robot) ->
  robot.get_zabutons = () ->
    zabutons_json_string = robot.brain.get(ZABUTONS_KEY)
    zabutons_json_string ||= "{}"
    return (JSON.parse zabutons_json_string)

  robot.set_zabutons = (json) ->
    json_string = JSON.stringify json
    robot.brain.set(ZABUTONS_KEY, json_string)

  robot.add_zabuton = (target) ->
    zabutons = robot.get_zabutons()
    zabutons[target] ||= 0
    zabutons[target]++
    robot.set_zabutons(zabutons)

  robot.reset_zabutons = () ->
    robot.set_zabutons({})

  robot.get_zabutons_array_order_by_count = () ->
    zabutons = robot.get_zabutons()
    zabutons_array = []
    for name, count of zabutons
      zabutons_array.push({'name' : name, 'count' : count})
    zabutons_array.sort (a, b) ->
      b['count'] - a['count']
