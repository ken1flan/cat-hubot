ROOM_ID = process.env.HUBOT_IDOBATA_DEFAULT_ROOM_ID

module.exports = (robot) ->
  robot.respond /ROOM_ID/i, (msg) ->
    message =
      "idobataのROOM_IDですか？ " +
      msg.message.data.room_id +
      "ですにゃ。"
    msg.reply message

  robot.send_room = (msg) ->
    envelope = { message: { data: {room_id: ROOM_ID } } }
    @send envelope, msg
